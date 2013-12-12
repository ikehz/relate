module ApplicationHelper
  TRUNCATE_LENGTH = 90.freeze

  BOOTSTRAP_FLASH_TYPES = {success: 'alert-success', notice: 'alert-info', alert: 'alert-warning', error: 'alert-danger'}.freeze

  def truncate_length
    TRUNCATE_LENGTH
  end

  def bootstrap_flash_types
    BOOTSTRAP_FLASH_TYPES
  end
end
