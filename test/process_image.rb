filename = "../Scan_600.tiff"
output = "tmp/output"

# crop = `convert #{filename} -crop 1278x832+100+500 +repage #{output}_crop.tiff`
# rotate = `convert #{output}_crop.tiff -rotate -90 #{output}_crop_rotated.tiff`
# mask = `convert #{output}_crop_rotated.tiff mask_300.tiff -compose copy_opacity -composite -compose over -background black -flatten #{output}_masked.tiff`
# tiles = `convert #{output}_masked.tiff -crop 104x107 +repage +adjoin #{output}_tile_%d.tif`
# small = `convert '#{output}_tile_%d.tif[0-95]' -shave 15x15 #{output}_tile_small_%d.tif`  


crop = `convert #{filename} -crop 1664x2556+150+160 +repage #{output}_crop.tiff`
mask = `convert #{output}_crop.tiff mask_600.tiff -compose copy_opacity -composite -compose over -background black -flatten #{output}_masked.tiff`
tiles = `convert #{output}_masked.tiff -crop 208x213 +repage +adjoin #{output}_tile_%d.tif`
small = `convert '#{output}_tile_%d.tif[0-95]' -shave 30x30 #{output}_tile_small_%d.tif`  
