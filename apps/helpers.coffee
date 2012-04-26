
helpers = (app) ->

  app.dynamicHelpers
    flash: (req, res) -> req.flash()
    user: (req, res) -> req.session.currentUser
      
  app.helpers
    timeago: require 'timeago'
  

module.exports = helpers
