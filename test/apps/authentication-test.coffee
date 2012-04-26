
assert  = require 'assert'
request = require 'request'
app     = require '../../server' # will start web server as soon as it's required

describe "authentication", ->
  describe "GET /login ", ->
    body = null # so tests can access it
    before (done) -> # run one time
      options =
        uri: "http://localhost:#{app.settings.port}/login" # the doc we want to retriece
      request options, (err, res, _body) ->
        body = _body
        done()

    it "has title", ->
      assert.hasTag body, '//head/title', 'Symposium - Login'
    it "has username field", ->
      assert.hasTag body, '//input[@name="username"]', ''
    it "has password field", ->
      assert.hasTag body, '//input[@name="password"]', ''

  describe "POST /sessions", ->
    describe "incorrect credentials", ->
      [body, response] = [null, null]
      before (done) ->
        options = 
          uri: "http://localhost:#{app.settings.port}/sessions"
          form:
            username: 'incorrect username'
            password: 'incorrect password'
          followAllRedirects: true
        request.post options, (err, _response, _body) ->
          [body, response] = [_body, _response]
          done()
      it "shows flash message", ->
        errorText = 'Those credentials were incorrect. Try again.'
        assert.hasTag body, "//p[@class='flash error']", errorText

    describe "correct credentials", ->
      [body, response] = [null, null]
      before (done) ->
        options = 
          uri: "http://localhost:#{app.settings.port}/sessions"
          form:
            username: 'piechef'
            password: 'secret'
          followAllRedirects: true
        request.post options, (err, _response, _body) ->
          [body, response] = [_body, _response]
          done()
      it "shows flash message", ->
        infoText = "You are logged in as piechef"
        assert.hasTag body, "//p[@class='flash info']", infoText

  describe "DELETE /sessions", ->
    [body, response] = [null, null]
    before (done) ->
      options =
        uri: "http://localhost:#{app.settings.port}/sessions"
        followAllRedirects: true
      request.del options, (err, _response, _body) ->
        [body, response] = [_body, _response]
        done()
    it "shows flash message", ->
      flashText = "You have been logged out."
      assert.hasTag body, "//p[@class='flash info']", flashText
