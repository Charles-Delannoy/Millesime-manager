# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'

url_bordeaux = "https://www.nicolas.com/fr/Vins/Vins-du-Rhone/c/0119/"

bx_doc = Nokogiri::HTML(open(url_bordeaux).read)
bx_doc.search('.ns-Product a.ns-Button').each do |element|
  bottle_url = "https://www.nicolas.com/#{element.attribute('href').value}"

  if bottle_url[-3..-1] != "pdf"

    html_doc = Nokogiri::HTML(open(bottle_url).read)
    p img_url = html_doc.search('.ns-Product-img')[0].attribute('src').value
    # Nom du vin et millesime
    bottle_full_name = html_doc.search('.ns-Product-title')[0].text.strip
    p bottle_name = bottle_full_name[0..(bottle_full_name.length - 5)].strip
    p millesime = bottle_full_name[-4..-1].to_i
    #chateau
    p html_doc.search('.ns-DomainName-itemTitle')[0].text.strip
    #Region du vin
    p region = html_doc.search('.ns-Product-district')[0].text.strip
    # Appelation du vin
    p appelation = html_doc.search('.ns-Product-cara')[0].text.strip
    # Degre et couleur du vin
    if html_doc.search('.ns-Product-cara')[2].nil?
      p degre = html_doc.search('.ns-Product-cara')[1].text.strip.split('|')[1].split('°')[0].strip.to_i
      p color = html_doc.search('.ns-Product-cara')[1].text.strip.split('|')[0].split(' ')[0]
    else
      p degre = html_doc.search('.ns-Product-cara')[2].text.strip.split('|')[1].split('°')[0].strip.to_i
      p color = html_doc.search('.ns-Product-cara')[2].text.strip.split('|')[0].split(' ')[0]
    end
    # Meal associations
    html_doc.search('.ns-AgreementList-description').each do |meal|
      p meal_name = meal.text
    end
    i = 1
    # noms et pourcentage des cepages
    cepages = html_doc.search('.ns-Chart-legend li span')
    cepages.each do |cepage|
      if i%2 == 0
        if cepage.text.split(':')[1].nil?
          p cepage_percentage = (100 / cepages.length)
          p cepage_name = cepage.text
          p cepage_percentage = (100 / cepages.length)
        else
          p cepage_percentage = cepage.text.split(':')[1].split('%')[0].strip.to_i
        end
      else
        p cepage_name = cepage.text
      end
      i += 1
    end
    p "---------------------------"
  end
end



# url = "https://www.nicolas.com/fr/Vins/Baron-De-Lestac-Signature-2018/p/485644.html"
# url = "https://www.nicolas.com/fr/Vins/M-de-Magnol-Rouge-2017/p/479561.html"

# html_doc = Nokogiri::HTML(open(url).read)
# # URL IMAGE
# p img_url = html_doc.search('.ns-Product-img')[0].attribute('src').value
# # Nom du vin
# p bottle_name = html_doc.search('.ns-Product-title')[0].text.strip
# #Region du vin
# p region = html_doc.search('.ns-Product-district')[0].text.strip
# # Appelation du vin
# p appelation = html_doc.search('.ns-Product-cara')[0].text.strip
# # Degre et couleur du vin
# if html_doc.search('.ns-Product-cara')[2].nil?
#   p degre = html_doc.search('.ns-Product-cara')[1].text.strip.split('|')[1].split('°')[0].strip.to_i
#   p color = html_doc.search('.ns-Product-cara')[1].text.strip.split('|')[0].split(' ')[0]
# else
#   p degre = html_doc.search('.ns-Product-cara')[2].text.strip.split('|')[1].split('°')[0].strip.to_i
#   p color = html_doc.search('.ns-Product-cara')[2].text.strip.split('|')[0].split(' ')[0]
# end
# # Meal association
# html_doc.search('.ns-AgreementList-description').each do |meal|
#   p meal_name = meal.text
# end
# i = 1
# # noms et pourcentage des cepages
# cepages = html_doc.search('.ns-Chart-legend li span')
# cepages.each do |cepage|
#   if i%2 == 0
#     if cepage.text.split(':')[1].nil?
#       p cepage_percentage = (100 / cepages.length)
#       p cepage_name = cepage.text
#       p cepage_percentage = (100 / cepages.length)
#     else
#       p cepage_percentage = cepage.text.split(':')[1].split('%')[0].strip.to_i
#     end
#   else
#     p cepage_name = cepage.text
#   end
#   i += 1
# end
