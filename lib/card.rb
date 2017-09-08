class Card

  attr_accessor :name, :rarity, :set, :price, :rules_text

  @@all = []

  def initialize()

  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def self.create_from_collection()

  end

  def self.card_attributes()
    
  end

end

