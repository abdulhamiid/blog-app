require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:each) { get users_path }
    it 'is success ' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'Contains the placeholder text' do
      expect(response.body).to match('All Users')
    end

    it 'does not render a different template' do
      get '/users'
      expect(response).to_not render_template(:show)
    end
  end
end
