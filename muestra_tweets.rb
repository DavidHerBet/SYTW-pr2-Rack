require 'rack'
require 'twitter'
require './configure'

class MuestraTweets

  ORDEN = %w(Último Penúltimo Antepenúltimo)

  def call env
    req = Rack::Request.new(env)
    res = Rack::Response.new 
    res['Content-Type'] = 'text/html'
    
    # Recoge el nombre del usuario
    users = (req["users"] && req["users"] != '') ? req["users"] : ''

    # Recoge el número introducido de tweets y si el rango es válido
    tweets_number = (req["ntweets"] && (1..3) === req["ntweets"].to_i) ? req["ntweets"].to_i : 0

    # Extrae los tweets del usuario o usuarios introducido
    user_tweets = (!users.empty? && !tweets_number.zero?) ? extraer_tweets(users, tweets_number) : "No se ha introducido ningún usuario o no se ha introducido ningún número de tweets"

    res.write <<-"EOS"
      <!DOCTYPE HTML>
      <html>
        <head>
          <meta charset="UTF-8">
          <title>App MuestraTweets</title>
        </head>
        <body>
          <section>
            <h1>Bienvenidos a la aplicación MuestraTweet</h1>
            <p>Introduciendo uno o varios usuarios podremos ver sus últimos tweets. Para ello, siga estos pasos:</p>

            <form action="/" method="post">
              1. Introduzca uno o varios usuarios de Twitter (si introduce varios, sepárelos por coma) <input type="text" name="users" autofocus><br>
              2. Introduzca el número de tweets (entre 1 y 3): <input type="number" name="ntweets" min="1" max="3"><br>
              <input type="submit" value="Mostrar últimos tweets"><br>
            </form>
          </section>
          
          <section>
            <h2>Últimos tweets de:</h2>
            #{user_tweets}<br>
          </section>
        </body>
      </html>
    EOS
    res.finish
  end

  # Comprueba que el usuario esté registrado y, en ese caso, devuelve sus tweets
  def extraer_tweets(users, iter)
    usuarios = users.delete(' ').split(',')
    tweets_usuarios = String.new
    begin
      usuarios.size.times do |u|
        tweets_usuarios << "<br><strong>#{usuarios[u]}</strong><br>"
        iter.times do |n|
          tweets_usuarios << ("- " + ORDEN[n] + " tweet: " +  Twitter.user_timeline(usuarios[u])[n].text + "<br>")
        end
      end
    tweets_usuarios 
    rescue
      "ERROR: Alguno de los usuarios introducido no está registrado en Twitter o no tiene ningún tweet"
    end
  end
end

servidor = ARGV.shift || 'thin'
puerto = ARGV.shift || '9292'

Rack::Server.start(
  :app => MuestraTweets.new,
  :Port => puerto,
  :server => servidor
)
