gotAssertion = (assertion) ->
  if assertion
    $.ajax {
      type: 'POST',
      url: '/users',
      data: {
        assertion: assertion
      },
      success: (response, status, xhr) ->
        if response
          console.log 'Logged In.'
        else
          console.log 'Logged Out.'
      error: (response, status, xhr) ->
        console.log 'Login Failure ' + response
    }
  else
    console.log 'Logged Out'

# TODO EMAIL VALIDATOR

sendInvite = (button) ->
  emailEle = $ '#user_address'
  emailAddress = emailEle.val()
  submitButton = $(button)
  console.log 'I should email ' + emailAddress
  emailEle.prop 'disabled', true
  submitButton.prop 'disabled', true
  $.post '/users/invite', {'email': emailAddress, 'room': $('#room_id').val()},
    (data) ->
      emailEle.removeAttr('id')
      emailEle.css 'color', 'green'
      input = document.createElement 'input'
      input.setAttribute 'type', 'email'
      input.setAttribute 'size', '30'
      input.setAttribute 'id', 'user_address'
      emailEle.after input
      submitButton.removeProp 'disabled'

doneInviting = () ->
  room_number = $('#room_id').val()
  window.location.pathname = '/rooms/' + room_number

find = () ->
  $.ajax {
    type: 'POST',
    url: '',
    data: # get lat and long from dom
    success: (response, status, xhr) ->
      console.log 'yo'
  }

$(document).ready ->
  $('#browser_id_sign_in').click () ->
    navigator.id.get gotAssertion
    false
  $('#send_invite').click (event) ->
    event.preventDefault()
    sendInvite this
  $('#done_inviting').click (event) ->
    event.preventDefault()
    doneInviting()
  $('#find').click (event) ->
    event.prventDefault()
    find()