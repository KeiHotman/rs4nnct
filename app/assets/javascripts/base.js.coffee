# item refine search
$(document).on 'change', '#item_grade_refine', ->
  grade      = $('#item_grade_refine').val()
  department = $('#item_department_refine').val()
  item_refine(grade, department)

$(document).on 'change', '#item_department_refine', ->
  grade      = $('#item_grade_refine').val()
  department = $('#item_department_refine').val()
  item_refine(grade, department)

item_refine = (grade, department)->
  $.ajax
    type: 'GET'
    url: '/items?grade=' + grade + '&department=' + department
    dataType: 'script'
  false

$(document).on 'click', '.rating .value a', ->
  value = parseInt($(this).attr('value'))
  $.ajax
    type: 'POST'
    url: '/items/' + $(this).attr('item_id') + '/rating'
    data:
      value: value
    dataType: 'script'
    success: ->
      if value <= 2
        $('.opinion').show()
  false


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
