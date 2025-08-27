

rsync -avz . \
--exclude='.gi*' --exclude='*/.gi*' --exclude='.Rpro*' \
--exclude='docs' --exclude='quarto' \
sr320@gannet.fish.washington.edu:/volume2/web/e5-mosaic/