module API::V1
  class LinksController < ApplicationController
    def create
      link = Link.new(link_params)

      if link.save
        render json: link, status: :ok
      else
        render link.errors.full_messages, status: 400
      end
    end

    private

    def link_params
      params.require(:link).permit(:url)
    end
  end
end
