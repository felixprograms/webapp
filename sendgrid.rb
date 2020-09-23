# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

from = Email.new(email: ENV['EMAIL_ADDRESS'])
to = Email.new(email: ENV['EMAIL_ADDRESS'])
subject = 'You created an account'
content = Content.new(type: 'text/plain', value: 'Just to inform you that you created an account successfully.')
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers
