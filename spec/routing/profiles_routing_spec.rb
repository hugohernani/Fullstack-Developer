require 'rails_helper'

RSpec.describe ProfilesController, type: :routing do
  describe 'routing' do
    context 'when user is admin' do
      it 'routes to #show' do
        expect(get: 'admin/profile').to route_to('profiles#show')
      end

      it 'routes to #edit' do
        expect(get: 'admin/profile/edit').to route_to('profiles#edit')
      end

      it 'routes to #update via PUT' do
        expect(put: 'admin/profile').to route_to('profiles#update')
      end

      it 'routes to #update via PATCH' do
        expect(patch: 'admin/profile').to route_to('profiles#update')
      end
    end

    context 'when user is not an admin' do
      it 'routes to #show' do
        expect(get: '/profile').to route_to('profiles#show')
      end

      it 'routes to #edit' do
        expect(get: '/profile/edit').to route_to('profiles#edit')
      end

      it 'routes to #update via PUT' do
        expect(put: '/profile').to route_to('profiles#update')
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/profile').to route_to('profiles#update')
      end
    end
  end
end
