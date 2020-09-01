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
