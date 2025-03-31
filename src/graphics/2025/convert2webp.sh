for el in *.png *.jpg ; do cwebp -q 80 $el -o $(basename $el).webp ; done
