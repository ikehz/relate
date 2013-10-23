class SameOwnerAsRecordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "does not have same owner as record") unless record.owner == value.owner
  end
end
