module Api
  module V1
    class CommentsUserController < ApplicationController
      def user
        @user = User.find(params[:id])
        @posts = @user.posts.all.order(created_at: :desc)
        render json: @posts, each_serializer: SuggestionSerializer, status: :ok
      end
    end
  end
end