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
  		[{name: 'placeholder', url: url}]
  	else
  		###card url = card.css(card['href'])
  		###card name =  card.css('img.card').attr('alt').text
  		card_collection = []
  		cards.each do |card|
  			card_hash = {}
  			card_hash[:name] = card.css('img.card').attr('alt').text
  			card_hash[:url] = "https://scryfall.com" + card['href']
  			card_collection << card_hash
  		end
  	end
  	### do this instead

  end

  def input_parser
  	input = self.query.downcase.split.collect{|string|string.scan(/[a-z]/)}
  	input = input.collect {|arr|arr.join("")}.join('+')
  	SEARCH_URL + input
  end


  def scrape_card_page(profile_url)
    card_profile = Nokogiri::HTML(open(profile_url))
    binding.pry
    name_text = 
    rarity = 
    sets = card_profile.css('tbody tr').collect {|element|element.css.(td).first.text.strip}
    price = 
    color = 
    cost = 
    purchase_url = 
    creature_stats =
    combat_stats = 
    card_text = card_profile.css('div.card-text-oracle').text.strip
    flavor_text = card_profile.css('div.card-text-flavor').text.strip

  end

end

