module Wkhtmltopdf
  class WkPdf
    @obj_settings = Hash( String, String ).new
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
      set_output path
    end

    # Pdf object settings
    #
    # - `key`: string with key name
    # - `value`: string with setting value
    #
    # NOTE: for available settings see [pagePdfObject](http://wkhtmltopdf.org/libwkhtmltox/pagesettings.html#pagePdfObject)
    def object_setting( key : String, value : String )
      @obj_settings[key] = value
    end

    # Pdf global settings
    #
    # - `key`: string with key name
    # - `value`: string with setting value
    #
    # NOTE: for available settings see [pagePdfGlobal](http://wkhtmltopdf.org/libwkhtmltox/pagesettings.html#pagePdfGlobal)
    def set( key : String, value : String )
      @glb_settings[key] = value
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
        object_setting "page", url
      end
    end

    # Convert to PDF
    #
    # - `html`: HTML string used as content, if omitted (or nil) a URL to fetch is required (using `set_url`)
    def convert( html = nil )
      raise "No URL or HTML data specified" if @url.empty? && html.nil?
      # init
      LibWkHtmlToPdf.wkhtmltopdf_init 0
      @global_settings = LibWkHtmlToPdf.wkhtmltopdf_create_global_settings
      @glb_settings.each do |k, v|
        LibWkHtmlToPdf.wkhtmltopdf_set_global_setting @global_settings, k, v
      end
      @object_settings = LibWkHtmlToPdf.wkhtmltopdf_create_object_settings
      @obj_settings.each do |k, v|
        LibWkHtmlToPdf.wkhtmltopdf_set_object_setting @object_settings, k, v
      end
      @converter = LibWkHtmlToPdf.wkhtmltopdf_create_converter @global_settings
      # convert
      LibWkHtmlToPdf.wkhtmltopdf_add_object @converter, @object_settings, html
      ret = LibWkHtmlToPdf.wkhtmltopdf_convert( @converter )
      if ret > 0 && @out.empty?
        # Copy data in buffer
        len = LibWkHtmlToPdf.wkhtmltopdf_get_output( @converter, out data )
        @buffer = Slice( UInt8 ).new( data, len )
      end
      # deinit
      LibWkHtmlToPdf.wkhtmltopdf_destroy_converter @converter
      LibWkHtmlToPdf.wkhtmltopdf_destroy_object_settings @object_settings
      LibWkHtmlToPdf.wkhtmltopdf_destroy_global_settings @global_settings
      LibWkHtmlToPdf.wkhtmltopdf_deinit
      ret
    end
  end
end
