class ScanFailed < Exception
end

class PlateWell

  attr_accessor :row, :column

  def initialize row, column
    @row = row # A ... H
    @column = column # 1 ... 12
  end

  def <=> other
    # sort by row, then by column
    case row <=> other.row
    when 0
      column <=> other.column
    else
      row <=> other.row
    end
  end

  def to_s
    "#{row}#{column}"
  end
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
      well_images.map do |well, image|
        [ well, scan_image(image) ]
      end
    end

    def decoder
      @rdmtx ||= Rdmtx.new
    end

    def timeout
      @timeout
    end

    def scan_image image
      decoder.decode(image, timeout).first
    end

    # yield wells as separate images
    def well_images
      Enumerator.new do |enum|
        12.times.map do |row|
          8.times.each do |col|
            x = S_x + (col * S_bx) + (col * S_w)
            y = S_y + (row * S_by) + (row * S_h)
            well = PlateWell.new((col+65).chr, row+1)
            cell = image.crop(x + CROP,
                              y + CROP,
                              S_w - CROP,
                              S_h - CROP).
                              contrast.
                              negate.
                              quantize(256)

            enum.yield([well, cell])
          end
        end
      end
    end
  end
end
