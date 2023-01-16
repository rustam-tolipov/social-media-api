class SuggestionSerializer < ActiveModel::Serializer
  attributes :user

  DEFAULT_AVATAR = 'https://res-2.cloudinary.com/dhatgaadw/image/upload/v1661765174/e0eiopj9eqt5dwnt5n2v.jpg'

  def user
    {
      id: object.id,
      username: object.username,
      first_name: object.first_name,
      last_name: object.last_name,
      avatar: user_avatar
    }
  end

  def user_avatar
    if object.avatar.url.present?
      object.avatar.url
    else
      DEFAULT_AVATAR
    end
  end
end
