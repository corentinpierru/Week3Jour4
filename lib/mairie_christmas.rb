require 'nokogiri'
require 'open-uri'
require 'rubygems'


#array avec le nom des députés
def nom_de_ville
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  city_name_array = []
  city_name = page.xpath("//a[@class='lientxt']").each do |city|
    city_name_array << city.text
  end 
  return city_name_array
end

#def de l'url (pour ensuite allé chercher l'e-mail)
def e_mail_into_array(url)
  array_of_e_mail = []
  url.size.times do |i|
    page2 = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/#{url[i]}"))
    e_mail = page2.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
    array_of_e_mail << e_mail
  end
  return array_of_e_mail
end

#cherche les e-mails et les mets dans un array
def url
  url_array = []
  page3 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    url = page3.xpath("//a[contains(@href, '95')]/@href").each do |i|
    url_array << i.text 
    end
  return url_array
end

#rassemble les deux arrays dans un hash
def hash_final(e_mail, city_name)
  hash_result = {}
  array_final = []
  i = 0
    city_name.each do
    hash_result = {city_name[i] => e_mail[i]}
    i+=1
    array_final << hash_result
    end
  print array_final
end

#perform : va chercher les e-mails grâce à l'URL et hash finale grâce à nom de ville et e-mail into array
def perform
e_mail_into_array = e_mail_into_array(url)
hash_final(e_mail_into_array, nom_de_ville)
end
perform



