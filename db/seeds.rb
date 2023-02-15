user = User.find_or_initialize_by(email: 'user@example.com', admin: false)
user.password = user.password_confirmation = 'password'
user.save!

admin = User.find_or_initialize_by(email: 'adminr@example.com', admin: true)
admin.password = admin.password_confirmation = 'password'
admin.save!

Project.find_or_create_by!(name: 'Active project', active: true)
Project.find_or_create_by!(name: 'Inactive project', active: false)
