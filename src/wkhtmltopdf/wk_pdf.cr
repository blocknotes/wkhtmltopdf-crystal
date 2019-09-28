module Wkhtmltopdf
  class WkPdf
    @obj_settings = Hash(String, String).new
    @glb_settings = Hash(String, String).new
    @out = ""
    @url = ""
    @buffer = nil

    # Buffer used for in-memory generation (available if no output is specified)
    getter :buffer

    # Init default values
    #
    # - `path`: string with an output file path (extension included)
    def initialize(path = "", force_init = false)
      LibWkHtmlToPdf.wkhtmltopdf_init(0) if force_init
      set_output path
    end

    # Pdf object settings
    #
    # - `key`: string with key name
    # - `value`: string with setting value
    #
    # NOTE: for available settings see [pagePdfObject](http://wkhtmltopdf.org/libwkhtmltox/pagesettings.html#pagePdfObject)
    def object_setting(key : String, value : String)
      @obj_settings[key] = value
    end

    # Pdf global settings
    #
    # - `key`: string with key name
    # - `value`: string with setting value
    #
    # NOTE: for available settings see [pagePdfGlobal](http://wkhtmltopdf.org/libwkhtmltox/pagesettings.html#pagePdfGlobal)
    def set(key : String, value : String)
      @glb_settings[key] = value
    end

    # Set output path
    #
    # - `path`: string with an output file path (extension included)
    def set_output(path : String)
      unless path.empty?
        @out = path
        set "out", path
      end
    end

    # Set URL to fetch content from
    #
    # - `url`: string with a complete URL (schema included)
    def set_url(url : String)
      unless url.empty?
        @url = url
        object_setting "page", url
      end
    end

    # Convert to PDF
    #
    # - `html`: HTML string used as content, if omitted (or nil) a URL to fetch is required (using `set_url`)
    def convert(html = nil, do_init = true)
      raise "No URL or HTML data specified" if @url.empty? && html.nil?
      # init
      LibWkHtmlToPdf.wkhtmltopdf_init(0) if do_init
      if (g_settings = LibWkHtmlToPdf.wkhtmltopdf_create_global_settings)
        @glb_settings.each do |k, v|
          LibWkHtmlToPdf.wkhtmltopdf_set_global_setting g_settings, k, v
        end
        if (o_settings = LibWkHtmlToPdf.wkhtmltopdf_create_object_settings)
          @obj_settings.each do |k, v|
            LibWkHtmlToPdf.wkhtmltopdf_set_object_setting o_settings, k, v
          end
          if (converter = LibWkHtmlToPdf.wkhtmltopdf_create_converter g_settings)
            # convert
            LibWkHtmlToPdf.wkhtmltopdf_add_object converter, o_settings, html
            ret = LibWkHtmlToPdf.wkhtmltopdf_convert(converter)
            if ret > 0 && @out.empty?
              # Copy data in buffer
              len = LibWkHtmlToPdf.wkhtmltopdf_get_output(converter, out data)
              @buffer = Slice(UInt8).new(data, len)
            end
            # deinit
            LibWkHtmlToPdf.wkhtmltopdf_destroy_converter converter
          end
          LibWkHtmlToPdf.wkhtmltopdf_destroy_object_settings o_settings
        end
        LibWkHtmlToPdf.wkhtmltopdf_destroy_global_settings g_settings
      end
      LibWkHtmlToPdf.wkhtmltopdf_deinit if do_init
      ret
    end

    # Deinitialize the library, required only if force_init option is used
    def deinitialize
      LibWkHtmlToPdf.wkhtmltopdf_deinit
    end
  end
end
