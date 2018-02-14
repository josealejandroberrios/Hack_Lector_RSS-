# Lector de Noticias Hack

En la actualidad, existen muchas fuentes de noticias, muchas páginas web donde nos podemos mantener informados de todo lo que acontece en el mundo de la informática y la tecnología en general. Pero... ¿acaso no es tedioso ir y visitar cada uno de estos sitios web? Sí, y es por ello que hace bastante tiempo se creó el RSS. El RSS no es más que un formato para que los sitios web publiquen sus noticias y estas sean leídas de una manera centralizada por RSS Reader, como fue el caso del famoso Google Reader. El detalle con los RSS es que estos son publicados en formato XML, formato actualmente en desuso.

Muchos sitios web han estado publicando sus noticias en formato **JSON** para ser leídas por aplicaciones de terceros. El principal problema radica en que no hay un estándar como lo fue el RSS y todos los sitios publican sus JSON de la forma que más le conviene. Es por ello que el grupo de mentores de Hack les pide que desarrollen un programa en **Ruby** que lea de las siguientes fuentes:
  * Reddit: https://www.reddit.com/.json
  * Mashable: http://mashable.com/stories.json
  * Digg: http://digg.com/api/news/popular.json

Estos 3 sitios publican su data en formato JSON y la finalidad de este proyecto
es procesar y analizar (parsing) la data para que por pantalla se muestren las
noticias de las siguientes formas:
  1. **Mostrar noticias por sitio web:** el usuario podrá elegir cualquiera
  de las tres fuentes.
  2. **Mostrar noticias ordenadas por fecha de publicación:** el usuario podrá 	ver las noticias de todos los websites ordenadas por fecha.

#### De las noticias se requiere:
  1. Título
  2. Autor
  3. Fecha (debe ser el formato: DD/MM/AAAA)
  4. Url de la noticia
  
**Es necesario entonces que usted diseñe y estructure su proyecto basado en Programación Orientada a Objetos (OOP).**