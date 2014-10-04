require 'test_helper'

class AdHocDownloadsControllerTest < ActionController::TestCase
  setup do
    @ad_hoc_download = ad_hoc_downloads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ad_hoc_downloads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ad_hoc_download" do
    assert_difference('AdHocDownload.count') do
      post :create, ad_hoc_download: { name: @ad_hoc_download.name, seen: @ad_hoc_download.seen, url: @ad_hoc_download.url }
    end

    assert_redirected_to ad_hoc_download_path(assigns(:ad_hoc_download))
  end

  test "should show ad_hoc_download" do
    get :show, id: @ad_hoc_download
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ad_hoc_download
    assert_response :success
  end

  test "should update ad_hoc_download" do
    patch :update, id: @ad_hoc_download, ad_hoc_download: { name: @ad_hoc_download.name, seen: @ad_hoc_download.seen, url: @ad_hoc_download.url }
    assert_redirected_to ad_hoc_download_path(assigns(:ad_hoc_download))
  end

  test "should destroy ad_hoc_download" do
    assert_difference('AdHocDownload.count', -1) do
      delete :destroy, id: @ad_hoc_download
    end

    assert_redirected_to ad_hoc_downloads_path
  end
end
