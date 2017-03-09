# ---------------------------------------------------------------------------- #
# Example:     kemal_ecr_to_pdf
# Author:      Mat
# Description: Using WkPdf wrapper
# ---------------------------------------------------------------------------- #
require "kemal"
require "../wkhtmltopdf-crystal"

pdf = Wkhtmltopdf::WkPdf.new "", true

at_exit do
  pdf.deinitialize
end

get "/" do |env|
  html = render "kemal_ecr_to_pdf.ecr"
  pdf.convert html
  if( buf = pdf.buffer )
    env.response.content_type = "application/pdf"
    io = IO::Memory.new
    io.write( buf )
    io.to_s
  else
    html
  end
end

Kemal.run
