require "spec_helper"

describe "Card" do 

  describe "#new" do
    it "Takes in a hash as an argument and sets the card's attributes to their corresponding key/value pairs" do
    end

    it "Adds the new card to the class's @@all array" do
    end
  end

  describe ".all" do
    it "returns the class variable all" do
      Card.class_variable_set(:@@all, [])
      expect(Student.all).to match_array([])
    end
  end

  describe


end


# def self.all
#     @@all
#   end

#   def self.create_from_collection()

#   end

#   def card_attributes()
    
#   end