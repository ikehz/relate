module ApplicationHelper
  TRUNCATE_LENGTH = 90.freeze

  BOOTSTRAP_FLASH_TYPES = {success: 'alert-success',
                           notice: 'alert-info',
                           alert: 'alert-warning',
                           error: 'alert-danger'}.freeze

  NOTES_MARKDOWN = Redcarpet::Markdown.new(Redcarpet::Render::HTML).freeze

  def truncate_length
    TRUNCATE_LENGTH
  end

  def bootstrap_flash_types
    BOOTSTRAP_FLASH_TYPES
  end

  def notes_markdown
    NOTES_MARKDOWN
  end
end
