require "spec_helper"

describe "Scraper" do

  describe ".new" do
    it "takes in the query of the desired card as an argument and instantiates the object" do
      expect{Scraper.new("Merfolk Looter")}.to_not raise_error
    end
  end

  describe "#query" do
    it "Gets and sets the query attribute" do
      Card.instance_methods.include? :query
      Card.instance_methods.include? :query=
    end 
  end

  describe "#input_parser" do
    it "returns a correctly formatted search URL" do
       card = Scraper.new("Gaea's Cradle")
      (card.input_parser).should include("https://scryfall.com/search?q=riptide+replicator=gaeas+cradle")
    end
  end

  describe "#scrape_search_page" do
    # it "is a method that scrapes the search page of TCGPlayer" do

    # end
    #How to implement this?
    it "calls the input parser method" do
      card = Scraper.new("Gaea's Cradle")
      expect(card).to receive(:input_parser)
      card.scrape_search_page
    end
    it " returns an array with a  hash with the card name and URL as keys with their appropriate values" do 
      card = Scraper.new("Riptide Replicator")
      card_array = card.scrape_search_page
      expect(card_array).to be_an_instance_of(Array)
      card_array.should include({name: "Riptide Replicator", url: 'https://scryfall.com/search?q=riptide+replicator'})
    end
    
  end

  describe "#scrape_card_page" do
    it "accepts the URL of a card page as a parameter" do
      card = Scraper.new("Merfolk Looter")
      expect(card.scrape_card_page("http://shop.tcgplayer.com/magic/magic-2012-m12/merfolk-looter")).to_not raise_error
    end
    it "is a method that scrapes the card page from TCG player and returns a hash with the rules and price" do
      card = Scraper.new("Merfolk Looter")
      (card.scrape_card_page("http://shop.tcgplayer.com/magic/magic-2012-m12/merfolk-looter")).should include(rules_text: "T: Draw a card, then discard a card.", price: "$0.06")
    end
  end

end
