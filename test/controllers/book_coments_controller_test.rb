require "test_helper"

class BookComentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get book_coments_create_url
    assert_response :success
  end
end
