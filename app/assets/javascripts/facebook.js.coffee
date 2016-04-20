jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init(appId: 1102951866431287, cookie: true, version: 'v2.6', xfbml: true)

  $('#sign_in').click (e) ->
    e.preventDefault()
    FB.login (response) ->
      if response.status is "unknown"
        window.location = "/auth/facebook"
      else
        window.location = "/auth/facebook/callback" + $.param signed_request: response.authResponse.signedRequest
  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true

  