class Markdown::Parser
  def initialize(text)
    @text = text
  end

  def to_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@text)
  end
end
