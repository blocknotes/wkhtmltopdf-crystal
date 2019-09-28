require "./spec_helper"

describe Wkhtmltopdf do
  html = <<-END
<h1>Lorem!</h1>
<p><b>Lorem</b> ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim <span style="color: red">veniam</span>, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo <u>consequat</u>. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla <i>pariatur</i>. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
END

  it "should convert HTML to PDF" do
    output = "/tmp/test.pdf"
    File.delete output rescue nil
    wk = Wkhtmltopdf::WkPdf.new(output)
    ret = wk.convert html
    ret.should eq(1)
    File.file?(output).should be_true
    (File.size(output) > 0).should be_true
  end

  it "should convert HTML to JPG" do
    output = "/tmp/test.jpg"
    File.delete output rescue nil
    wk = Wkhtmltopdf::WkImage.new output
    wk.set "quality", "75"
    ret = wk.convert html
    ret.should eq(1)
    File.file?(output).should be_true
    (File.size(output) > 0).should be_true
  end
end
