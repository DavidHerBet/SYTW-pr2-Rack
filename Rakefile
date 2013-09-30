task :default => :ntweets

desc 'Ejecuta el servidor con las opciones por defecto'
task :ntweets do
  sh "ruby muestra_tweets.rb"
end

desc 'Ejecuta el servidor thin con la aplicación de mostrar tweets en el puerto 9292'
task :thin do
  sh "ruby muestra_tweets.rb thin 9292"
end

desc 'Ejecuta el servidor WEBrick con la aplicación de mostrar tweets en el puerto 8080'
task :webrick do
  sh "ruby muestra_tweets.rb WEBrick 8080"
end
