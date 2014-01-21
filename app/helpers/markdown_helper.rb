module MarkdownHelper
  def render_markdown(markdown)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(markdown)
  end

  def markdown_hint
    raw("All notes are formatted using " + link_to("Markdown", "http://daringfireball.net/projects/markdown/basics", target: "_blank") + ".")
  end
end
