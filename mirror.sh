# rsync -avz --delete . \
# --exclude='.gi*' --exclude='*/.gi*' --exclude='ß.Rpro*' \
# sr320@gannet.fish.washington.edu:/volume2/web/e5-mosaic/



rsync -avz . \
--exclude='.gi*' --exclude='*/.gi*' --exclude='.Rpro*' \
sr320@gannet.fish.washington.edu:/volume2/web/e5-mosaic/