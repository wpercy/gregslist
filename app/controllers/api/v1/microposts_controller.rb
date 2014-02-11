module Api
  module V1
    class MicropostsController < ApplicationController
      before_filter :restrict_access
      respond_to :json

      def index
        respond_with Micropost.all
      end

      def show
        respond_with Micropost.find(params[:id])
      end

      def create
        respond_with Micropost.create(params[:product])
      end

      def update
        respond_with Micropost.update(params[:id], params[:product])
      end

      def destroy
        respond_with Micropost.destroy(params[:id])
      end

    private

        def restrict_access
          authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end
    end
  end
end
