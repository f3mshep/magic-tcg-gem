require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  SEARCH_URL = "https://scryfall.com/search?q="

  attr_accessor :query

  def initialize(query)
  	@query = query
  end

  def scrape_search_page
  	url =  self.input_parser
  	card_index = Nokogiri::HTML(open(url))

  	### if the following selctor returns a blank array 
  	cards = card_index.css('a.card-grid-item')
  	if cards.empty?

  	else
  		card_hash = {}
  		###card url = card.css(card['href'])
  		###card name =  card.css('img.card').attr('alt').text
  		cards.each do |card|
  			card_hash[:name] = card['href']
  			card_hash[:url] = card.css('img.card').attr('alt').text
  		end
  		binding.pry
  	end
  	### do this instead

  end

  def input_parser
  	input = self.query.downcase.split.collect{|string|string.scan(/[a-z]/)}
  	input = input.collect {|arr|arr.join("")}.join('+')
  	SEARCH_URL + input
  end

  def self.scrape_card_page(profile_url)

  end

end

