def decode_plate(filename)
  
  # Convert
  output = "tmp/output"
  crop = `convert #{filename} -crop 1278x832+100+500 +repage #{output}_crop.tiff`
  rotate = `convert #{output}_crop.tiff -rotate -90 #{output}_crop_rotated.tiff`
  mask = `convert #{output}_crop_rotated.tiff mask.tiff -compose copy_opacity -composite -compose over -background black -flatten #{output}_masked.tiff`
  tiles = `convert #{output}_masked.tiff -crop 104x107 +repage +adjoin #{output}_tile_%d.tif`
  small = `convert '#{output}_tile_%d.tif[0-95]' -shave 15x15 #{output}_tile_small_%d.tif`  

  # Decode
  codes = Array.new

  (0..95).each do |i|
    p i
    code = `dmtxread -S2 -e 30 -E 40 -s 12x12 -q 10 -t 10 -n #{output}_tile_small_#{i}.tif`
    if code == ""
      code_try_2 = `dmtxread -S2 -n #{output}_tile_small_#{i}.tif`
      if code_try_2 == ""
        code_try_3 = `dmtxread -n #{output}_tile_small_#{i}.tif`
        code = code_try_3
      else
        code = code_try_2
      end
    end
    codes << code.strip!
  end

  return codes
end