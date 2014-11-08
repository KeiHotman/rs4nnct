# mouseover stars to be rating on courses#show
$(document).on 'mouseenter', '.rating .value', ->
  $(this).find('img').addClass('star')
  $(this).find('img').removeClass('star_empty')

  $(this).prevAll().find('img').addClass('star')
  $(this).prevAll().find('img').removeClass('star_empty')

  $(this).nextAll().find('img').addClass('star_empty')
  $(this).nextAll().find('img').removeClass('star')

$(document).on 'mouseleave', '.rating .value', ->
  $('.rating .value').not('.persisted').find('img').addClass('star_empty')
  $('.rating .value').not('.persisted').find('img').removeClass('star')

  $('.rating .value.persisted').find('img').addClass('star')
  $('.rating .value.persisted').find('img').removeClass('star_empty')
