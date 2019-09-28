# ---------------------------------------------------------------------------- #
# Example:     in_memory
# Author:      Mat
# Description: Using WkPdf and WkImage wrappers to fill in-memory buffer
# ---------------------------------------------------------------------------- #
require "../src/wkhtmltopdf-crystal"

html = <<-END
<h1>Lorem!</h1>
<p><b>Lorem</b> ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim <span style="color: red">veniam</span>, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo <u>consequat</u>. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla <i>pariatur</i>. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
END

# No file output is set -> converted data is sent to buffer
pdf = Wkhtmltopdf::WkPdf.new
pdf.convert html
if (buf = pdf.buffer)
  puts "PDF buffer size: " + buf.try(&.size).to_s
  File.open("in_memory.pdf", "wb") do |file|
    file.write buf
  end
end

img = Wkhtmltopdf::WkImage.new
img.convert html
if (buf = img.buffer)
  puts "Image buffer size: " + buf.try(&.size).to_s
  File.open("in_memory.jpg", "wb") do |file|
    file.write buf
  end
end
