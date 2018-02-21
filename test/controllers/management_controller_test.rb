require 'test_helper'

class ManagementControllerTest < ActionDispatch::IntegrationTest
  test "should get manage" do
    get management_manage_url
    assert_response :success
  end

end
