@[Link("wkhtmltox")]
lib LibWkHtmlToPdf
  type WkhtmltopdfGlobalSettings = Void*
  type WkhtmltopdfObjectSettings = Void*
  type WkhtmltopdfConverter = Void*

  type StrCallback  = WkhtmltopdfConverter, LibC::Char* -> Void
  type IntCallback  = WkhtmltopdfConverter, LibC::Int -> Void
  type VoidCallback = WkhtmltopdfConverter -> Void

  fun wkhtmltopdf_init( use_graphics : LibC::Int ): LibC::Int
  fun wkhtmltopdf_deinit(): LibC::Int
  fun wkhtmltopdf_extended_qt(): LibC::Int
  fun wkhtmltopdf_version(): LibC::Char*

  fun wkhtmltopdf_create_global_settings(): WkhtmltopdfGlobalSettings
  fun wkhtmltopdf_destroy_global_settings( settings : WkhtmltopdfGlobalSettings )

  fun wkhtmltopdf_create_object_settings(): WkhtmltopdfObjectSettings
  fun wkhtmltopdf_destroy_object_settings( settings : WkhtmltopdfObjectSettings )

  fun wkhtmltopdf_set_global_setting( settings : WkhtmltopdfGlobalSettings, name : LibC::Char*, value : LibC::Char* ): LibC::Int
  fun wkhtmltopdf_get_global_setting( settings : WkhtmltopdfGlobalSettings, name : LibC::Char*, value : LibC::Char*, vs : LibC::Int ): LibC::Int
  fun wkhtmltopdf_set_object_setting( settings : WkhtmltopdfObjectSettings, name : LibC::Char*, value : LibC::Char* ): LibC::Int
  fun wkhtmltopdf_get_object_setting( settings : WkhtmltopdfObjectSettings, name : LibC::Char*, value : LibC::Char*, vs : LibC::Int ): LibC::Int

  fun wkhtmltopdf_create_converter( settings : WkhtmltopdfGlobalSettings ) : WkhtmltopdfConverter
  fun wkhtmltopdf_destroy_converter( converter : WkhtmltopdfConverter )

  fun wkhtmltopdf_set_warning_callback( converter : WkhtmltopdfConverter, cb : StrCallback )
  fun wkhtmltopdf_set_error_callback( converter : WkhtmltopdfConverter, cb : StrCallback )
  fun wkhtmltopdf_set_phase_changed_callback( converter : WkhtmltopdfConverter, cb : VoidCallback )
  fun wkhtmltopdf_set_progress_changed_callback( converter : WkhtmltopdfConverter, cb : IntCallback )
  fun wkhtmltopdf_set_finished_callback( converter : WkhtmltopdfConverter, cb : IntCallback )

  fun wkhtmltopdf_convert( converter : WkhtmltopdfConverter ) : LibC::Int
  fun wkhtmltopdf_add_object( converter : WkhtmltopdfConverter, settings : WkhtmltopdfObjectSettings, data : UInt8* )

  fun wkhtmltopdf_current_phase( converter : WkhtmltopdfConverter ) : LibC::Int
  fun wkhtmltopdf_phase_count( converter : WkhtmltopdfConverter ) : LibC::Int
  fun wkhtmltopdf_phase_description( converter : WkhtmltopdfConverter, phase : LibC::Int ) : LibC::Char*
  fun wkhtmltopdf_progress_string( converter : WkhtmltopdfConverter ) : LibC::Char*
  fun wkhtmltopdf_http_error_code( converter : WkhtmltopdfConverter ) : LibC::Int
  fun wkhtmltopdf_get_output( converter : WkhtmltopdfConverter, output : UInt8** ) : LibC::Long
end
