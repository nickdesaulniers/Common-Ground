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
  null

$(document).ready ->
  $('#browser_id_sign_in').click () ->
    navigator.id.get gotAssertion
    false
  null