admin = User.find_or_create_by(full_name: 'Admin Fullstack Web Developer', email: 'admin@localhost.com',
                               role: User.roles[:admin])

admin.password = admin.password_confirmation = ENV['DEV_PASSWORD'] || '43214321'
admin.save(validate: false)

member = User.find_or_create_by(full_name: 'Fullstack Web Developer', email: 'user@localhost.com',
                                role: User.roles[:member])

member.password = member.password_confirmation = ENV['DEV_PASSWORD'] || '43214321'
member.save(validate: false)
