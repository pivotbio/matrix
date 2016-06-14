class ScanFailed < Exception
end

module Decoder
  class MatrixPlateDecoder < Base

    # geometric constants
    S_x  = 530
    S_y  = 800
    S_bx = 26
    S_by = 34
    S_w  = 180
    S_h  = 180
    CROP = 10

    def initialize(scan_path, kwargs={})
      @timeout = Integer(kwargs[:timeout] || 5)
      super(scan_path)
    end

    private

    def scan_plate
      result =
        well_images.map do |i, j, well|
          [ "#{(i+65).chr}#{j}", scan_well(well) ]
        end
      result = Hash[result]
    end

    def decoder
      @rdmtx ||= Rdmtx.new
    end

    def timeout
      @timeout
    end

    def scan_well well
      decoder.decode(well, timeout).first
    end

    # yield wells as separate images
    def well_images
      Enumerator.new do |enum|
        12.times.map do |row|
          8.times.each do |col|
            x = S_x + (col * S_bx) + (col * S_w)
            y = S_y + (row * S_by) + (row * S_h)
            cell = image.crop(x + CROP,
                              y + CROP,
                              S_w - CROP,
                              S_h - CROP).
                              contrast.
                              negate.
                              quantize(256)

            enum.yield([row, col, cell])
          end
        end
      end
    end
  end
end
