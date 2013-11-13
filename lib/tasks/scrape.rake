require 'nokogiri'
require 'open-uri'

namespace :scrape do
  desc "Scrape the Travel.gc.ca site for wait times"

  task times: :environment do   
    canada_bound_source = 'http://travel.gc.ca/vt/dynamic/eng/border-times.aspx'
    usa_bound_source = 'http://travel.gc.ca/travelling/border-times-us'
    
    scrape(canada_bound_source, 'canada')
    scrape(usa_bound_source, 'usa')

  end
end

def scrape(source, bound)
  doc = Nokogiri::HTML(open(source))
  doc.xpath('//table[@class = "wet-boew-zebra span-6"]//tr')[1..-1].each do |row|
    info, commercial, travellers = row.xpath('.//td')
    title = info.xpath('.//strong').text
    location = info.xpath('./text()')[0].text    
    crossing = Crossing.find_or_create(title.strip, location.strip)
    unless commercial.text.include? 'Not applicable' then
      # commercial = 0 if /not applicable/i.match(commercial.text)
      WaitTime.create({
        :bound => bound.strip,
        :duration => commercial.text,
        :commercial => true,
        :crossing_id => crossing.id
        })
    end
    unless travellers.text.include? 'Not applicable' then
      WaitTime.create({
        :bound => bound.strip,
        :duration => travellers.text,
        :commercial => false,
        :crossing_id => crossing.id
        })    
    end
  end
end