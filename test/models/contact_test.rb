require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  include GrantTestHelpers

  context "a contact" do

    setup do
      @c = Contact.make!
    end

    should "be valid" do
      assert @c.valid?
    end

  end

  context "an empty contact" do

    setup do
      @c_empty = Contact.new
    end

    should "be invalid" do
      assert @c_empty.invalid?
      assert @c_empty.errors[:owner].any?
      assert @c_empty.errors[:name].any?
    end

  end

end
