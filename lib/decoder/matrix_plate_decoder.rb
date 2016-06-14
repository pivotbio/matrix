class ScanFailed < Exception
end

module Decoder
  class MatrixPlateDecoder < Base

    TIMEOUT = 100 # ms

    # geometric constants
    S_x  = 530
    S_y  = 800
    S_bx = 26
    S_by = 34
    S_w  = 180
    S_h  = 180

    private

    def scan_plate
      well_images.map do |i, j, well|
        value = decode(well)
        well.write("#{i}-#{j}-#{value || 'nil'}.png")
        p value
        value
      end
    end

    def matrix_decoder
      ZXing
    end

    def decode well
      matrix_decoder.decode(well.path)
    end

    # yield wells as separate images
    def well_images
      Enumerator.new do |enum|
        12.times.map do |row|
          8.times.map do |col|
            x = S_x + (col * S_bx) + (col * S_w)
            y = S_y + (row * S_by) + (row * S_h)
            cell = image.
              crop("#{S_w}x#{S_h}+#{x}+#{y}").
              negate.
              contrast
            enum.yield(row, col, cell)
          end
        end
      end
    end
  end
end
