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
    username = (req["user"] && req["user"] != '') ? req["user"] : ''

    # Recoge el número introducido de tweets y si el rango es válido
    tweets_number = (req["ntweets"] && (1..3) === req["ntweets"].to_i) ? req["ntweets"].to_i : 0

    # Recoge los tweets del usuario introducido
    user_tweets = (!username.empty? && !tweets_number.zero?) ? usuario_registrado?(username, tweets_number) : "No se ha introducido ningún usuario o no se ha introducido ningún número de tweets"

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
            <p>Introduciendo un usuario podremos ver sus últimos tweets. Para ello, siga estos pasos:</p>

            <form action="/" method="post">
              1. Introduzca un usuario de Twitter <input type="text" name="user" autofocus><br>
              2. Introduzca el número de tweets (entre 1 y 3): <input type="number" name="ntweets" min="1" max="3"><br>
              <input type="submit" value="Mostrar últimos tweets"><br>
            </form>
          </section>
          
          <section>
            <h2>Últimos tweets de #{username}</h2>
            #{user_tweets}
          </section>
        </body>
      </html>
    EOS
    res.finish
  end

  # Comprueba que el usuario esté registrado y, en ese caso, devuelve sus tweets
  def usuario_registrado?(user, iter)
  salida = String.new
    begin
      iter.times do |n|
        salida << ("- " + ORDEN[n] + " tweet: " +  Twitter.user_timeline(user)[n].text + "<br>")
      end
    salida 
    rescue
      "ERROR: El usuario introducido no está registrado en Twitter o no tiene ningún tweet"
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
