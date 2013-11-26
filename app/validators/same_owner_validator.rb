class SameOwnerValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?
    record.errors.add(attribute, "does not have same owner as record") unless record.owner == value.owner
  end
end
