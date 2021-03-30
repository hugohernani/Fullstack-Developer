module RouteConcerns
  class ProfileSection
    def initialize(defaults = {})
      @defaults = defaults
    end

    def call(mapper, _options = {})
      mapper.get 'profile', controller: 'profiles', action: 'show', as: :profile
      mapper.get 'profile/edit', controller: 'profiles', action: 'edit', as: :edit_profile
      mapper.match 'profile', controller: 'profiles', action: 'update', via: %w[patch put], as: :update_profile
    end

    private

    attr_reader :defaults
  end
end
