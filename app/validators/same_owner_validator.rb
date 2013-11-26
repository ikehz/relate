class SameOwnerValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present?
      record.errors.add(attribute, "does not have same owner as record") unless record.owner == value.owner
    end
  end
end
