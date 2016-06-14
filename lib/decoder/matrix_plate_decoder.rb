class ScanFailed < Exception
end

module Decoder
  class MatrixPlateDecoder < Base

    TIMEOUT = 500 # ms

    # geometric constants
    S_x  = 530
    S_y  = 800
    S_bx = 26
    S_by = 34
    S_w  = 180
    S_h  = 180
    CROP = 10

    private

    def scan_plate
      well_images.map do |i, j, well|
        value = scan_well(well)
        well.write("#{i}-#{j}-#{value || 'nil'}.png")
        value
      end
    end

    def decoder
      @rdmtx ||= Rdmtx.new
    end

    def scan_well well
      decoder.decode(well, TIMEOUT).first
    end

    # yield wells as separate images
    def well_images
      Enumerator.new do |enum|
        12.times.map do |row|
          8.times.map do |col|
            x = S_x + (col * S_bx) + (col * S_w)
            y = S_y + (row * S_by) + (row * S_h)
            cell = image.crop(x + CROP,
                              y + CROP,
                              S_w - CROP,
                              S_h - CROP).
                              contrast.
                              negate.
                              quantize(256)

            enum.yield(row, col, cell)
          end
        end
      end
    end
  end
end
