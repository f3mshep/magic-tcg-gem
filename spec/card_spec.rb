require "spec_helper"

describe "Card" do 

  let!(:card_array) {[
  {name: "Riptide Replicator", set: "Onslaught", rarity: "Rare"},
  {name: "Scareshift", set: "Morningtide", rarity: "Rare"},
  {name: "Sakura-Tribe Elder", set: "Champions of Kamigawa", rarity: "Common"}
  ]}

  let!(:card_info) {[
  {price: "$.99", rules_text: "reveal cards from the top of your library until you reveal an artifact card. Put that card onto the battlefield and the rest on the bottom of your library in a random order. Madcap Experiment deals damage to you equal to the number of cards revealed this way."}
  ]}

  let!(:sample_card) {Card.new({name:"Madcap Experiment", set:"Kaladesh", rarity:"Mythic"})}

   after(:each) do
    Card.destroy_all
  end

  describe "#name" do
    it "Gets and sets the name attribute" do
      Card.instance_methods.include? :name
      Card.instance_methods.include? :name=
    end 
  end

  describe "#rarity" do
    it "Gets and sets the rarity attribute" do
      Card.instance_methods.include? :rarity
      Card.instance_methods.include? :rarity=
    end
  end

  describe "#set" do 
    it "Gets and sets the set attribute" do
      Card.instance_methods.include? :set
      Card.instance_methods.include? :set=
    end
  end 

  describe "#price" do
    it "Gets and sets the price attribute" do
      Card.instance_methods.include? :price
      Card.instance_methods.include? :price=
    end
  end

  describe "#rules_text" do
    it "Gets and sets the rules text attribute" do
      Card.instance_methods.include? :rules_text
      Card.instance_methods.include? :rules_text=
    end
  end


  describe "#new" do
    it "Takes in a hash as an argument and sets the card's attributes to their corresponding key/value pairs" do
      expect{Card.new({name: "Merfolk Looter", set: "M12", rarity: "Common"})}.to_not raise_error
      expect(sample_card.name).to eq("Madcap Experiment")
    end

    it "Adds the new card to the class's @@all array" do
      card = Card.new
      expect(Card.all).to include("card")
    end

  end

  describe ".destroy_all" do
    it "clears @@all" do
      expect(Card.all).to match_array([])
    end
  end 

  describe ".all" do
    it "returns the class variable all" do
      Card.class_variable_set(:@@all, [])
      expect(Card.all).to match_array([])
    end
  end

  describe ".create_from_collection" do
    it "It turns a hash into an object that responds to the appropriate accessor methods" do
      Card.class_variable_set(:@@all, [])
      Card.create_from_collection(card_array)
      expect(Card.class_variable_get(:@@all).first.name).to eq("Riptide Replicator")
      expect(Card.class_variable_get(:@@all).first.set).to eq("Onslaught")
    end
  end

  describe "#card_attributes" do
    it "Adds attributes to an instance of the card class" do
      sample_card.card_attributes(card_info)
      expect(sample_card.price).to eq("$.99")
      expect(sample_card.rules_text).to eq("Reveal cards from the top of your library until you reveal an artifact card. Put that card onto the battlefield and the rest on the bottom of your library in a random order. Madcap Experiment deals damage to you equal to the number of cards revealed this way.")
    end
  end

end


