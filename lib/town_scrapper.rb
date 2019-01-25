require 'nokogiri'
require 'open-uri'
require 'rubygems'


#METHODE PERMETTANT DE RECUPERER LE MAIL DE LA MAIRIE A PARTIR DE L'URL DE LA MAIRIE
def get_townhall_email(townhall_url) 

doc = Nokogiri::HTML(open(townhall_url))

    # J'utilise le xpath (position absolue du mail dans le tableau, 4eme ligne, 2ème colonne)en espérant qu'il soit le même sur chaque page de mairie
    # Une méthode plus sur consisterait à récupérer le mail en regex dans le tableau
    mail = doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text

return mail
end

#METHODE PERMETTANT DE RECUPERER UN TABLEAU AVEC DES COUPLES DE HASH NOM > MAIRIE => LIEN PAGE MAIRIE

def get_townhall_urls

    my_array=[]
  
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    
    #Je me place sur le a.lientxt
      a = doc.css('tr//a.lientxt')
    
    #Je prends pour chaque colonne a, les href
        a.length.times do |i|
          url_suffix = a[i]['href'].delete_prefix(".")
          url_town = "http://annuaire-des-mairies.com#{url_suffix}"


    #Je lance la méthode pour récupérer les mails 
          mail_town = get_townhall_email(url_town)
          puts mail_town
    

    #Je récupère les noms des mairies
          name_town = a[i].text 
          puts name_town

    #Je mets tout ça dans un hash = { "ville_1" => "email_1" }
          my_hash = {name_town => mail_town}
          puts my_hash

    #Je mets tout mes hash dans un array
          my_array << my_hash

        end

        #Je renvoie mon tableau
return my_array

end


#J'apelle ma méthode avec un perform

def perform
    get_townhall_urls
end 

perform