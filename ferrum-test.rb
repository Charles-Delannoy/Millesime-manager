require 'open-uri'
require 'nokogiri'
require 'ferrum'


base_url = "https://www.nicolas.com/fr/"
base_html_doc = Nokogiri::HTML(open(base_url).read)
i = 1
base_html_doc.search('.ns-LayerMenu-link').first(10).each do |url|
  wine_url = "https://www.nicolas.com#{url.attribute('href').value}"
  browser = Ferrum::Browser.new(browser_options: { 'no-sandbox': nil })
  browser.goto wine_url
  i += 1
  p browser.css("a.ns-LoadMore-btn")[0].click
  p wine_url
  # until browser.css("a.ns-LoadMore-btn").empty?
  #   p browser.css("a.ns-LoadMore-btn")
  # end
  page = Nokogiri.parse(browser.body)
  page.search('.ns-Product a.ns-Button').each do |element|
    p bottle_url = "https://www.nicolas.com/#{element.attribute('href').value}"
  end
  browser.screenshot(path: "google#{i}.png")
end
