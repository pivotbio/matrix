require 'rmagick'
require 'Rdmtx'
require 'pry'

module Decoder
  class GSPlateDecoder < Base

    TIMEOUT = 800 # ms

    # geometric constants
    S_x = 530
    S_y = 800
    S_bx = 26
    S_by = 34
    S_w = 180
    S_h = 180

    private

    def scan_plate
      rdmtx = Rdmtx.new
      well_images.map do |i, j, well|
        rdmtx.decode(well, TIMEOUT).first
      end
    end

    # yield wells as separate images
    def well_images
      Enumerator.new do |enum|
        12.times.map do |row|
          8.times.map do |col|
            x = S_x + (col * S_bx) + (col * S_w)
            y = S_y + (row * S_by) + (row * S_h)
            cell = image.crop(x, y, S_w, S_h)
            enum.yield(row, col, cell)
          end
        end
      end
    end
  end
end
