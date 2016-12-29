@[Link("wkhtmltox")]
lib LibWkHtmlToPdf
  type StrCallback  = Void*, LibC::Char* -> Void
  type IntCallback  = Void*, LibC::Int -> Void
  type VoidCallback = Void* -> Void

  fun wkhtmltopdf_init( use_graphics : LibC::Int ): LibC::Int
  fun wkhtmltopdf_deinit(): LibC::Int
  fun wkhtmltopdf_extended_qt(): LibC::Int
  fun wkhtmltopdf_version(): LibC::Char*

  fun wkhtmltopdf_create_global_settings(): Void*
  fun wkhtmltopdf_destroy_global_settings( settings : Void* )

  fun wkhtmltopdf_create_object_settings(): Void*
  fun wkhtmltopdf_destroy_object_settings( settings : Void* )

  fun wkhtmltopdf_set_global_setting( settings : Void*, name : LibC::Char*, value : LibC::Char* ): LibC::Int
  fun wkhtmltopdf_get_global_setting( settings : Void*, name : LibC::Char*, value : LibC::Char*, vs : LibC::Int ): LibC::Int
  fun wkhtmltopdf_set_object_setting( settings : Void*, name : LibC::Char*, value : LibC::Char* ): LibC::Int
  fun wkhtmltopdf_get_object_setting( settings : Void*, name : LibC::Char*, value : LibC::Char*, vs : LibC::Int ): LibC::Int

  fun wkhtmltopdf_create_converter( settings : Void* ) : Void*
  fun wkhtmltopdf_destroy_converter( converter : Void* )

  fun wkhtmltopdf_set_warning_callback( converter : Void*, cb : StrCallback )
  fun wkhtmltopdf_set_error_callback( converter : Void*, cb : StrCallback )
  fun wkhtmltopdf_set_phase_changed_callback( converter : Void*, cb : VoidCallback )
  fun wkhtmltopdf_set_progress_changed_callback( converter : Void*, cb : IntCallback )
  fun wkhtmltopdf_set_finished_callback( converter : Void*, cb : IntCallback )

  fun wkhtmltopdf_convert( converter : Void* ) : LibC::Int
  fun wkhtmltopdf_add_object( converter : Void*, settings : Void*, data : UInt8* )

  fun wkhtmltopdf_current_phase( converter : Void* ) : LibC::Int
  fun wkhtmltopdf_phase_count( converter : Void* ) : LibC::Int
  fun wkhtmltopdf_phase_description( converter : Void*, phase : LibC::Int ) : LibC::Char*
  fun wkhtmltopdf_progress_string( converter : Void* ) : LibC::Char*
  fun wkhtmltopdf_http_error_code( converter : Void* ) : LibC::Int
  fun wkhtmltopdf_get_output( converter : Void*, output : UInt8** ) : LibC::Long
end
