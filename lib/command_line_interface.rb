require_relative "../lib/scraper.rb"
require_relative "../lib/card.rb"
require 'nokogiri'
require 'colorize'

class CommandLine

	CARD_ATTRIBUTES = [:name, :rarity, :sets, :price, :rules_text, :flavor_text, :color, :cost, :purchase_url, :card_type, :combat_stats]

	def start_screen

		puts "		    _            _____ _              ___      _   _               _             ".colorize(:light_green)
		puts "  /\\/\\   __ _  __ _(_) ___   _  /__   \\ |__   ___    / _ \\__ _| |_| |__   ___ _ __(_)_ __   __ _ ".colorize(:light_green)
		puts " /    \\ / _` |/ _` | |/ __| (_)   / /\\/ '_ \\ / _ \\  / /_\\/ _` | __| '_ \\ / _ \\ '__| | '_ \\ / _` |".colorize(:light_green)
		puts "/ /\\/\\ \\ (_| | (_| | | (__   _   / /  | | | |  __/ / /_\\\\ (_| | |_| | | |  __/ |  | | | | | (_| |".colorize(:light_green)
		puts "\\/    \\/\\__,_|\\__, |_|\\___| (_)  \\/   |_| |_|\\___| \\____/\\__,_|\\__|_| |_|\\___|_|  |_|_| |_|\\__, |".colorize(:light_green)
		puts "              |___/                                                                        |___/ ".colorize(:light_green)
		puts "                    ___              _     ___ _           _                                     ".colorize(:light_green)
		puts "                   / __\\__ _ _ __ __| |   / __(_)_ __   __| | ___ _ __                           ".colorize(:light_green)
		puts "                  / /  / _` | '__/ _` |  / _\\ | | '_ \\ / _` |/ _ \\ '__|                          ".colorize(:light_green)
		puts "                 / /__| (_| | | | (_| | / /   | | | | | (_| |  __/ |                             ".colorize(:light_green)
		puts "                 \\____/\\__,_|_|  \\__,_| \\/    |_|_| |_|\\__,_|\\___|_|                             ".colorize(:light_green)
	  
	  puts ""                             

	  	run
	end

	def get_query
		puts "Please enter the name of a card you want to find:"
		gets.strip
	end

	def call_scraper(input)
		new_search = Scraper.new(input)
		results = new_search.scrape_search_page
		card_arr = []
		results.each do |card_hash|
			card_hash.each do |key, value|
				if key == :url
					card_arr << new_search.scrape_card_page(value)
				end
			end
		end
		card_arr
	end

	def create_cards(card_arr)
		Card.create_from_collection(card_arr)
	end

	def list_cards
		Card.all.each_with_index do |card, index|
			puts "#{index + 1}.#{card.name}" 
		end
	end

	def access_list
		puts "Please make a selection"
		input = gets.strip.to_i - 1
		if input < 0 || input > Card.all.size
			puts "Invalid selection"
			access_list
		end
		input
	end

	def load_card(input)
		chosen_card = Card.all[input]
		CARD_ATTRIBUTES.each do |attr, value|
			puts chosen_card.send("#{attr}")
		end
	end

	def run
		Card.destroy_all
		query = get_query
		card_arr = call_scraper(query)
		create_cards(card_arr)
		list_cards
		input = access_list
		load_card(input)
		puts "Would you like to view another card? Y/N"
		input = gets.strip.downcase
		run if input == "y"
		exit
	end


end
