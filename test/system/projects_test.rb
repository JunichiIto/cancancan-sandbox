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
end
