module Api
  module V1
    class SuggestionsController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      SUGGESTED_USERS_LIMIT = 5

      def index
        @users = User.all.sample(SUGGESTED_USERS_LIMIT).reject { |user| user.id == current_user.id || current_user.followees.include?(user) }
        render json: @users, each_serializer: SuggestionSerializer, status: :ok
      end
    end
  end
end