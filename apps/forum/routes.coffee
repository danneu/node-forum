mongoose = require 'mongoose'
TopicSchema = new mongoose.Schema
  title: 
    type:     String
    default:  ''
    trime:    true
  createdAt: 
    type:     Date 
    default:  Date.now
Topic =  mongoose.model('Topic', TopicSchema)

routes = (app) ->

  app.get '/', (req, res) ->
    topic = new Topic(title: "My First Topic")
    topic.save (err) ->
      if err
        req.flash 'error', 'Topic seed failed'
      else
        Topic
          .find({})
          .desc('createdAt')
          .run (err, topics) ->
            if err
              req.flash 'error', 'Topics not generated'
            else
              req.flash 'success', 'Topics generated'
            res.render "#{__dirname}/views/index", 
              title: 'Topics'
              topics: topics
            return

module.exports = routes
