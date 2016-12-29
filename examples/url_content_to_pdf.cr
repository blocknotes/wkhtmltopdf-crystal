# ---------------------------------------------------------------------------- #
# Example:     url_content_to_pdf
# Author:      Mat
# Description: Using WkPdf wrapper to render a page from URL to PDF
# ---------------------------------------------------------------------------- #
require "wkhtmltopdf-crystal"

pdf = Wkhtmltopdf::WkPdf.new "test.pdf"
pdf.set_url "https://crystal-lang.org"
# pdf.object_setting "web.loadImages", "false" # skip images
pdf.convert
