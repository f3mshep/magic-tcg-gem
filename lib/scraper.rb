require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  SEARCH_URL = "http://shop.tcgplayer.com/magic/product/show?ProductName="

  attr_accessor :query

  def initialize(query)
  	@query = query
  end

  def scrape_search_page
  	url =  self.input_parser

  end

  def input_parser
  	input = self.query.downcase.split.collect{|string|string.scan(/[a-z]/)}
  	input = input.collect {|arr|arr.join("")}.join('+')
  	SEARCH_URL + input
  end

  def self.scrape_card_page(profile_url)

  end

end

