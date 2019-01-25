# Initialisation de l'API
service = Google::Apis::GmailV1::GmailService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

# Création du contenu du message
msg = Mail.new #msg est une instance de la classe « Mail ». On va définir ses variables d’instance
msg.date = Time.now
msg.subject = 'ceci est un test'
msg.body = Text.new('coucou!', 'plain', 'charset' => 'us-ascii')
msg.from = {'majorsdepromo.thp@gmail.com' => 'Coucou Man'}
msg.to   = {
    'maxime.speroni@gmail.com' => nil,
}

# Création de la requête, insertion du contenu dans la propriété `raw`
#(https://developers.google.com/gmail/api/v1/reference/users/messages/send)
message = Google::Apis::GmailV1::Message.new(raw: msg.to_s)

service.send_user_message('me', message)