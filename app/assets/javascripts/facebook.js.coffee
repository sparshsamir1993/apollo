jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init(appId: '219957525047247', cookie: true)

  $('#sign_in').click (e) ->
    e.preventDefault()
    FB.getLoginStatus (response) ->
        window.location = '/auth/facebook/callback' 

  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true