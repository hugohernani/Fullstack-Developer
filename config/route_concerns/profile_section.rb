module RouteConcerns
  class ProfileSection
    def initialize(defaults = {})
      @defaults = defaults
    end

    def call(mapper, _options = {})
      mapper.get 'profile', controller: 'profiles', action: 'show', as: :profile
      mapper.put 'profile', controller: 'profiles', action: 'update', as: :update_profile
    end

    private

    attr_reader :defaults
  end
end
