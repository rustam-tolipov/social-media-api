class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :likeable_id, :likeable_type
end
