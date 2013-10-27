class SameOwnerValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless record.send(options[:as]).owner == value.owner
      record.errors.add(attribute, "does not have same owner as " + options[:as].to_s)
    end
  end
end
