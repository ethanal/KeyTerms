# Key Terms

This is a simple set of scripts that generates MLA-formatted key terms PDFs from a [Numbers](https://www.apple.com/mac/numbers/) spreadsheet. This depends on Ruby, Numbers, and Applescript.

## Setup

1. `gem install bundler`
2. `bundle install`
3. Copy `config.yml.example` to `config.yml` and enter the correct information.

## Usage
1. Add your key terms to the `Key Terms.numbers` document. The dates and chapter numbers are pulled from the tab and table titles. Numbers exports workbooks with only one sheet differently so right now the script only works when there are multiple sheets in the workbook.
2. Run `./rake` or double-click on the `rake` script to generate the PDFs (found in the `export` directory).
