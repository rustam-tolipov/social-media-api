class FollowSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :avatar

  def avatar
    object.avatar.thumb.url
  end
end
