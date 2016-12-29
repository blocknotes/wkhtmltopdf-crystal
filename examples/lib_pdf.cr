# ---------------------------------------------------------------------------- #
# Example:     lib_pdf
# Author:      Mat
# Description: Using LibWkHtmlToPdf directly
# ---------------------------------------------------------------------------- #
require "wkhtmltopdf-crystal"

puts "[Begin]"
puts "- Version: " + String.new( LibWkHtmlToPdf.wkhtmltopdf_version )

LibWkHtmlToPdf.wkhtmltopdf_init 0
gs = LibWkHtmlToPdf.wkhtmltopdf_create_global_settings

# LibWkHtmlToPdf.wkhtmltopdf_set_global_setting gs, "fmt", fmt
# LibWkHtmlToPdf.wkhtmltopdf_set_global_setting gs, "quality", "90"
# LibWkHtmlToPdf.wkhtmltopdf_set_global_setting gs, "screenWidth", "2048"
# LibWkHtmlToPdf.wkhtmltopdf_set_global_setting gs, "in", "http://www.google.com/"
LibWkHtmlToPdf.wkhtmltopdf_set_global_setting gs, "out", "out.pdf"
LibWkHtmlToPdf.wkhtmltopdf_set_global_setting gs, "dpi", "300"

os = LibWkHtmlToPdf.wkhtmltopdf_create_object_settings
LibWkHtmlToPdf.wkhtmltopdf_set_object_setting os, "page", "http://www.google.com/"

# LibWkHtmlToPdf.wkhtmltopdf_set_object_setting os, "web.loadImages", "false" # skip images

c = LibWkHtmlToPdf.wkhtmltopdf_create_converter gs

# Callbacks
LibWkHtmlToPdf.wkhtmltopdf_set_warning_callback c, ->( converter : Void*, param : LibC::Char* ) do
  puts "> warning callback (#{param}): " + String.new( param )
end
LibWkHtmlToPdf.wkhtmltopdf_set_error_callback c, ->( converter : Void*, param : LibC::Char* ) do
  puts "> error callback (#{param}): " + String.new( param )
end
LibWkHtmlToPdf.wkhtmltopdf_set_phase_changed_callback c, ->( converter : Void* ) do
  phase = LibWkHtmlToPdf.wkhtmltopdf_current_phase( converter )
  desc  = "> phase_changed callback ["
  desc += ( phase + 1 ).to_s + '/' + LibWkHtmlToPdf.wkhtmltopdf_phase_count( converter ).to_s
  desc += "]: " + String.new( LibWkHtmlToPdf.wkhtmltopdf_phase_description( converter, phase ) )
  puts desc
end
LibWkHtmlToPdf.wkhtmltopdf_set_progress_changed_callback c, ->( converter : Void*, param : LibC::Int ) do
  puts "> progress_changed callback (#{param}): " + String.new( LibWkHtmlToImage.wkhtmltoimage_progress_string( converter ) )
end
LibWkHtmlToPdf.wkhtmltopdf_set_finished_callback c, ->( converter : Void*, param : LibC::Int ) do
  puts "> finished callback (#{param})"
end

LibWkHtmlToPdf.wkhtmltopdf_add_object c, os, nil
if LibWkHtmlToPdf.wkhtmltopdf_convert( c )
  puts "> convert: done"
else
  puts "> convert: error"
end
puts "- http_error_code: " + LibWkHtmlToPdf.wkhtmltopdf_http_error_code( c ).to_s

# len = LibWkHtmlToPdf.wkhtmltopdf_get_output( c, out data ) # out setting must be not set
# puts "- output length: " + len.to_s

LibWkHtmlToPdf.wkhtmltopdf_destroy_converter c
LibWkHtmlToPdf.wkhtmltopdf_destroy_object_settings os
LibWkHtmlToPdf.wkhtmltopdf_destroy_global_settings gs
LibWkHtmlToPdf.wkhtmltopdf_deinit
puts "[End]"
