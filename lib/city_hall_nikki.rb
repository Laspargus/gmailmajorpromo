require 'nokogiri'
require 'open-uri'

# methode pour avoir 1 email
def get_townhall_urls
	
	# definir un tableau
	array = []
	
	# definir hashage
	hash_each = {}

	# je cible la page html dont je souhaite tirer les informations
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	
	# la ligne cible dans la page html cible
	content = page.css('tr')
		
		# pour les 123 mairies du departement
		185.times do |i|

		# Nom des villes cible
		towns = content.css('.lientxt')[i].text

		# liens amputes de 'site'
		suffix = content.css('.lientxt')[i]['href'].delete_prefix('.')
		
		# Nom du site
		site = "http://annuaire-des-mairies.com"
		
		# le lien compose du prefixe et du suffixe
		link = site + suffix

		# mairie.quelquechose@wanadoo.fr
		email = get_townhall_email(link).join

		# le hash {"ABLEIGES"=>"mairie.ableiges95@wanadoo.fr"}
		hash_each = {towns => email}
		
		# comme dans l'exo precedent le hash vient dans un tableau
		array << hash_each
	
	end
	
	puts array
	
	return array

end



def get_townhall_email(towhall_url)

	array = []
	
	hash_each = {}

	page = Nokogiri::HTML(open(towhall_url))

	page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |tr|
	
	# tr.text = <td>mairie.ableiges95@wanadoo.fr</td>
	array << tr.text

	end

	return array

end

get_townhall_urls