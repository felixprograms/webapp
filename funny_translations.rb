require 'faraday'

result = Faraday.post('https://api.funtranslations.com/translate/asian-accent.json?text=how%20is%20the%20weather%20today')

p result
