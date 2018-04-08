# require 'bundler/inline'

# gemfile(true) do
#   source 'https://rubygems.org'
#    ruby '2.4.1'

#   gem 'httparty'
#   gem 'nokogiri'
#   gem 'pry'
# end


require 'httparty'
require 'nokogiri'
require 'json'
require 'pry'

# doc = HTTParty.get("https://store.nike.com/us/en_us/pw/mens-nikeid-lifestyle-shoes/1k9Z7puZoneZoi3")
# @parse_page ||=  Nokogiri::HTML(doc)


class Scraper
	attr_accessor :parse_page
	def initialize
		doc = HTTParty.get("https://store.nike.com/us/en_us/pw/mens-nikeid-lifestyle-shoes/1k9Z7puZoneZoi3")
		@parse_page ||=  Nokogiri::HTML(doc)
	end

	def get_names
		item_container.css(".product-name").css("p").children.map{ |name| name.text }.compact
	end

	def get_prices
		item_container.css(".product-price").css("span.local").children.map{ |price| price.text }.compact
	end

private
	def item_container
		parse_page.css(".grid-item-info")
	end	

	scrapper = Scraper.new
	names = scrapper.get_names
	prices = scrapper.get_prices

	(0...prices.size).each do |index|
		puts "------------- index: #{index -1} -----------"
		puts " Name: #{names[index]} | Price : #{prices[index]} -----------"
	end
end
