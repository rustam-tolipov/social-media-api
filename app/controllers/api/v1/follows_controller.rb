module Api
  module V1
    class FollowsController < ApplicationController
      before_action :authenticate_user!, only: [:create, :update, :destroy]
      before_action :set_follow, only: [:show, :update, :destroy]
    
      # GET /follows
      def index
        @follows = Follow.all
    
        render json: @follows
      end
    
      # GET /follows/1
      def show
        render json: @follow
      end
    
      # POST /follows
      def create
        @follow = Follow.new(follow_params)
    
        if @follow.save
          render json: @follow, status: :created, location: @follow
        else
          render_error(@follow, :unprocessable_entity)
        end
      end
    
      # PATCH/PUT /follows/1
      def update
        if @follow.update(follow_params)
          render json: @follow
        else
          render_error(@follow, :unprocessable_entity)
        end
      end
    
      # DELETE /follows/1
      def destroy
        @follow.destroy
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_follow
          @follow = Follow.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def follow_params
          params.fetch(:follow, {})
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