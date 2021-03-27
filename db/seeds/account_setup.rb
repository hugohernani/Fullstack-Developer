User.find_or_create_by(full_name: 'Admin Fullstack Web Developer', email: 'admin@localhost.com',
                       role: User.roles[:admin]) do |account|
  account.password = account.password_confirmation = ENV['DEV_PASSWORD'] || '12341234'
end

User.find_or_create_by(full_name: 'Fullstack Web Developer', email: 'user@localhost.com',
                       role: User.roles[:no_admin]) do |account|
  account.password = account.password_confirmation = ENV['DEV_PASSWORD'] || '12341234'
end
