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
