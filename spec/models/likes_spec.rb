require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.new(name: 'v', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'developer')
  post = Post.new(author: user, title: 'title', text: 'text')
  subject { Like.new(author: user, post: current_post) }
  before { subject }

  it 'should return author is nil' do
    test_case = subject
    test_case.author = nil
    expect(test_case).to_not be_valid
  end

  it 'should return post is nil' do
    test_case = subject
    test_case.post = nil
    expect(test_case).to_not be_valid
  end

  it 'should return update likes counter' do
    expect(post.likes_counter).to eq(0)
    subject.save # update_likes_counter_for_user method will run after saving the like
    expect(post.likes_counter).to eq(1)
  end
end
