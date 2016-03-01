global.$ = global.jQuery = $ = require "jquery"

requestAnimFrame = require "animationframe"
queue = require "./preload-assets.coffee"
require "./player-timer.coffee"
require "./modernizr-custom"
require "./SoundWrapper"

pointerEvents = require "./pointer_events_polyfill"
archive = require "./archive.coffee"
chapterManager = require "./Chapters.coffee"
displayPage = require "./displayPage.coffee"
browser = require "detect-browser"
player = require "./play.coffee"
ls = require 'local-storage'
play = require "play-audio"

init = ()->
  pointerEvents()
  chapterContainers = $('.chapters-container ul, .player-footer-container .chapters ul')
  chapterList = ""
  chapterManager.getChapters().forEach((item, index)->
    chapterList += "<li><a href=\"javascript:\">#{index+1} - #{item.title}</a></li>"
  )
  chapterContainers.html(chapterList)
  $('body').addClass('show-subtitles') if ls.get(chapterManager.LOCAL_STORAGE_SHOW_SUBTITLES)
  chapterContainers.find('a')
    .bind('click', ()->
      $('body').removeClass('show-chapters')
      createjs.Sound.play("click")
      player.stop()
      chapterManager.setCurrentChapterPlaying($(this).parent().index())
      player.play(chapterManager.getCurrentChapterSource())
    )
    .bind('mouseover', ()->
      createjs.Sound.play("over")
    )
  queue = queue(handleLoadComplete)

startVideoLoad = ()->
  src = chapterManager.getCurrentChapterSourceByIndex(ls.get(chapterManager.LOCAL_STORAGE_CHAPTER))
  player.setVideoSource(src,$('.page.video-player .video'), true)
  if browser.name != "ie"  && ls.get(chapterManager.LOCAL_STORAGE_TIME) && $('.video-player .video video').length>0
    try
      $('.video-player .video video')[0].currentTime = ls.get(chapterManager.LOCAL_STORAGE_TIME)
    catch e

handleLoadComplete = ()->
  $('.landing').find('.bg').css('background-image', "url(#{queue.getItem("landing-bg").src})")
  $('.archive').find('.bg').css('background-image', "url(#{queue.getItem("stoneDark").src})")
  $('.chapter').find('.bg').css('background-image', "url(#{queue.getItem("chapter-1-bg").src})")
  $('.video-player').find('.bg').css('background-image', "url(#{queue.getItem("chapter-1-bg").src})")
  $('.video-player-compact').find('.bg').css('background-image', "url(#{queue.getItem("chapter-1-bg").src})")
  $('html').removeClass('loading')
  displayPage('.landing', '')
  startVideoLoad()
  SM.playMusic('music', -1, 1000)

resetPageAnimation = (callback)->
  $('.page').css('transitionDuration', '0ms');
  $('.page').removeClass('slide-up').removeClass('slide-down')
  requestAnimFrame(()->
    requestAnimFrame(()->
      $('.page').css('transitionDuration', '500ms');
      callback()
    )
  )

$('.play-documentary-btn').bind('click', ()->
  player.stop()
  chapterManager.setCurrentChapterPlaying(0)
  player.play(chapterManager.getCurrentChapterSource())
)
$('.resume-documentary-btn').bind('click', ()->
  player.stop()
  chapterManager.setCurrentChapterPlaying(ls.get(chapterManager.LOCAL_STORAGE_CHAPTER))
  player.play(chapterManager.getCurrentChapterSource(),ls.get(chapterManager.LOCAL_STORAGE_TIME))
)
$('.btn-footer.btn-home').bind('click', ()->
  $('body').removeClass('show-chapters')
  resetPageAnimation(()->
    player.stop()
    if ($('.page.visible').hasClass('archive'))
      $('.archive .back').trigger('click')
    else
      displayPage('.landing', '')
  )
)
$('.chapters .back').bind('click', ()->
  $('body').toggleClass('show-chapters')
)
$('.archive-btn').bind('click', ()->
  displayPage('.archive')
  archive.init()
  createjs.Sound.play("page-slide-up")
)
$('.chapters li a, .intro-buttons a, .related-videos a').bind('mouseover', ()->
  createjs.Sound.play("over")
)
$('.chapters li a, .intro-buttons a, .related-videos a').bind('click', ()->
  createjs.Sound.play("click")
)
$('.video-player-compact-documentary .back').bind('click', ()->
  player.stop()
  displayPage('.video-player', '')
  createjs.Sound.play("page-slide-back")
  player.resumeVideo()
)
$('.landing .chapters-btn').bind('click', ()->
  $('body').toggleClass('show-chapters')
)

init()
