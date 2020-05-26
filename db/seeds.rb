# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'

base_url = "https://www.nicolas.com/fr/"
base_html_doc = Nokogiri::HTML(open(base_url).read)
base_html_doc.search('.ns-LayerMenu-link').first(10).each do |url|
  p wine_url = "https://www.nicolas.com#{url.attribute('href').value}"

  bx_doc = Nokogiri::HTML(open(wine_url).read)
  bx_doc.search('.ns-Product a.ns-Button').each do |element|
    bottle_url = "https://www.nicolas.com/#{element.attribute('href').value}"

    if bottle_url[-3..-1] != "pdf"

      html_doc = Nokogiri::HTML(open(bottle_url).read)
      p img_url = html_doc.search('.ns-Product-img')[0].attribute('src').value
      # Nom du vin et millesime
      bottle_full_name = html_doc.search('.ns-Product-title')[0].text.strip
      p bottle_name = bottle_full_name[0..(bottle_full_name.length - 5)].strip
      p millesime = bottle_full_name[-4..-1].to_i

      if millesime < 1000 || bottle_name == "CHINON ROSE JM RAFFAULT" || bottle_name == "Maison Castel Grande Réserve Pinot Noir Rosé"
        p 'NON VALID'
      else


        #chateau
        p 'CHATEAU'
        p castle_name = html_doc.search('.ns-DomainName-itemTitle')[0].text.strip
        Castle.create(name: castle_name)

        if Castle.where(name: castle_name).empty?
          my_castle = Castle.new(name: castle_name)
          my_castle.save
        else
          my_castle = Castle.where(name: castle_name)[0]
        end


        #Region du vin
        p region = html_doc.search('.ns-Product-district')[0].text.strip

        if Region.where(name: region).empty?
          my_region = Region.new(name: region)
          my_region.save
        else
          my_region = Region.where(name: region)[0]
        end


        #APOGEE
        p 'apogee'
        best_year = html_doc.search('.ns-ProductGrappe-value--level')[0].text.strip.to_i
        if best_year == 0
          p apogee_start = millesime - 3
          p apogee_end = millesime + 3
        else
          year_diff = best_year - millesime
          p apogee_start = best_year - year_diff/2
          p apogee_end = best_year + year_diff/2
        end
        p 'Apogee'


        # Appelation du vin
        p appelation = html_doc.search('.ns-Product-cara')[0].text.strip
        if Appelation.where(name: appelation).empty?
          my_appelation = Appelation.new(name: appelation)
          my_appelation.region = my_region
          my_appelation.save
        else
          my_appelation = Appelation.where(name: appelation)[0]
        end


        # Degre et couleur du vin
        if html_doc.search('.ns-Product-cara')[2].nil?
          p degre = html_doc.search('.ns-Product-cara')[1].text.strip.split('|')[1].split('°')[0].strip.to_i
          p color = html_doc.search('.ns-Product-cara')[1].text.strip.split('|')[0].split(' ')[0]
        else
          p degre = html_doc.search('.ns-Product-cara')[2].text.strip.split('|')[1].split('°')[0].strip.to_i
          p color = html_doc.search('.ns-Product-cara')[2].text.strip.split('|')[0].split(' ')[0]
        end

        #CREATE THE WINE OBJECT
        my_wine = Wine.new(name: bottle_name, millesime: millesime, apogee_start: apogee_start, apogee_end: apogee_end, color: color, degree: degre)
        my_wine.castle = my_castle
        my_wine.appelation = my_appelation
        my_wine.save
        #CREATE THE WINE OBJECT

        # Meal associations
        html_doc.search('.ns-AgreementList-description').each do |meal|
          p meal_name = meal.text
          if Meal.where(name: meal_name).empty?
            my_meal = Meal.new(name: meal_name)
            my_meal.save
          else
            my_meal = Meal.where(name: meal_name)[0]
          end
          my_pairing = Pairing.new()
          my_pairing.wine = my_wine
          my_pairing.meal = my_meal
          my_pairing.save
        end


        # noms et pourcentage des cepages
        i = 1
        cepages = html_doc.search('.ns-Chart-legend li span')
        cepages.each do |cepage|
          if i%2 == 0
            if cepage.text.split(':')[1].nil?
              p cepage_percentage = (100 / cepages.length)
              my_assemblage = Assemblage.new(percentage: cepage_percentage)
              my_assemblage.cepage = my_cepage
              my_assemblage.wine = my_wine
              my_assemblage.save

              p cepage_name = cepage.text
              if Cepage.where(name: cepage_name).empty?
                my_cepage = Cepage.new(name: cepage_name)
                my_cepage.save
              else
                my_cepage = Cepage.where(name: cepage_name)[0]
              end

              p cepage_percentage = (100 / cepages.length)
              my_assemblage = Assemblage.new(percentage: cepage_percentage)
              my_assemblage.cepage = my_cepage
              my_assemblage.wine = my_wine
              my_assemblage.save
            else
              p cepage_percentage = cepage.text.split(':')[1].split('%')[0].strip.to_i
              my_assemblage = Assemblage.new(percentage: cepage_percentage)
              my_assemblage.cepage = my_cepage
              my_assemblage.wine = my_wine
              my_assemblage.save
            end
          else
            p cepage_name = cepage.text
            if Cepage.where(name: cepage_name).empty?
              my_cepage = Cepage.new(name: cepage_name)
              my_cepage.save
            else
              my_cepage = Cepage.where(name: cepage_name)[0]
            end
          end
          i += 1
        end

      end
      p "---------------------------"
    end
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
