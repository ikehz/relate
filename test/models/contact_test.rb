require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  # security

  context "a user" do

    setup do
      without_grant do
        @u = User.make!
        Grant::User.current_user = @u
      end
    end

    context "for a contact that is theirs" do

      setup do
        without_grant do
          @c = Contact.make!(user: @u)
        end
      end

      should "find that contact" do
        assert_nothing_raised { Contact.find(@c.id) }
      end

      should "create a contact that is theirs" do
        assert_nothing_raised { Contact.make!(user: @u) }
      end

      should "update that contact" do
        assert_nothing_raised { @c.save }
      end

      should "destroy that contact" do
        assert_nothing_raised { @c.destroy }
      end

    end

    context "for a contact that is not theirs" do

      setup do
        without_grant do
          @c = Contact.make!
        end
      end

      should "not find that contact" do
        assert_raises(Grant::Error) { Contact.find(@c.id) }
      end

      should "not create a contact that is not theirs" do
        assert_raises(Grant::Error) { Contact.make! }
      end

      should "not update that contact" do
        assert_raises(Grant::Error) { @c.save }
      end

      should "not destroy that contact" do
        assert_raises(Grant::Error) { @c.destroy }
      end

    end

  end

  # validations

  context "a contact" do

    setup do
      without_grant do
        @c = Contact.make!
      end
    end

    context "that is valid" do
      should "be valid" do
        assert @c.valid?
      end
    end

    context "that is empty" do
      setup do
        @c_empty = Contact.new
      end
      should "be invalid" do
        assert @c_empty.invalid?
        assert @c_empty.errors[:user].any?
        assert @c_empty.errors[:name].any?
      end
    end

  end

end
