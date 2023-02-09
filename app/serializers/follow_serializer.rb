class FollowSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :avatar
  
  DEFAULT_AVATAR = 'https://res-2.cloudinary.com/dhatgaadw/image/upload/v1661765174/e0eiopj9eqt5dwnt5n2v.jpg'


  def avatar
    if object.avatar.thumb.url.present?
      object.avatar.thumb.url
    else
      DEFAULT_AVATAR
    end
  end
end
