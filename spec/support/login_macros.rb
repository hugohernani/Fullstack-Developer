module LoginMacros
  def sign_in(user)
    login_as(user, scope: :user)
  end

  def sign_in_as_admin
    @user = create(:user, :admin)

    login_as(@user, scope: :user)
  end

  def sign_in_as_member
    @user = create(:user, :member)

    login_as(@user, scope: :user)
  end
end

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include LoginMacros

  config.before(:suite) { Warden.test_mode! }
  config.after{ Warden.test_reset! }
end
