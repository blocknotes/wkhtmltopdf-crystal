module Wkhtmltopdf
  class WkImage
    FORMATS = [ "jpg", "png", "bmp", "svg" ]

    @glb_settings = Hash( String, String ).new
    @url = ""

    # Prepare the structure
    def initialize( output = nil )
      @glb_settings["format"] = "jpg"
      @glb_settings["out"] = output ? output : "output.jpg"
    end

    # Set a setting value - see [pagePdfObject](http://wkhtmltopdf.org/libwkhtmltox/pagesettings.html#pageImageGlobal)
    def set( key : String, value : String )
      case key
      when "format"
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
      set "out", path unless path.empty?
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
      ## deinit
      LibWkHtmlToImage.wkhtmltoimage_destroy_converter @converter
      LibWkHtmlToImage.wkhtmltoimage_deinit
      ret
    end
  end
end
