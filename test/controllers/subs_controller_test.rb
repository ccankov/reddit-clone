require 'test_helper'

class SubsControllerTest < ActionDispatch::IntegrationTest
  test "should get new," do
    get subs_new,_url
    assert_response :success
  end

  test "should get create," do
    get subs_create,_url
    assert_response :success
  end

  test "should get edit," do
    get subs_edit,_url
    assert_response :success
  end

  test "should get update," do
    get subs_update,_url
    assert_response :success
  end

  test "should get index," do
    get subs_index,_url
    assert_response :success
  end

  test "should get show" do
    get subs_show_url
    assert_response :success
  end

end
