class DecodeError < StandardError
end

def system_or_error(command)
  system(command)or raise(DecodeError, "command failed: #{command}")
end

def decode_plate(filename)

  output = "tmp/output"

  # Convert: format = Scan_600.tiff
  crop = system_or_error "convert #{filename} -crop 1664x2556+165+188 +repage #{output}_crop.tiff"

  mask = system_or_error "convert #{output}_crop.tiff mask_600.tiff -compose copy_opacity -composite -compose over -background black -flatten #{output}_masked.tiff"

  tiles = system_or_error "convert #{output}_masked.tiff -crop 208x213 +repage +adjoin #{output}_tile_%d.tif"

  small = system_or_error "convert '#{output}_tile_%d.tif[0-95]' -shave 30x30 #{output}_tile_small_%d.tif"

  # Decode
  codes = Array.new

  (0..95).each do |i|
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
