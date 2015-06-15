require "colored"
require "CSV"
require "erb"
require "yaml"

task :default => :build_all

desc "Export CSV"
task :export_csv do
  sh "osascript .export/export.scpt"
  puts "Exported CSV".cyan
end

desc "Generate LaTeX"
task :generate_latex => ".export/csv" do
  renderer = ERB.new(File.open(".export/template.tex", "r").read)
  sh "mkdir -p .export/tex"
  sh "rm -f .export/tex/*"

  config = YAML.load_file("config.yml")
  puts config

  Dir[".export/csv/*"].each do |csv_filename|
    m = /Chapter (?<chapter>\d+)-Chapter \d+ \((?<date>.*)\)/.match(csv_filename)
    if m == nil
      abort("Invalid filename '#{csv_filename}'".red.bold)
    end
    chapter = m["chapter"]
    date = m["date"]
    File.open(".export/tex/chapter_#{chapter}.tex", "w") do |tex_file|
      terms = CSV.read(csv_filename).slice(1..-1).select {|i| i[0] != nil}
      tex_file.write(renderer.result(binding).gsub("“", "``").gsub("”", "''").gsub("’", "'").gsub("$","\\$").gsub("&", "\&"))
    end
  end
  puts "Generated LaTeX".cyan
end

desc "Make LaTeX"
task :make_latex => ".export/tex" do
  sh "mkdir -p export"
  sh "rm -f export/*"
  Dir[".export/tex/*"].each do |tex_filename|
    sh "pdflatex -output-directory=export #{tex_filename}"
    sh "latexmk -c -output-directory=export #{tex_filename}"
    puts "Built #{tex_filename.split("/")[2].split(".")[0] + '.pdf'}".cyan
  end
end

desc "Build all chapters"
task :build_all => [:export_csv, :generate_latex, :make_latex] do
  puts "Built all chapters".cyan
  sh "open export"
end
