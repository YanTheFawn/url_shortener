module API::V1
  class LinksController < ApplicationController
    before_action :format_url, only: [:show]

    def show
      link = Link.find_by_shortened_url!(shortened_url_from_params)
      link.increment!(:access_count)

      redirect_to link.url
    end

    def create
      link = Link.new(link_params)

      if link.save
        SiteScraperJob.perform_later({link_id: link.id})

        render json: link, status: :ok
      else
        render link.errors.full_messages, status: 400
      end
    end

    def most_popular
      render json: Link.most_popular, status: 200
    end

    private

    def format_url
      params[:link][:url] = params[:link][:url].strip
    end

    def link_params
      params.require(:link).permit(:url)
    end

    def shortened_url_from_params
      params[:shortened_url].gsub(Link.url_prefix, "").strip
    end
  end
end
