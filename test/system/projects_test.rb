require "application_system_test_case"

class ProjectsTest < ApplicationSystemTestCase
  setup do
    user = User.find_or_initialize_by(email: 'user@example.com', admin: false)
    user.password = user.password_confirmation = 'password'
    user.save!

    admin = User.find_or_initialize_by(email: 'admin@example.com', admin: true)
    admin.password = admin.password_confirmation = 'password'
    admin.save!

    Project.find_or_create_by!(name: 'Active project', active: true)
    Project.find_or_create_by!(name: 'Inactive project', active: false)
  end

  test 'user access' do
    visit root_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    assert_text 'Active project'
    assert_no_text 'Inactive project'
  end

  test 'admin access' do
    visit root_path
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    assert_text 'Active project'
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
