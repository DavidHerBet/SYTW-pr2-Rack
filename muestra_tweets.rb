require 'rack'
require 'twitter'
require './configure'

class MuestraTweets

  def call env
    req = Rack::Request.new(env)
    res = Rack::Response.new 
    res['Content-Type'] = 'text/html'
    username = (req["user"] && req["user"] != '') ? req["user"] : ''
    user_tweets = (!username.empty?) ? usuario_registrado?(username) : "No se ha introducido ningún usuario"

    res.write <<-"EOS"
      <!DOCTYPE HTML>
      <html>
        <head>
          <meta charset="UTF-8">
          <title>App MuestraTweet</title>
        </head>
        <body>
          <section>
            <h1>Bienvenidos a la aplicación MuestraTweet</h1>
            <p>Introduciendo un usuario podremos ver su último tweet.</p>

            <form action="/" method="post">
              Introduzca un usuario de Twitter <input type="text" name="user" autofocus><br>
              <input type="submit" value="Mostrar último tweet">
            </form>
          </section>
          
          <section>
            <h2>Último tweet</h2>
            #{username}<br>#{user_tweets}
          </section>
        </body>
      </html>
    EOS
    res.finish
  end

  def usuario_registrado?(user)
    begin
      Twitter.user_timeline(user).first.text
    rescue
      "El usuario introducido no está registrado en Twitter"
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
