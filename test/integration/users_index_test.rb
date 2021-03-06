require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
      @user = users(:dezz)
    end

    test "index including pagination" do
      log_in_as(@user)
      get users_path
      assert_template 'users/index'
      assert_select 'div.pagination'
      User.paginate(page: 1).each do |user|
        assert_select 'users/index', user_path(user), text: user.username
      end
    end
end
