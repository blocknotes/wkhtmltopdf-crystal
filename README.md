# wkhtmltopdf for Crystal

Crystal wrapper for C library libwkhtmltox.

wkhtmltopdf and wkhtmltoimage permit to render HTML into PDF and various image formats using the Qt WebKit rendering engine - http://wkhtmltopdf.org/

## Requirements

- libwkhtmltox must be installed on the host system
- pkg-config must be available

## Installation

- Add this to your application's `shard.yml`:

```yml
dependencies:
  wkhtmltopdf-crystal:
    github: blocknotes/wkhtmltopdf-crystal
```

- If wkhtmltox library is installed but missing for Crystal compiler: copy *wkhtmltox.pc* in a pkg-config folder (ex. /usr/local/lib/pkgconfig) or execute before compiling (from wkhtmltopdf shard folder): ```export PKG_CONFIG_PATH="`pwd`"```
- Optinally edit *wkhtmltox.pc* with the correct path to wkhtmltox (default headers path: /usr/local/include/wkhtmltox)

## Documentation

Lib settings (available with `set` method): [libwkhtmltox pagesettings](http://wkhtmltopdf.org/libwkhtmltox/pagesettings.html)

## Usage

HTML to PDF:

```ruby
require "wkhtmltopdf"
Wkhtmltopdf::WkPdf.new( "test.pdf" ).convert( "<h3>Just a test</h3>" )
```

URL content to JPG:

```ruby
require "wkhtmltopdf"
img = Wkhtmltopdf::WkImage.new
img.set_url "http://www.google.it"
img.set_output "test.jpg"
img.set "quality", "90"
img.convert
```

#### More examples

See [examples](https://github.com/blocknotes/wkhtmltopdf-crystal/tree/master/examples) folder.

## Contributors

- [Mattia Roccoberton](https://github.com/blocknotes) - creator, maintainer
