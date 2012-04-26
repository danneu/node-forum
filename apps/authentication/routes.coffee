
routes = (app) ->

  app.get '/login', (req, res) ->
    res.render "#{__dirname}/views/login", 
      title: 'Login'
      stylesheet: 'login'

  app.post '/sessions', (req, res) ->
    if ('piechef' is req.body.username) and ('secret' is req.body.password)
      req.session.currentUser = req.body.username
      req.flash 'success', "You are logged in as #{req.session.currentUser}"
      res.redirect '/login'
      return # do application doesn't run any other code in this handle
    req.flash 'error', 'Those credentials were incorrect. Try again.'
    res.redirect '/login'
  
  app.del '/sessions', (req, res) ->
    req.session.regenerate (err) ->
      req.flash 'info', 'You have been logged out.'
      res.redirect '/login'

module.exports = routes
