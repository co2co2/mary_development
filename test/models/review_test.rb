require 'test_helper'

class ReviewTest < ActiveSupport::TestCase

  setup do
    @review =build(:review)
  end
  test "build review" do
    assert @review.valid?
  end
  test "review can be created" do
    @review.save
    assert Review.count +1
  end

  test 'association with user' do
     @review.user
     assert true
  end

  test 'association with recipe' do
    @review.recipe
    assert true
  end

end
