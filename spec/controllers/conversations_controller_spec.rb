require 'spec_helper'

describe ConversationsController do
  it_behaves_like "an owned resource controller" do
    let (:resource) { :conversation }
    let (:updatable_attribute) { :notes }
  end
end
