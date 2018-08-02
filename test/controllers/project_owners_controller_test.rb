require 'test_helper'

class ProjectOwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project_owner = project_owners(:one)
  end

  test "should get index" do
    get project_owners_url
    assert_response :success
  end

  test "should get new" do
    get new_project_owner_url
    assert_response :success
  end

  test "should create project_owner" do
    assert_difference('ProjectOwner.count') do
      post project_owners_url, params: { project_owner: { project_owner_name: @project_owner.project_owner_name, qualification: @project_owner.qualification, user_id: @project_owner.user_id } }
    end

    assert_redirected_to project_owner_url(ProjectOwner.last)
  end

  test "should show project_owner" do
    get project_owner_url(@project_owner)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_owner_url(@project_owner)
    assert_response :success
  end

  test "should update project_owner" do
    patch project_owner_url(@project_owner), params: { project_owner: { project_owner_name: @project_owner.project_owner_name, qualification: @project_owner.qualification, user_id: @project_owner.user_id } }
    assert_redirected_to project_owner_url(@project_owner)
  end

  test "should destroy project_owner" do
    assert_difference('ProjectOwner.count', -1) do
      delete project_owner_url(@project_owner)
    end

    assert_redirected_to project_owners_url
  end
end
