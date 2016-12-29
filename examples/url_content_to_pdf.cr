# ---------------------------------------------------------------------------- #
# Example:     url_content_to_pdf
# Author:      Mat
# Description: Using WkPdf wrapper to render a page from URL to PDF
# ---------------------------------------------------------------------------- #
require "wkhtmltopdf-crystal"

pdf = Wkhtmltopdf::WkPdf.new "test.pdf"
pdf.set_url "https://crystal-lang.org"

## The title of the PDF document:
pdf.set "documentTitle", "Crystal lang"
## How many copies should we print?. e.g. "2":
# pdf.set "copies", "2"
## The orientation of the output document, must be either "Landscape" or "Portrait":
# pdf.set "orientation", "Landscape"
## Should the output be printed in color or gray scale, must be either "Color" or "Grayscale"
# pdf.set "colorMode", "Grayscale"

## Should we load images? Must be either "true" or "false":
# pdf.object_setting "web.loadImages", "false"
## The text to print in the center part of the header:
pdf.object_setting "header.center", "Custom header"
## The text to print in the right part of the footer:
pdf.object_setting "footer.right", "[page] / [topage]"

pdf.convert
