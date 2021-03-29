module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_account
      logger.add_tags 'ActionCable', current_user.email
    end

    protected

    def find_verified_account
      if (verified_account = env['warden'].user)
        verified_account
      else
        reject_unauthorized_connection
      end
    end
  end
end
