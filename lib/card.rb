class Card

  attr_accessor :name, :rarity, :sets, :price, :rules_text, :flavor_text, :color, :cost, :purchase_url, :creature_stats, :combat_stats

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

