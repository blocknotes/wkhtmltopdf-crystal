# ---------------------------------------------------------------------------- #
# Example:     lib_image
# Author:      Mat
# Description: Using LibWkHtmlToImage directly
# ---------------------------------------------------------------------------- #
require "../src/wkhtmltopdf-crystal"

puts "[Begin]"
puts "- Version: " + String.new(LibWkHtmlToImage.wkhtmltoimage_version)

# fmt = "png"
fmt = "jpg"
LibWkHtmlToImage.wkhtmltoimage_init 0
gs = LibWkHtmlToImage.wkhtmltoimage_create_global_settings
LibWkHtmlToImage.wkhtmltoimage_set_global_setting gs, "fmt", fmt
LibWkHtmlToImage.wkhtmltoimage_set_global_setting gs, "quality", "90"
# LibWkHtmlToImage.wkhtmltoimage_set_global_setting gs, "screenWidth", "2048"
LibWkHtmlToImage.wkhtmltoimage_set_global_setting gs, "in", "http://www.google.com/"
LibWkHtmlToImage.wkhtmltoimage_set_global_setting gs, "out", "lib_image." + fmt

# The wkhtmltoimage_global_settings structure contains the following settings:
# - crop.left: left/x coordinate of the window to capture in pixels. E.g. "200"
# - crop.top: top/y coordinate of the window to capture in pixels. E.g. "200"
# - crop.width: Width of the window to capture in pixels. E.g. "200"
# - crop.height: Heigt of the window to capture in pixels. E.g. "200"
# - load.cookieJar: Path of file used to load and store cookies.
# - load.*: Page specific settings related to loading content, see Object Specific loading settings.
# - web.*: See Web page specific settings.
# - transparent: When outputting a PNG or SVG, make the white background transparent. Must be either "true" or "false"
# - in: The URL or path of the input file, if "-" stdin is used. E.g. "http://google.com"
# - out: The path of the output file, if "-" stdout is used, if empty the content is storred to a internalBuffer.
# - fmt: The output format to use, must be either "", "jpg", "png", "bmp" or "svg".
# - screenWidth: The with of the screen used to render is pixels, e.g "800".
# - smartWidth: Should we expand the screenWidth if the content does not fit? must be either "true" or "false".
# - quality: The compression factor to use when outputting a JPEG image. E.g. "94".

c = LibWkHtmlToImage.wkhtmltoimage_create_converter gs, nil

# Callbacks
LibWkHtmlToImage.wkhtmltoimage_set_warning_callback c, ->(converter : LibWkHtmlToImage::WkhtmltoimageConverter, param : LibC::Char*) do
  puts "> warning callback (#{param}): " + String.new(param)
end
LibWkHtmlToImage.wkhtmltoimage_set_error_callback c, ->(converter : LibWkHtmlToImage::WkhtmltoimageConverter, param : LibC::Char*) do
  puts "> error callback (#{param}): " + String.new(param)
end
LibWkHtmlToImage.wkhtmltoimage_set_phase_changed_callback c, ->(converter : LibWkHtmlToImage::WkhtmltoimageConverter) do
  phase = LibWkHtmlToImage.wkhtmltoimage_current_phase(converter)
  desc = "> phase_changed callback ["
  desc += (phase + 1).to_s + '/' + LibWkHtmlToImage.wkhtmltoimage_phase_count(converter).to_s
  desc += "]: " + String.new(LibWkHtmlToImage.wkhtmltoimage_phase_description(converter, phase))
  puts desc
end
LibWkHtmlToImage.wkhtmltoimage_set_progress_changed_callback c, ->(converter : LibWkHtmlToImage::WkhtmltoimageConverter, param : LibC::Int) do
  puts "> progress_changed callback (#{param}): " + String.new(LibWkHtmlToImage.wkhtmltoimage_progress_string(converter))
end
LibWkHtmlToImage.wkhtmltoimage_set_finished_callback c, ->(converter : LibWkHtmlToImage::WkhtmltoimageConverter, param : LibC::Int) do
  puts "> finished callback (#{param})"
end

if LibWkHtmlToImage.wkhtmltoimage_convert(c)
  puts "- convert: done"
else
  puts "! convert: error"
end
puts "- http_error_code: " + LibWkHtmlToImage.wkhtmltoimage_http_error_code(c).to_s

# len = LibWkHtmlToImage.wkhtmltoimage_get_output( c, out data ) # out setting must be not set
# puts "- output length: " + len.to_s

LibWkHtmlToImage.wkhtmltoimage_destroy_converter c
LibWkHtmlToImage.wkhtmltoimage_deinit
puts "[End]"
