class Markdown::Builder
  property name : String
  property content : String
  property tags : Array(String)

  def initialize(@name, @tags, @content)
  end

  def get_tags_line
    tags.map do |tag|
      '#' + tag + ' '
    end
  end

  def build : String
    <<-MARKDOWN
      # #{name}
      #{get_tags_line} 

      #{content}
    MARKDOWN
  end
end
