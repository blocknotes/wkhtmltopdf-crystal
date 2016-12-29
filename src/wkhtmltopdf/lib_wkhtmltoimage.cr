@[Link("wkhtmltox")]
lib LibWkHtmlToImage
  type StrCallback  = Void*, LibC::Char* -> Void
  type IntCallback  = Void*, LibC::Int -> Void
  type VoidCallback = Void* -> Void

  fun wkhtmltoimage_init( use_graphics : LibC::Int ): LibC::Int
  fun wkhtmltoimage_deinit(): LibC::Int
  fun wkhtmltoimage_extended_qt(): LibC::Int
  fun wkhtmltoimage_version(): LibC::Char*

  fun wkhtmltoimage_create_global_settings(): Void*

  fun wkhtmltoimage_set_global_setting( settings : Void*, name : LibC::Char*, value : LibC::Char* ): LibC::Int
  fun wkhtmltoimage_get_global_setting( settings : Void*, name : LibC::Char*, value : LibC::Char*, vs : LibC::Int ): LibC::Int

  fun wkhtmltoimage_create_converter( settings : Void*, data : LibC::Char* ): Void*
  fun wkhtmltoimage_destroy_converter( converter : Void* )

  fun wkhtmltoimage_set_warning_callback( converter : Void*, cb : StrCallback )
  fun wkhtmltoimage_set_error_callback( converter : Void*, cb : StrCallback )
  fun wkhtmltoimage_set_phase_changed_callback( converter : Void*, cb : VoidCallback )
  fun wkhtmltoimage_set_progress_changed_callback( converter : Void*, cb : IntCallback )
  fun wkhtmltoimage_set_finished_callback( converter : Void*, cb : IntCallback )

  fun wkhtmltoimage_convert( converter : Void* ): LibC::Int

  fun wkhtmltoimage_current_phase( converter : Void* ) : LibC::Int
  fun wkhtmltoimage_phase_count( converter : Void* ) : LibC::Int
  fun wkhtmltoimage_phase_description( converter : Void*, phase : LibC::Int ) : LibC::Char*
  fun wkhtmltoimage_progress_string( converter : Void* ) : LibC::Char*
  fun wkhtmltoimage_http_error_code( converter : Void* ) : LibC::Int
  fun wkhtmltoimage_get_output( converter : Void*, output : UInt8** ) : LibC::Long
end
