module MarkdownHelper
  def render_markdown(markdown)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(markdown)
  end
end
