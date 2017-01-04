@[Link("wkhtmltox")]
lib LibWkHtmlToImage
  type WkhtmltoimageGlobalSettings = Void*
  type WkhtmltoimageConverter = Void*

  type StrCallback  = WkhtmltoimageConverter, LibC::Char* -> Void
  type IntCallback  = WkhtmltoimageConverter, LibC::Int -> Void
  type VoidCallback = WkhtmltoimageConverter -> Void

  fun wkhtmltoimage_init( use_graphics : LibC::Int ): LibC::Int
  fun wkhtmltoimage_deinit(): LibC::Int
  fun wkhtmltoimage_extended_qt(): LibC::Int
  fun wkhtmltoimage_version(): LibC::Char*

  fun wkhtmltoimage_create_global_settings(): WkhtmltoimageGlobalSettings

  fun wkhtmltoimage_set_global_setting( settings : WkhtmltoimageGlobalSettings, name : LibC::Char*, value : LibC::Char* ): LibC::Int
  fun wkhtmltoimage_get_global_setting( settings : WkhtmltoimageGlobalSettings, name : LibC::Char*, value : LibC::Char*, vs : LibC::Int ): LibC::Int

  fun wkhtmltoimage_create_converter( settings : WkhtmltoimageGlobalSettings, data : LibC::Char* ): WkhtmltoimageConverter
  fun wkhtmltoimage_destroy_converter( converter : WkhtmltoimageConverter )

  fun wkhtmltoimage_set_warning_callback( converter : WkhtmltoimageConverter, cb : StrCallback )
  fun wkhtmltoimage_set_error_callback( converter : WkhtmltoimageConverter, cb : StrCallback )
  fun wkhtmltoimage_set_phase_changed_callback( converter : WkhtmltoimageConverter, cb : VoidCallback )
  fun wkhtmltoimage_set_progress_changed_callback( converter : WkhtmltoimageConverter, cb : IntCallback )
  fun wkhtmltoimage_set_finished_callback( converter : WkhtmltoimageConverter, cb : IntCallback )

  fun wkhtmltoimage_convert( converter : WkhtmltoimageConverter ): LibC::Int

  fun wkhtmltoimage_current_phase( converter : WkhtmltoimageConverter ) : LibC::Int
  fun wkhtmltoimage_phase_count( converter : WkhtmltoimageConverter ) : LibC::Int
  fun wkhtmltoimage_phase_description( converter : WkhtmltoimageConverter, phase : LibC::Int ) : LibC::Char*
  fun wkhtmltoimage_progress_string( converter : WkhtmltoimageConverter ) : LibC::Char*
  fun wkhtmltoimage_http_error_code( converter : WkhtmltoimageConverter ) : LibC::Int
  fun wkhtmltoimage_get_output( converter : WkhtmltoimageConverter, output : UInt8** ) : LibC::Long
end
