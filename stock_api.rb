require 'faraday'
require 'redis'

class StockApi

    def self.get_stock_price(ticker_name)
        redis = Redis.new
				
		if price = redis.get(ticker_name)
			return Float(price)
		else
			response = Faraday.get("https://sandbox.iexapis.com/stable/stock/#{ticker_name}/price?token=Tsk_620fca762f4c427c98eead688e7df20f")
			price = Float(response.body)
			redis.setex(ticker_name, 60, price)
        	return price
		end
    end

end
