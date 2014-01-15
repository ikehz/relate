module ConversationsHelper
  def truncate_participants(participants)
    truncate(participants.map(&:contact_name).join(", "), length: 50, separator: ', ', omission: ', ...')
  end
end
