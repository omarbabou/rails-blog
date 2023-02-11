require 'rails_helper'

RSpec.describe 'Show User page', type: :system do
  describe 'show user page' do
    before :all do
      unless User.find_by(email: 'dan@gmail.com')
        @user = User.new(Name: 'Danny',
                         email: 'dan@gmail.com',
                         Bio: 'Software Developer from Lebanon',
                         password: 'password',
                         password_confirmation: 'password',
                         posts_counter: 0)
        @user.skip_confirmation!
        @user.save!
        @post1 = Post.create(Title: 'post 1', Text: 'My first post', user_id: @user.id, comments_counter: 0,
                             likes_counter: 0)
        @post2 = Post.create(Title: 'post 2', Text: 'My second post', user_id: @user.id, comments_counter: 0,
                             likes_counter: 0)
        @post3 = Post.create(Title: 'post 3', Text: 'My third post', user_id: @user.id, comments_counter: 0,
                             likes_counter: 0)

        @comment1 = Comment.create(Text: 'My comment', user_id: @user.id, post_id: @post1.id)
      end
    end

    it 'render the user name and the Bio' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'dan@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Danny')
    end

    it 'shows the number of posts' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'dan@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Number of posts: 3')
    end

    it 'redirects to the correct path' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'dan@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      images = find_all('img')
      images[1].click
      expect(page).to have_content('Software Developer from Lebanon')
    end

    it 'show the 3 first posts and view all posts button' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'dan@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      images = find_all('img')
      images[1].click

      expect(page).to have_content('post 1')
      expect(page).to have_content('post 2')
      expect(page).to have_content('post 3')
      expect(page).to have_content('See all posts')
    end
  end
end
