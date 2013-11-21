require 'spec_helper'

describe ContactsController do
  it_behaves_like "an owned resource controller" do
    let (:resource) { :contact }
    let (:updatable_attribute) { :name }
  end
end
