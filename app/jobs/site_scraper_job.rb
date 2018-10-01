class SiteScraperJob < ApplicationJob
  queue_as :default

  def perform(link_id:)
    # Do something later
    link = Link.find(link_id)
    url = link.url

    begin
      unparsed_page = HTTParty.get(url)
      parsed_page = Nokogiri::HTML(unparsed_page)
      title = parsed_page.title
      link.update_attributes(title: title)

    rescue => error
      link.update_attributes(title: "error: #{error.message}")
    end
  end
end
