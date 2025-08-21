-- Lua filter to generate an HTML table of files in repository root 'data' directory
-- WITHOUT requiring external Lua modules (no lfs). Uses shell commands for portability.

-- Compute checksum with several fallback shell commands
local function checksum(path)
  local cmds = {
    "shasum -a 256 '"..path.."' 2>/dev/null | cut -d ' ' -f1",
    "sha256sum '"..path.."' 2>/dev/null | cut -d ' ' -f1",
    "md5 -q '"..path.."' 2>/dev/null"
  }
  for _, c in ipairs(cmds) do
    local h = io.popen(c)
    if h then
      local out = h:read("*l")
      h:close()
      if out and #out > 0 then return out end
    end
  end
  return "-"
end

-- Light YAML sidecar parser (basename + .yml) for description
local function read_sidecar_metadata(path)
  local file = io.open(path..".yml", 'r')
  if not file then return nil end
  local content = file:read('*a')
  file:close()
  local meta = {}
  for line in content:gmatch("[^\r\n]+") do
    local k,v = line:match("^([%w_]+):%s*(.+)%s*$")
    if k and v then meta[k] = v end
  end
  return meta
end

local function format_size(bytes)
  local units = {"B","KB","MB","GB","TB"}
  local i, size = 1, bytes
  while size and size > 1024 and i < #units do
    size = size / 1024
    i = i + 1
  end
  if not size then return "-" end
  return string.format("%.1f %s", size, units[i])
end

-- Attempt to list files with size + mtime (UTC epoch)
local function list_files(data_dir)
  local results = {}
  -- macOS/BSD stat format
  local cmd_macos = "find '"..data_dir.."' -maxdepth 1 -type f ! -name '*.yml' -exec stat -f '%N\t%z\t%m' {} + 2>/dev/null"
  local f = io.popen(cmd_macos)
  local output = f and f:read('*a') or ''
  if f then f:close() end
  if output == '' then
    -- GNU/Linux stat
    local cmd_linux = "find '"..data_dir.."' -maxdepth 1 -type f ! -name '*.yml' -exec stat -c '%n\t%s\t%Y' {} + 2>/dev/null"
    f = io.popen(cmd_linux)
    output = f and f:read('*a') or ''
    if f then f:close() end
  end
  if output == '' then
    -- very minimal fallback: just names via ls
    local ls = io.popen("ls -1 '"..data_dir.."' 2>/dev/null")
    for line in (ls and ls:lines() or function() return nil end) do
      if not line:match('%.yml$') then
        -- derive size
        local size_f = io.popen("wc -c < '"..data_dir.."/"..line.."' 2>/dev/null")
        local size = size_f and tonumber(size_f:read('*l')) or 0
        if size_f then size_f:close() end
        -- mtime (epoch) using stat fallback
        local mt
        local stat_try = io.popen("stat -f %m '"..data_dir.."/"..line.."' 2>/dev/null")
        if stat_try then mt = tonumber(stat_try:read('*l')); stat_try:close() end
        if not mt then
          stat_try = io.popen("stat -c %Y '"..data_dir.."/"..line.."' 2>/dev/null")
          if stat_try then mt = tonumber(stat_try:read('*l')) end
          if stat_try then stat_try:close() end
        end
        table.insert(results, {name=line, size=size or 0, mtime=mt or os.time(), description='', checksum=checksum(data_dir.."/"..line)})
      end
    end
  else
    for line in output:gmatch("[^\r\n]+") do
      local path, size, mtime = line:match("^(.-)\t(.-)\t(.-)$")
      if path and size and mtime then
        local name = path:match("/?([^/]+)$") or path
        if not name:match('%.yml$') then
          local meta = read_sidecar_metadata(path)
            table.insert(results, {
              name = name,
              size = tonumber(size) or 0,
              mtime = tonumber(mtime) or os.time(),
              description = meta and meta.description or '',
              checksum = checksum(path)
            })
        end
      end
    end
  end
  table.sort(results, function(a,b) return a.name < b.name end)
  return results
end

local function generate_table()
  local repo_root = pandoc.path.normalize(pandoc.path.join({pandoc.system.get_working_directory(), ".."}))
  local data_dir = repo_root .. "/data"
  -- Check data dir existence
  local test = io.open(data_dir.."/.exists_check", 'w')
  if not test then
    return '<em>No data directory found.</em>'
  else
    test:close()
    os.remove(data_dir.."/.exists_check")
  end
  local entries = list_files(data_dir)
  if #entries == 0 then return '<em>No files present in data/ yet.</em>' end
  local rows = {
    '<table class="table table-sm table-striped">',
    '<thead><tr><th>File</th><th>Description</th><th>Size</th><th>Modified (UTC)</th><th>SHA256</th></tr></thead>',
    '<tbody>'
  }
  for _, e in ipairs(entries) do
    local mtime = os.date('!%Y-%m-%d %H:%M', e.mtime)
    local href = '../data/' .. e.name
    local size = format_size(e.size)
    local desc = pandoc.text.escape(e.description or '')
    table.insert(rows, string.format('<tr><td><a href="%s">%s</a></td><td>%s</td><td>%s</td><td>%s</td><td style="font-family:monospace;">%s</td></tr>', href, e.name, desc, size, mtime, e.checksum))
  end
  table.insert(rows, '</tbody></table>')
  return table.concat(rows, '\n')
end

return {
  Pandoc = function(doc)
    for _, block in ipairs(doc.blocks) do
      if block.t == 'Para' then
        for j, inline in ipairs(block.content) do
          if inline.t == 'Str' and inline.text == '{{< data-file-table >}}' then
            block.content[j] = pandoc.RawInline('html', generate_table())
          end
        end
      end
    end
    return doc
  end
}
