module Wkhtmltopdf
  class WkImage
    # Output formats available
    FORMATS = [ "jpg", "png", "bmp", "svg" ]

    @glb_settings = Hash( String, String ).new
    @out = ""
    @url = ""
    @buffer = nil

    # Buffer used for in-memory generation (available if no output is specified)
    getter :buffer

    # Init default values
    #
    # - `path`: string with an output file path (extension included)
    def initialize( path = "" )
      @glb_settings["fmt"] = "jpg"
      set_output path
    end

    # Set an option
    #
    # - `key`: string with key name
    # - `value`: string with setting value
    #
    # NOTE: for available settings see [pagePdfObject](http://wkhtmltopdf.org/libwkhtmltox/pagesettings.html#pageImageGlobal)
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
    #
    # - `path`: string with an output file path (extension included)
    def set_output( path : String )
      unless path.empty?
        @out = path
        set "out", path
      end
    end

    # Set URL to fetch content from
    #
    # - `url`: string with a complete URL (schema included)
    def set_url( url : String )
      unless url.empty?
        @url = url
        set "in", url
      end
    end

    # Convert to image
    #
    # - `html`: HTML string used as content, if omitted (or nil) a URL to fetch is required (using `set_url`)
    def convert( html = nil )
      raise "No URL or HTML data specified" if @url.empty? && html.nil?
      ## init
      LibWkHtmlToImage.wkhtmltoimage_init 0
      if( settings = LibWkHtmlToImage.wkhtmltoimage_create_global_settings )
        @glb_settings.each do |k, v|
          LibWkHtmlToImage.wkhtmltoimage_set_global_setting settings, k, v
        end
        if( converter = LibWkHtmlToImage.wkhtmltoimage_create_converter settings, html )
          ## convert
          ret = LibWkHtmlToImage.wkhtmltoimage_convert( converter )
          if ret > 0 && @out.empty?
            # Copy data in buffer
            len = LibWkHtmlToImage.wkhtmltoimage_get_output( converter, out data )
            @buffer = Slice( UInt8 ).new( data, len )
          end
          LibWkHtmlToImage.wkhtmltoimage_destroy_converter converter
        end
      end
      ## deinit
      LibWkHtmlToImage.wkhtmltoimage_deinit
      ret
    end
  end
end
