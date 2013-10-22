class SameUserAsRecordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "does not have same user as record") unless record.user == value.user
  end
end
