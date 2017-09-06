require "spec_helper"

describe "Scraper" do

  describe "new" do
    it "takes in the query of a desired card as an argument and instantiates it"
  end

  describe "#input_parser" do
    it "takes the desired query and returns the appropriate search URL"
    
  end

  describe "#scrape_search_page" do
    it "is a method that scrapes the search page of TCGPlayer and returns an array of hashes with the card name, set, rarity, and URL as keys with their appropriate values"
    
  end

  describe "#scrape_card_page" do
    it "accepts the URL of a card page as a parameter"
    it "is a method that scrapes the card page from TCG player and returns an array of hashes with the rules and price"
  end

end
