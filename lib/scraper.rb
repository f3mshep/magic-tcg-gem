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
      card_collection
  	end
  	### do this instead

  end

  def input_parser
  	input = self.query.downcase.split.collect{|string|string.scan(/[a-z]/)}
  	input = input.collect {|arr|arr.join("")}.join('+')
  	SEARCH_URL + input
  end

  def color_finder(cost)

    colors = {'{W}' =>'White','{U}' => 'Blue','{B}' => 'Black','{R}' => 'Red','{G}' => 'Green'}
    matches = 0
    color_identity = "Colorless"

    colors.each do |symbol, value|
      if cost.include?(symbol)
        matches += 1
        color_identity = value
      end
    end


    if matches > 1
      "Multicolor"
    else
      color_identity
    end
  end

## output.match(/^.*(?=(\n))/)
#main > div.card-profile > div > div.card-text > p.card-text-type-line
  def scrape_card_page(profile_url)
    card_hash = {}
    card_profile = Nokogiri::HTML(open(profile_url))
    title_text = card_profile.css('h1.card-text-title').text.strip.gsub(/\n/, '||').split("||")
    card_hash[:name] = title_text.first
    card_hash[:cost] = title_text[1].gsub(/\s/,"")
    card_hash[:rarity] = card_profile.css('span.prints-current-set-details').text.strip.split(', ')[1]
    card_hash[:sets] = card_profile.css('tbody tr').collect {|element|element.css('td').text.strip[/^.*(?=(\n))/]}.delete_if{|element|element.nil?}
    card_hash[:price] = card_profile.css('span.price.currency-usd').text.split('$')[1]
    card_hash[:color] = color_finder(card_hash[:cost])
    card_hash[:purchase_url] = card_profile.css('#stores > ul > li:nth-child(1) > a').attr('href').text
    card_hash[:card_type] = card_profile.css('p.card-text-type-line').text.strip
    card_hash[:combat_stats] = card_profile.css('div.card-text-stats').text.strip
    card_hash[:card_text] = card_profile.css('div.card-text-oracle').text.strip
    card_hash[:flavor_text] = card_profile.css('div.card-text-flavor').text.strip
    card_hash.delete_if {|key, value| value == ""}
    card_hash
  end

end

