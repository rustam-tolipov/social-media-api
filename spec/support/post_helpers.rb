require 'faker'

module PostHelpers
  def build_post    
    image = fixture_file_upload(File.join(Rails.root, 'spec', 'support', 'images', 'test.png'), 'image/png')
    content = Faker::Lorem.paragraph
    user = build_user
    FactoryBot.build(:post, image: image, content: content, user: user)
  end
end