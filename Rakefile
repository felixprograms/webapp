require 'sinatra/activerecord/rake'
require './app'

task :fun do
  tamagotchis = Tamagotchi.all
  tamagotchis.each do |tamagotchi|
    p tamagotchi.fun	  
    p 'Reducing tamagotchi fun by 10'
    tamagotchi.update(fun: tamagotchi.fun - 10)
    p tamagotchi.fun
  end
end

task :create_an_new_tamagotchi do  
  Tamagotchi.create(name: 'tamagotchi', health:100, fun:100)
end

task :health do
	  tamagotchis = Tamagotchi.all
	  tamagotchis.each do |tamagotchi|
     p tamagotchi.health
     p 'Reducing tamagotchi health by 30'
     tamagotchi.update(health: tamagotchi.health - 30)
	  end
end
