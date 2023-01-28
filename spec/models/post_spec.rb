require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.new(name: 'v', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'developer')
  subject { Post.new(author: user, title: 'title', text: 'text') }
  before { subject }

  it 'should return author is nil' do
    test_case = subject
    test_case.author = nil
    expect(test_case).to_not be_valid
  end
  it 'should return title is nil or blank or less than length of 4' do
    test_case = subject
    test_case.title = nil
    expect(test_case).to_not be_valid
    test_case.title = ''
    expect(test_case).to_not be_valid
  end
  it 'should return title is less than length of 4' do
    test_case = subject
    test_case.title = 'sai'
    expect(test_case).to_not be_valid
  end
  it 'should return title is longer than length of 250' do
    test_case = subject
    test_case.title = 'a' * 251
    expect(test_case).to_not be_valid
  end
  it 'should return title is not string' do
    test_case = subject
    test_case.title = 5
    expect(test_case).to_not be_valid
  end
  it 'should return comments counter is greater than or equal zero' do
    test_case = subject
    test_case.comments_counter = -1
    expect(test_case).to_not be_valid
    test_case.comments_counter = 0
    expect(test_case).to be_valid
    test_case.comments_counter = 1
    expect(test_case).to be_valid
  end
  it 'should return comments counter is not number' do
    test_case = subject
    test_case.comments_counter = 'hi'
    expect(test_case).to_not be_valid
  end
  it 'should return likes counter is greater than or equal zero' do
    test_case = subject
    test_case.likes_counter = -1
    expect(test_case).to_not be_valid
    test_case.likes_counter = 0
    expect(test_case).to be_valid
    test_case.likes_counter = 1
    expect(test_case).to be_valid
  end
  it 'should return likes counter is not number' do
    test_case = subject
    test_case.likes_counter = 'hi'
    expect(test_case).to_not be_valid
  end
  it 'should  get the recent 5 comments' do
    test_case = subject
    Comment.create(author: user, post: test_case, text: 'comment text')
    Comment.create(author: user, post: test_case, text: 'comment text')
    Comment.create(author: user, post: test_case, text: 'comment text')
    Comment.create(author: user, post: test_case, text: 'comment text')
    Comment.create(author: user, post: test_case, text: 'comment text')
    Comment.create(author: user, post: test_case, text: 'comment text')
    Comment.create(author: user, post: test_case, text: 'comment text')
    expect(test_case.comments_counter).to eq(7) # all comments
    recent_comments = test_case.recent_comments
    expect(recent_comments.length).to eq(5) # most recent 5 comments
    # check that the fice comments in a desc ordering (newest frist)
    expect(recent_comments[0].created_at > recent_comments[4].created_at).to eq true
  end
end
