module ApplicationHelper
  TRUNCATE_LENGTH = 90.freeze

  BOOTSTRAP_FLASH_TYPES = {success: 'alert-success', error: 'alert-error', alert: 'alert-block', notice: 'alert-info'}.freeze

  def truncate_length
    TRUNCATE_LENGTH
  end

  def bootstrap_flash_types
    BOOTSTRAP_FLASH_TYPES
  end
end
