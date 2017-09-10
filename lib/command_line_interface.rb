require_relative "../lib/scraper.rb"
require_relative "../lib/card.rb"
require 'nokogiri'
require 'colorize'

class CommandLine

	def place_logo

		puts "		                _            _____ _              ___      _   _               _             ".colorize.(:light_green)
		puts "  /\\/\\   __ _  __ _(_) ___   _  /__   \\ |__   ___    / _ \\__ _| |_| |__   ___ _ __(_)_ __   __ _ ".colorize.(:light_green)
		puts " /    \\ / _` |/ _` | |/ __| (_)   / /\\/ '_ \\ / _ \\  / /_\\/ _` | __| '_ \\ / _ \\ '__| | '_ \\ / _` |".colorize.(:light_green)
		puts "/ /\\/\\ \\ (_| | (_| | | (__   _   / /  | | | |  __/ / /_\\\\ (_| | |_| | | |  __/ |  | | | | | (_| |".colorize.(:light_green)
		puts "\\/    \\/\\__,_|\\__, |_|\\___| (_)  \\/   |_| |_|\\___| \\____/\\__,_|\\__|_| |_|\\___|_|  |_|_| |_|\\__, |".colorize.(:light_green)
		puts "              |___/                                                                        |___/ ".colorize.(:light_green)
		puts "                    ___              _     ___ _           _                                     ".colorize.(:light_green)
		puts "                   / __\\__ _ _ __ __| |   / __(_)_ __   __| | ___ _ __                           ".colorize.(:light_green)
		puts "                  / /  / _` | '__/ _` |  / _\\ | | '_ \\ / _` |/ _ \\ '__|                          ".colorize.(:light_green)
		puts "                 / /__| (_| | | | (_| | / /   | | | | | (_| |  __/ |                             ".colorize.(:light_green)
		puts "                 \\____/\\__,_|_|  \\__,_| \\/    |_|_| |_|\\__,_|\\___|_|                             ".colorize.(:light_green)
	  
	  puts ""                             

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
		counter = 1
		Card.all.each do |attr, value|
			if attr == :name
				puts "#{counter}. value"
				counter += 1
			end
		end
	end

	def access_list
	end


end
