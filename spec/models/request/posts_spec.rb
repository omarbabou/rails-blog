require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    context 'when the page is opened' do
      it 'returns a correct response' do
        get '/users/1/posts'
        expect(response).to have_http_status(200)
        expect(response.body).to include('<h1>Posts</h1>')
        expect(response.body).to include('<p>Here is a list of posts for a given user</p>')
        expect(response.body).to render_template('posts/index')
      end
    end
  end
  describe 'GET /show' do
    context 'when the page is opened' do
      it 'returns a correct response' do
        get '/users/1/posts/1'
        expect(response).to have_http_status(200)
        expect(response.body).to include('<h1>Posts</h1>')
        expect(response.body).to include('<p>Show one post for a given user</p>')
        expect(response.body).to render_template('posts/show')
      end
    end
  end
end