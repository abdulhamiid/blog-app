require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:each) { get users_path }
    it 'is success ' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'Contains the placeholder text' do
      expect(response.body).to match('BlogApp')
    end

    it "does not render a different template" do
      get "/users/1/posts"
      expect(response).to_not render_template(:show)
    end
  end
end
