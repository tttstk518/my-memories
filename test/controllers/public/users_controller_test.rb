require "test_helper"

class Public::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_users_update_url
    assert_response :success
  end

  test "should get check" do
    get public_users_check_url
    assert_response :success
  end

  test "should get withdrawal" do
    get public_users_withdrawal_url
    assert_response :success
  end
end
