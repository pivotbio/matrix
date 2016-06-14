module Decoder
  class Base
    def initialize scan_path
      @scan_path = scan_path
    end

    def codes
      @codes ||= scan_plate
    end

    private

    def scan_path
      @scan_path
    end

    def image
      @image ||= Magick::ImageList.new(scan_path)
    end

    def scan_plate
      raise NotImplementedError.new("Base decoder doesn't know how to decode anything.")
    end
  end
end
