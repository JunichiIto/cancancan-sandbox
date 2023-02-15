require "application_system_test_case"

class ProjectsTest < ApplicationSystemTestCase
  setup do
    user = User.find_or_initialize_by(email: 'user@example.com', admin: false)
    user.password = user.password_confirmation = 'password'
    user.save!

    admin = User.find_or_initialize_by(email: 'admin@example.com', admin: true)
    admin.password = admin.password_confirmation = 'password'
    admin.save!

    @active_project = Project.find_or_create_by!(name: 'Active project', active: true)
    @inactive_project = Project.find_or_create_by!(name: 'Inactive project', active: false)

    @raise_server_errors = Capybara.raise_server_errors
  end

  teardown do
    Capybara.raise_server_errors = @raise_server_errors
  end

  test 'user access' do
    Capybara.raise_server_errors = false

    visit root_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    assert_text 'Active project'
    assert_no_text 'Inactive project'

    visit project_path(@active_project)
    assert_current_path project_path(@active_project)
    assert_text 'Active project'

    visit project_path(@inactive_project)
    assert_text 'CanCan::AccessDenied'
  end

  test 'admin access' do
    visit root_path
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    assert_text 'Active project'
    assert_text 'Inactive project'

    visit project_path(@active_project)
    assert_current_path project_path(@active_project)
    assert_text 'Active project'

    visit project_path(@inactive_project)
    assert_current_path project_path(@inactive_project)
    assert_text 'Inactive project'
  end

  test 'CRUD' do
    visit root_path
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    click_link 'New project'
    fill_in 'Name', with: 'Awesome project'
    click_button 'Create Project'
    assert_text 'Project was successfully created.'

    click_link 'Edit this project'
    fill_in 'Name', with: '1st project'
    click_button 'Update Project'
    assert_text 'Project was successfully updated.'

    click_button 'Destroy this project'
    assert_text 'Project was successfully destroyed.'
  end
end
