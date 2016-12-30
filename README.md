# wkhtmltopdf for Crystal

Crystal wrapper for C library libwkhtmltox.

*wkhtmltopdf* and *wkhtmltoimage* permit to render HTML into PDF and various image formats using the Qt WebKit rendering engine - see [wkhtmltopdf.org](http://wkhtmltopdf.org)

## Requirements

- libwkhtmltox must be installed
- pkg-config must be available

## Installation

- Add this to your application's `shard.yml`:

```yml
dependencies:
  wkhtmltopdf-crystal:
    github: blocknotes/wkhtmltopdf-crystal
```

- If wkhtmltox library is installed but missing for Crystal compiler: copy *wkhtmltox.pc* in a pkg-config folder (ex. /usr/local/lib/pkgconfig) or set the environment variable PKG_CONFIG_PATH with the path to *wkhtmltox.pc* before compiling
- Optinally edit *wkhtmltox.pc* with the correct path to wkhtmltox (default headers path: /usr/local/include/wkhtmltox)

## Usage

HTML to PDF:

```ruby
require "wkhtmltopdf"
Wkhtmltopdf::WkPdf.new( "test.pdf" ).convert( "<h3>Just a test</h3>" )
```

Fetch URL content and convert it to JPG:

```ruby
require "wkhtmltopdf"
img = Wkhtmltopdf::WkImage.new
img.set_url "http://www.google.com"
img.set_output "test.jpg"
img.set "quality", "90"
img.convert
```

Lib settings (available with `set` / `object_setting` methods on wrappers): [libwkhtmltox pagesettings](http://wkhtmltopdf.org/libwkhtmltox/pagesettings.html)

## More examples

See [examples](https://github.com/blocknotes/wkhtmltopdf-crystal/tree/master/examples) folder.

## Contributors

- [Mattia Roccoberton](http://blocknot.es) - creator, maintainer
