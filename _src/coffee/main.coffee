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


$('.answers a').popover({
  delay: { "show": 500, "hide": 100 }
  animation: true
  trigger: "hover"
  container:"body"
  placement:"right"
})
