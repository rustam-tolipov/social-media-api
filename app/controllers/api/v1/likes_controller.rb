module Api
  module V1
    class LikesController < ApplicationController
      before_action :authenticate_user!, only: [:create, :update, :destroy]
      before_action :set_like, only: [:show, :update, :destroy]
      
      # GET /likes/1
      def show
        render json: @like
      end
      
      # POST /likes
      def create
        @like = Like.new(like_params)
        @like.user = current_user

        if @like.save
          render json: @like, status: :created
        else
          render_error(@like, :unprocessable_entity)
        end
      end
      
      # PATCH/PUT /likes/1
      def update
        if @like.update(like_params)
          render json: @like
        else
          render_error(@like, :unprocessable_entity)
        end
      end
      
      # DELETE /likes/1
      def destroy
        @like.destroy
      end
      
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_like
          @like = Like.find(params[:id])
        end
        
        # Only allow a list of trusted parameters through.
        def like_params
          params.permit(:likeable_id, :likeable_type, :user_id)
        end

        def render_error(object, status)
          render json: {
            errors: object.errors.full_messages
          }, status: status
        end
    end
  end
end