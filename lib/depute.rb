require 'nokogiri'
require 'open-uri'
require 'rubygems'

#array avec le nom des députés
def deputy_name
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  deputy_name_array = []
  deputy_name = page.xpath("//*[@id='deputes-list']/div/ul/li/a").each do |name|
  deputy_name_array << name.text
  end 
  return deputy_name_array
end 

#def de l'url (pour ensuite allé chercher l'e-mail)
def url
  url_array = []
  page3 = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  url = page3.xpath("//*[@id='deputes-list']/div/ul/li/a/@href").each do |i|
  url_array << i.text 
  end
  return url_array
end

#cherche les e-mails et les mets dans un array
def e_mail_into_array(url)
  array_of_e_mail = []
  5.times do |i|
    page2 = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/#{url[i]}"))
    e_mail = page2.xpath("//*[@id='haut-contenu-page']/article/div[3]/div/dl/dd[4]/ul/li[2]/a").text
    array_of_e_mail << e_mail
  end
  return array_of_e_mail
end

#rassemble les deux arrays dans un hash
def hash_final(e_mail, deputy)
  hash_result = {}
  array_final = []
  i = 0
    deputy.each do
    hash_result = {deputy[i] => e_mail[i]}
    i+=1
    array_final << hash_result
    end
  print array_final
end

#perform le tout
def perform
  e_mail_into_array = e_mail_into_array(url)
  hash_final(e_mail_into_array, deputy_name)
end
perform