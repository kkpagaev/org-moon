require "./src/markdown/*"


      markdown = <<-MARKDOWN
- 8:00 Breakfast  
test  
foo
- 9:00 - 10:33 Meeting
MARKDOWN
      parser = MarkdownParser.new markdown

      puts parser.calendar(0)
