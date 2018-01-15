require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "unique username" do
    user1 = build(:user)
    user2 = build(:user)

    assert(user2.save)
  end

  test "user name too short" do
    refute(build(:user, username: 'l').save)
  end

  test "user should save" do
    user = build(:user)
    assert(user.save)
  end

  test "email uniqueness" do
    user1 = build(:user, email: 'tyler@gmail.com').save
    user2 = build(:user, email: 'tyler@gmail.com').save

    refute(user2)
  end

end
