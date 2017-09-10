class Card

  attr_accessor :name, :rarity, :sets, :price, :rules_text, :flavor_text, :color, :cost, :purchase_url, :card_type, :combat_stats

  @@all = []

  def initialize(attributes)
    attributes.each {|method, trait| self.send(("#{method}="), trait)}
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create_from_collection(card_arr)
    card_arr.each do |card|
      new_card = Card.new(card)
    end
  end

end

