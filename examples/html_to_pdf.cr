# ---------------------------------------------------------------------------- #
# Example:     html_to_pdf
# Author:      Mat
# Description: Using WkPdf wrapper to render an HTML string to PDF
# ---------------------------------------------------------------------------- #
require "../wkhtmltopdf-crystal"

html = <<-END
<h1>Lorem!</h1>
<p><b>Lorem</b> ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim <span style="color: red">veniam</span>, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo <u>consequat</u>. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla <i>pariatur</i>. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
END

pdf = Wkhtmltopdf::WkPdf.new
pdf.set_output "html_to_pdf.pdf"
pdf.convert html
