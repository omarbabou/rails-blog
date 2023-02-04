require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  subject { User.new(name: 'v', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'developer') }
  before { subject }

  it 'should return name is nil or blank' do
    test_case = subject
    test_case.name = nil
    expect(test_case).to_not be_valid
    test_case.name = ''
    expect(test_case).to_not be_valid
  end
  it 'should return name is less than length of 3' do
    test_case = subject
    test_case.name = 'sa'
    expect(test_case).to_not be_valid
  end
  it 'should return name is longer than length of 32' do
    test_case = subject
    test_case.name = 'a' * 33
    expect(test_case).to_not be_valid
  end
  it 'should return name is not string' do
    test_case = subject
    test_case.name = 5
    expect(test_case).to_not be_valid
  end
  it 'should return photo url is less than length of 20' do
    test_case = subject
    test_case.photo = 's' * 19
    expect(test_case).to_not be_valid
  end
  it 'should return photo url is longer than length of 2000' do
    test_case = subject
    test_case.photo = 'a' * 2001
    expect(test_case).to_not be_valid
  end
  it 'should return photo url is not string' do
    test_case = subject
    test_case.photo = 5
    expect(test_case).to_not be_valid
  end
  it 'should return posts counter is greater than or equal zero' do
    test_case = subject
    test_case.posts_counter = -1
    expect(test_case).to_not be_valid
    test_case.posts_counter = 0
    expect(test_case).to be_valid
    test_case.posts_counter = 1
    expect(test_case).to be_valid
  end
  it 'should return posts counter is not number' do
    test_case = subject
    test_case.posts_counter = 'hi'
    expect(test_case).to_not be_valid
  end

  it 'should get the recent 3 posts' do
    test_case = subject
    Post.create(author: test_case, title: 'title', text: 'text')
    Post.create(author: test_case, title: 'title', text: 'text')
    Post.create(author: test_case, title: 'title', text: 'text')
    Post.create(author: test_case, title: 'title', text: 'text')
    Post.create(author: test_case, title: 'title', text: 'text')
    expect(test_case.posts_counter).to eq(5) # all posts
    recent_posts = test_case.recent_posts
    expect(recent_posts.length).to eq(3) # most recent 3 posts
    # check that the three comments in a desc ordering (newest frist)
    expect(recent_posts[0].created_at > recent_posts[2].created_at).to eq true
  end
end
