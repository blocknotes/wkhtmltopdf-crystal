module Wkhtmltopdf
  class WkPdf
    @obj_settings = Hash( String, String ).new
    @glb_settings = Hash( String, String ).new
    @url = ""

    # Prepare the structure
    def initialize( output = nil )
      @glb_settings["out"] = output ? output : "output.pdf"
    end

    # Pdf object settings - see [pagePdfObject](http://wkhtmltopdf.org/libwkhtmltox/pagesettings.html#pagePdfObject)
    def object_setting( key : String, value : String )
      @obj_settings[key] = value
    end

    # Pdf global settings - see [pagePdfGlobal](http://wkhtmltopdf.org/libwkhtmltox/pagesettings.html#pagePdfGlobal)
    def set( key : String, value : String )
      @glb_settings[key] = value
    end

    # Set output path
    def set_output( path : String )
      set "out", path unless path.empty?
    end

    # Set URL to fetch content from
    def set_url( url : String )
      unless url.empty?
        @url = url
        object_setting "page", url
      end
    end

    # Start convertion - if `html` is omitted (nil) a URL to fetch is required
    def convert( html = nil )
      raise "No URL or HTML data specified" if @url.empty? && html.nil?
      ## init
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
      ## convert
      LibWkHtmlToPdf.wkhtmltopdf_add_object @converter, @object_settings, html
      ret = LibWkHtmlToPdf.wkhtmltopdf_convert( @converter )
      ## deinit
      LibWkHtmlToPdf.wkhtmltopdf_destroy_converter @converter
      LibWkHtmlToPdf.wkhtmltopdf_destroy_object_settings @object_settings
      LibWkHtmlToPdf.wkhtmltopdf_destroy_global_settings @global_settings
      LibWkHtmlToPdf.wkhtmltopdf_deinit
      ret
    end
  end
end
