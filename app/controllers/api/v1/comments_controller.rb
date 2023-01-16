module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user!, only: [:create, :destroy]
      before_action :set_comment, only: [:update, :destroy, :like, :unlike]
      before_action :set_post, only: [:index, :create]

      # GET /posts/1/comments
      def index
        @comments = @post.comments.all
        render json: @comments
      end
    
      # POST /posts/1/comments
      def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @comment.post_id = @post.id
        
        if @comment.save
          render json: @comment, status: :created
        else
          render_error(@comment, :unprocessable_entity)
        end
      end

      def already_liked?(comment)
        comment.likes.where(user_id: current_user.id).exists?
      end

      # POST /posts/1/comments/1/like
      def like
        if already_liked?(@comment)
          render json: {
            message: "You already liked this comment"
          }, status: :bad_request
        else
          @like = @comment.likes.new(user_id: current_user.id)
          if @like.save
            render json: {
              message: "❤️"
            }, status: :created
          else
            render_error(@like, :unprocessable_entity)
          end
        end
      end

      # POST /posts/1/comments/1/unlike
      def unlike
        if already_liked?(@comment)
          @like = @comment.likes.find_by(user_id: current_user.id)
          @like.destroy
          render json: {
            message: "💔"
          }, status: :ok
        else
          render json: {
            message: "You haven't liked this comment"
          }, status: :bad_request
        end
      end
    
      # DELETE /comments/1
      def destroy
        @comment.destroy
      end

      # Display user of comment in json
      def comment_user
        @user = User.find(params[:id])
        render json: @user, serializer: SuggestionSerializer, status: :ok
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_comment
          @comment = Comment.find(params[:id])
        end

        # Set post
        def set_post
          @post = Post.find(params[:post_id])
        end
    
        # Only allow a list of trusted parameters through.
        def comment_params
          params.permit(:content, :user_id, :post_id)
        end

        # Render error message
        def render_error(object, status)
          render json: {
            errors: object.errors.full_messages
          }, status: status
        end
    end
  end
end