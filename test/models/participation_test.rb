require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase

  setup do
    without_grant do
      Grant::User.current_user = @u = User.make!
    end
  end

  # security

  context "a participation that belongs to the current user" do

    setup do
      without_grant do
        @p = Participation.make!(user: @u)
      end
    end

    should "be found" do
      assert_nothing_raised { Participation.find(@p.id) }
    end

    should "be created" do
      assert_nothing_raised { Participation.make!(user: @u) }
    end

    should "be updated" do
      assert_nothing_raised { @p.save }
    end

    should "be destroyed" do
      assert_nothing_raised { @p.destroy }
    end

  end

  context "a participation that does not belong to the current user" do

    setup do
      without_grant do
        @p = Participation.make!
      end
    end

    should "not be found" do
      assert_raises(Grant::Error) { Participation.find(@p.id) }
    end

    should "not be created" do
      assert_raises(Grant::Error) { Participation.make! }
    end

    should "not be updated" do
      assert_raises(Grant::Error) { @p.save }
    end

    should "not be destroyed" do
      assert_raises(Grant::Error) { @p.destroy }
    end

  end

  # validations

  context "a participation that belongs to the current user" do

    setup do
      without_grant do
        @p = Participation.make!(user: @u)
      end
    end

    should "be valid" do
      assert @p.valid?
    end

  end

  context "a participation that is empty" do

    setup do
      without_grant do
        @p_empty = Participation.new
      end
    end

    should "be invalid" do
      assert @p_empty.invalid?
      assert @p_empty.errors[:user].any?
      assert @p_empty.errors[:contact].any?
      assert @p_empty.errors[:conversation].any?
    end

  end

end
