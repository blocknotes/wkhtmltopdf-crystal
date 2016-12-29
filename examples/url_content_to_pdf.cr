# ---------------------------------------------------------------------------- #
# Example:     url_content_to_pdf
# Author:      Mat
# Description: Using WkPdf wrapper to render a page from URL to PDF
# ---------------------------------------------------------------------------- #
require "wkhtmltopdf"

pdf = Wkhtmltopdf::WkPdf.new "test.pdf"
pdf.set_url "http://www.google.com"
# pdf.object_setting "web.loadImages", "false" # skip images
pdf.convert
