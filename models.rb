class User < ActiveRecord::Base
end
class Zombie < ActiveRecord::Base
end
class Tamagotchi < ActiveRecord::Base
end
class Exchange < ActiveRecord::Base
    has_one :stock
end
class Stock < ActiveRecord::Base
    belongs_to :exchange
end
