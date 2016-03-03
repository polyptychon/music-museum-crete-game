global.$ = global.jQuery = $ = require "jquery"

requestAnimFrame = require "animationframe"
require "bootstrap/assets/javascripts/bootstrap/transition"
require "bootstrap/assets/javascripts/bootstrap/tooltip"
require "bootstrap/assets/javascripts/bootstrap/popover"
#require "bootstrap/assets/javascripts/bootstrap/affix"
#require "bootstrap/assets/javascripts/bootstrap/tab"
#require "bootstrap/assets/javascripts/bootstrap/dropdown"
#require "bootstrap/assets/javascripts/bootstrap/collapse"
#require "bootstrap/assets/javascripts/bootstrap/carousel"
#require "bootstrap/assets/javascripts/bootstrap/tooltip"

setImagePopovers = ()->
  if $(window).width()>991
    $('.answers a').popover({
      delay: { "show": 500, "hide": 100 }
      animation: true
      html: true
      trigger: "hover"
      container:"body"
      placement:"right"
    })
  else
    $('.answers a').popover('destroy')

setImagePopovers()
$(window).bind('resize', ()->
  setImagePopovers()
)

$('.home .btn').bind('click', ()->
  $('.home.page').removeClass('active')
  $('.home.page').css('top', '-100%')
  $('.quiz.page').addClass('active')
)

$('.question-container').each(()->
  $(this).css('display', 'none') if !$(this).hasClass('active')
)

$('.quiz .answers a').bind('click', ()->
  gotoNextQuestion($(this).closest('.question-container'))
)

gotoNextQuestion = (activeQuestion)->
  return if activeQuestion.next().length==0

  activeQuestion.next().css('display', 'block')
  $('.answers a').popover('hide')
  setTimeout(()->
    activeQuestion.removeClass('active')
    activeQuestion.css('left', '-100%')
    activeQuestion.next().addClass('active')
    setTimeout(()->
      activeQuestion.css('display', 'none')
    , 1000)
  , 50)
