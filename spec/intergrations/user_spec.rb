require 'rails_helper'

RSpec.describe 'Login Page', type: :system do
  describe 'user index page' do
    before :all do
      unless User.find_by(email: 'daniel1@hotmail.com')
        user = User.new(
          Name: 'Danny',
          email: 'daniel1@hotmail.com',
          password: '123456',
          password_confirmation: '123456',
          role: 'admin'
        )
        user.skip_confirmation!
        user.save!
      end
    end
    it 'test the users name and profile image' do
      unless User.find_by(email: 'test1@hotmail.com')
        user = User.new(
          Name: 'Test',
          email: 'test1@hotmail.com',
          password: '123456',
          password_confirmation: '123456',
          role: 'admin',
          Photo: 'https://th.bing.com/th/id/R.cdcdd744f67152de17b7bcc36582daff?rik=kFxfEWaTsu30QA&pid=ImgRaw&r=0'
        )
        user.skip_confirmation!
        user.save!
      end
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'daniel1@hotmail.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'
      expect(page).to have_content('Test')
      image = page.all('img')
      expect(image.size).to eql 3
    end

    it 'shows number of posts for each user' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'daniel1@hotmail.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'

      expect(page).to have_content('Number of posts: 0')
    end
  end
end
