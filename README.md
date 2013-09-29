Sistemas y Tecnologías Web
==========================
David Hernández Bethencourt

Práctica 2: Accediendo a Twitter y mostrando los últimos twitts en una página
-----------------------------------------------------------------------------
La práctica consiste en convertir el programa de ejemplo usado en la sección "[Ejemplo en Ruby: Accediendo a Twitter](http://nereida.deioc.ull.es/~lpp/perlexamples/node22.html)" en una aplicación Rack que muestre en su página los últimos twitts de una lista de usuarios obtenidos desde un formulario (se puede modificar/diseñar la interfaz como crea conveniente).

Instrucciones
-------------

1. Se debe de crear un archivo "configure.rb" que contenga tus credenciales de Twitter:

        Twitter.configure do |config|
          config.consumer_key       = "YOUR_CONSUMER_KEY"
          config.consumer_secret    = "YOUR_CONSUMER_SECRET"
          config.oauth_token        = "YOUR_ACCESS_TOKEN"
          config.oauth_token_secret = "YOUR_ACCESS_SECRET"
        end

2. Se puede ejecutar el programa de forma manual para iniciar el servidor o mediante Rake:

        $ ruby muestra_tweets.rb
        $ rake server
        $ rake

3. Tras ejecutar el servidor habrá que ir a localhost:9292 (puerto asignado para la aplicación).

4. Una vez alli introducimos el usuario de Twitter y vemos su último tweet.
   

**Notas:**

- Si introduces un usuario de Twitter que no exista, se producirá un fallo interno en el servidor y te lo notificará.


---

Universidad de La Laguna  
Escuela Técnica Superior de Ingeniería Informática
