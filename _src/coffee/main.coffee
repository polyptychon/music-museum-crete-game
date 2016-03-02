global.$ = global.jQuery = $ = require "jquery"

require "bootstrap/assets/javascripts/bootstrap/transition"
require "bootstrap/assets/javascripts/bootstrap/tooltip"
require "bootstrap/assets/javascripts/bootstrap/popover"
#require "bootstrap/assets/javascripts/bootstrap/affix"
#require "bootstrap/assets/javascripts/bootstrap/tab"
#require "bootstrap/assets/javascripts/bootstrap/dropdown"
#require "bootstrap/assets/javascripts/bootstrap/collapse"
#require "bootstrap/assets/javascripts/bootstrap/carousel"
#require "bootstrap/assets/javascripts/bootstrap/tooltip"

preload = (images) ->
  i=0
  for img in images
    images[i] = new Image()
    images[i].src = img
    i++


answers = [
  {name: "Α. Νικόλαος Χάρχαλης", img:"xarxalis-nikolaos.jpg"}
  {name: "Β. Κωνσταντίνος Παπαδάκης ή Ναύτης", img:"papadakis-kostas.jpg"}
  {name: "Γ. Νικόλαος Τσέγκας", img:"tsagas-nikolaos.jpg"}
  {name: "Δ. Μιχάλης Κουνέλης", img:"kounelis-mixalis.jpg"}
  {name: "Ε. Γιώργος Κουτσουρέλης", img:"koytsourelis-giorgos.jpg"}
]

preload answers.map((item)->
  return "assets/images/"+item.img
)

$('.answers a').popover({
  delay: { "show": 500, "hide": 100 }
  animation: true
  html: true
  trigger: "hover"
  container:"body"
  placement:"right"
})
