# ---------------------------------------------------------------------------- #
# Example:     url_content_to_image
# Author:      Mat
# Description: Using WkImage wrapper to render a page from URL to image
# ---------------------------------------------------------------------------- #
require "wkhtmltopdf-crystal"

img = Wkhtmltopdf::WkImage.new
img.set_url "https://crystal-lang.org"
img.set_output "test.jpg"
img.set "format", "jpg"
img.set "quality", "75"
# img.set "screenWidth", "640"
# img.set "web.loadImages", "false" # not working
img.convert
