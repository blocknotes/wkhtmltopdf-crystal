# ---------------------------------------------------------------------------- #
# Example:     html_to_image
# Author:      Mat
# Description: Using WkImage wrapper to render an HTML string to image
# ---------------------------------------------------------------------------- #
require "wkhtmltopdf"

html = <<-END
<h1>Lorem!</h1>
<p><b>Lorem</b> ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim <span style="color: red">veniam</span>, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo <u>consequat</u>. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla <i>pariatur</i>. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
END

img = Wkhtmltopdf::WkImage.new
img.set "format", "png"
img.set "screenWidth", "800"
img.set "transparent", "true"
img.set_output "test.png"
img.convert html
