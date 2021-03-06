# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid
class SendEmail
	def self.send(to_email, subject, content_value)
		from = Email.new(email: ENV['EMAIL_ADDRESS'])
		to = Email.new(email: to_email)
		content = Content.new(type: 'text/plain', value: content_value)
		mail = Mail.new(from, subject, to, content)

		sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
		response = sg.client.mail._('send').post(request_body: mail.to_json)
		puts response.status_code
		puts response.body
		puts response.headers
	end
end
