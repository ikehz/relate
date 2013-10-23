require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  setup do
    without_grant do
      Grant::User.current_user = @u = User.make!
    end
  end

  # security

  context "a contact that belongs to the current user" do

    setup do
      without_grant do
        @c = Contact.make!(owner: @u)
      end
    end

    should "be found" do
      assert_nothing_raised { Contact.find(@c.id) }
    end

    should "be created" do
      assert_nothing_raised { Contact.make!(owner: @u) }
    end

    should "be updated" do
      assert_nothing_raised { @c.save }
    end

    should "be destroyed" do
      assert_nothing_raised { @c.destroy }
    end

  end

  context "a contact that does not belong to the current user" do

    setup do
      without_grant do
        @c = Contact.make!
      end
    end

    should "not be found" do
      assert_raises(Grant::Error) { Contact.find(@c.id) }
    end

    should "not be created" do
      assert_raises(Grant::Error) { Contact.make! }
    end

    should "not be updated" do
      assert_raises(Grant::Error) { @c.save }
    end

    should "not be destroyed" do
      assert_raises(Grant::Error) { @c.destroy }
    end

  end

  # validations

  context "a contact that belongs to the current user" do

    setup do
      without_grant do
        @c = Contact.make!(owner: @u)
      end
    end

    should "be valid" do
      assert @c.valid?
    end

  end

  context "a contact that is empty" do

    setup do
      without_grant do
        @c_empty = Contact.new
      end
    end

    should "be invalid" do
      assert @c_empty.invalid?
      assert @c_empty.errors[:owner].any?
      assert @c_empty.errors[:name].any?
    end

  end

end
