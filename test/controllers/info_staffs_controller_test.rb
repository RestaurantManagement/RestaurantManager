require 'test_helper'

class InfoStaffsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get info_staffs_new_url
    assert_response :success
  end

end
