# ---------------------------------------------------------------------------- #
# Example:     html_to_image
# Author:      Mat
# Description: Using WkImage wrapper to render an HTML string to image
# ---------------------------------------------------------------------------- #
require "../wkhtmltopdf-crystal"

html = <<-END
<h1>Lorem!</h1>
<p><b>Lorem</b> ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim <span style="color: red">veniam</span>, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo <u>consequat</u>. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla <i>pariatur</i>. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
END

img = Wkhtmltopdf::WkImage.new
img.set_output "html_to_image.png"

## The output format to use, must be either "", "jpg", "png", "bmp" or "svg":
img.set "fmt", "png"
## The compression factor to use when outputting a JPEG image. E.g. "94":
# img.set "quality", "75"
## The with of the screen used to render is pixels, e.g "800":
img.set "screenWidth", "800"
## When outputting a PNG or SVG, make the white background transparent. Must be either "true" or "false"
img.set "transparent", "true"

img.convert html
