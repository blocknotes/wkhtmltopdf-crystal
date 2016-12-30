module Wkhtmltopdf
  class WkImage
    FORMATS = [ "jpg", "png", "bmp", "svg" ]

    @glb_settings = Hash( String, String ).new
    @out = ""
    @url = ""
    @buffer = nil

    getter :buffer

    # Prepare the structure
    def initialize( path = "" )
      @glb_settings["fmt"] = "jpg"
      @out = @glb_settings["out"] = path unless path.empty?
    end

    # Set a setting value - see [pagePdfObject](http://wkhtmltopdf.org/libwkhtmltox/pagesettings.html#pageImageGlobal)
    def set( key : String, value : String )
      case key
      when "fmt"
        @glb_settings[key] = value if FORMATS.includes? value
      when "quality"
        val = value.to_i
        @glb_settings[key] = val.to_s if val > 0 && val <= 100
      else
        @glb_settings[key] = value
      end
    end

    # Set output path
    def set_output( path : String )
      unless path.empty?
        @out = path
        set "out", path
      end
    end

    # Set URL to fetch content from
    def set_url( url : String )
      unless url.empty?
        @url = url
        set "in", url
      end
    end

    # Start convertion - if `html` is omitted (nil) a URL to fetch is required
    def convert( html = nil )
      raise "No URL or HTML data specified" if @url.empty? && html.nil?
      ## init
      LibWkHtmlToImage.wkhtmltoimage_init 0
      @global_settings = LibWkHtmlToImage.wkhtmltoimage_create_global_settings
      @glb_settings.each do |k, v|
        LibWkHtmlToImage.wkhtmltoimage_set_global_setting @global_settings, k, v
      end
      @converter = LibWkHtmlToImage.wkhtmltoimage_create_converter @global_settings, html
      ## convert
      ret = LibWkHtmlToImage.wkhtmltoimage_convert( @converter )
      if ret > 0 && @out.empty?
        # Copy data in buffer
        len = LibWkHtmlToImage.wkhtmltoimage_get_output( @converter, out data )
        @buffer = Slice( UInt8 ).new( data, len )
      end
      ## deinit
      LibWkHtmlToImage.wkhtmltoimage_destroy_converter @converter
      LibWkHtmlToImage.wkhtmltoimage_deinit
      ret
    end
  end
end
