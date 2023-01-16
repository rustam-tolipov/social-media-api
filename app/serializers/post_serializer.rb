class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :image, :user_id, :user

  DEFAULT_AVATAR = 'https://res-2.cloudinary.com/dhatgaadw/image/upload/v1661765174/e0eiopj9eqt5dwnt5n2v.jpg'

  has_many :comments
  has_many :likes

  def user
    {
      id: object.user.id,
      username: object.user.username,
      first_name: object.user.first_name,
      last_name: object.user.last_name,
      avatar: user_avatar
    }
  end

  def user_avatar
    if object.user.avatar.url.present?
      object.user.avatar.url
    else
      DEFAULT_AVATAR
    end
  end
end
