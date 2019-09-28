# ---------------------------------------------------------------------------- #
# Example:     html_to_pdf
# Author:      Mat
# Description: Using WkPdf wrapper to render an HTML string to PDF
# ---------------------------------------------------------------------------- #
require "../src/wkhtmltopdf-crystal"

html = <<-END
<!DOCTYPE html>
<html>
<head>
  <title>A sample page</title>
  <base href="file://#{Dir.current}/">
</head>
<body>
  <h1>Lorem!</h1>
  <p><b>Lorem</b> ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim <span style="color: red">veniam</span>, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo <u>consequat</u>. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla <i>pariatur</i>. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
  <p><img src="image.jpg" alt="An image" /></p>
</body>
</html>
END

pdf = Wkhtmltopdf::WkPdf.new
pdf.object_setting "header.center", "Just a test"
pdf.object_setting "load.blockLocalFileAccess", "false"
pdf.object_setting "web.loadImages", "true"
pdf.set "size.pageSize", "A4"
pdf.set_output "html_to_pdf.pdf"
pdf.convert html
