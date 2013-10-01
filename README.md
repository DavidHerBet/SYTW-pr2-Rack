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

2. Se puede ejecutar el programa de forma manual (se le puede indicar servidor y puerto) o mediante Rake:

        $ ruby muestra_tweets.rb thin 6060


        $ rake thin


        $ rake webrick

3. Tras ejecutar el servidor habrá que ir a localhost en el puerto asignado para la aplicación (los servidores disponibles son thin y WEBrick). Ejemplo:

        http://localhost:8080

4. Una vez allí introducimos uno o varios usuarios de Twitter y el número de tweets (hasta un máximo de 3) para ver sus últimos tweets.

**Notas:**
- Si introduces más de 7 usuarios en la lista, con el máximo de tweets permitido, es posible que el tiempo de procesamiento de la petición exceda el límite que tenga establecido Twitter y la apliación falle, respondiendo que "Alguno de los usuarios introducidos no está registrado en Twitter o no tiene ningún tweet".   
`Recomendación`: Introducir menos de 7 usuarios o disminuir el número de tweets.

---

Universidad de La Laguna  
Escuela Técnica Superior de Ingeniería Informática
