require 'rails_helper'

RSpec.describe Post, type: :model do
  include PostHelpers

  before(:each) do
    @post = build_post
  end

  it 'is valid with valid attributes' do
    expect(@post).to be_valid
  end

  it 'is not valid without an image' do
    @post.image = nil
    expect(@post).to_not be_valid
  end
end