require 'sinatra/activerecord/rake'
require './app'

task :fun do
  tamagotchis = Tamagotchi.all
  tamagotchis.each do |tamagotchi|
    tamagotchi.update(fun: tamagotchi.fun - 10)
  end
end

task :create_an_new_tamagotchi do  
  Tamagotchi.create(name: 'tamagotchi', health: 100, fun: 100)
end

task :health do
	  tamagotchis = Tamagotchi.all
	  tamagotchis.each do |tamagotchi|
    tamagotchi.update(health: tamagotchi.health - 30)
	  end
end
