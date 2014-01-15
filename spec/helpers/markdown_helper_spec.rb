require 'spec_helper'

describe MarkdownHelper do
  describe "#render_markdown" do
    it "renders Markdown" do
      expect(helper.render_markdown("*notes*")).to eq("<p><em>notes</em></p>\n")
    end
  end
end
