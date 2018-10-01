require 'rails_helper'

describe SiteScraperJob do
  #it 'scrapes the title of the website and stores it with the link' do
    #link = Link.create(url: 'https://www.nike.com/us/en_us/')
    #SiteScraperJob.new.perform({link_id: link.id })

    #link.reload
    #expect(link.title).to eq('Nike. Just Do It. Nike.com')
  #end

  context 'site fails to load' do
    it 'stores an error message on the link' do
      allow(HTTParty).to receive(:get).and_raise("boom")

    link = Link.create(url: 'https://www.nike.com/us/en_us/')
    SiteScraperJob.new.perform({link_id: link.id })

    link.reload
    expect(link.title).to eq('error: boom')
    end
  end
end
