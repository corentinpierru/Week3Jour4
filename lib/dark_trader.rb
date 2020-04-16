require 'nokogiri'
require 'open-uri'
require 'rubygems'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

crypto_names_array = []
crypto_names = page.xpath("//td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol']/div").each do |crypto|
  crypto_names_array << crypto.text
end
crypto_prices_array = []
crypto_prices = page.xpath("//td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price']/a").each do |price|
  crypto_prices_array << price.text
end 

hash_result = {}
array_final = []
i = 0
crypto_names_array.each do
  hash_result = {crypto_names_array[i] => crypto_prices_array[i]}
  i+=1
  array_final << hash_result
end
print array_final
  





