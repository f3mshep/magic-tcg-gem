require_relative "../lib/scraper.rb"
require_relative "../lib/card.rb"
require 'nokogiri'
require 'colorize'

class CommandLine

	CARD_ATTRIBUTES = [:name, :rarity, :sets, :price, :rules_text, :flavor_text, :color, :cost, :purchase_url, :card_type, :combat_stats]

	def clear_screen
		print %x{clear}
	end

	def start_screen
		clear_screen
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
		puts "Please enter the name of a card you want to find"
		gets.strip
	end

	def call_scraper(input)
		card_arr = []
		new_search = Scraper.new(input)
		results = new_search.scrape_search_page
		return card_arr if results == []
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
		clear_screen
		Card.all.each_with_index do |card, index|
			puts "#{index + 1}.#{card.name}" 
		end
	end

	def access_list
		max = Card.all.size + 1
		puts "Please make a selection"
		input = gets.strip.to_i - 1
		if input < 0 || input > max
			puts "Invalid selection"
			access_list
		end
		puts "#{max}. New search "
		run if input == max.to_s
		input
	end

	def load_card(input)
		chosen_card = Card.all[input]
		CARD_ATTRIBUTES.each do |attr, value|
			puts chosen_card.send("#{attr}")
		end
	end

	def card_menu
		list_cards
		input = access_list
		clear_screen
		load_card(input)
		interaction
	end

	def interaction
		puts "Please make a selection"
		puts "1. Return to card list"
		puts "2. New search"
		puts "3. Exit"
		input = gets.strip.downcase
		case input
		when "1"
			card_menu
		when "2"
			run 
		when "3"
			clear_screen
			exit
		else
			puts "Invalid selection"
			interaction
		end
			
	end

	def try_again
			puts ""
			puts "Please make a selection:"
			puts "1. Search for a new card"
			puts "2. Exit this program"
			input = gets.strip

			case input
			when "1"
				run
			when "2"
				clear_screen
				exit
			else
				"Please enter a valid selection"
				try_again
			end
	end

	def run
		Card.destroy_all
		query = get_query
		clear_screen
		card_arr = call_scraper(query)
		if card_arr == []
			puts "No results found"
			try_again
		end
		create_cards(card_arr)
		card_menu
		interaction
	end


end
