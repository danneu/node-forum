
/**
 * Module dependencies.
 */

require('coffee-script');
var express = require('express')
  , RedisStore = require('connect-redis')(express);
var app = module.exports = express.createServer();

// DB Connection
require('./db-connect')

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.set('port', 3000);
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser()); // added
  app.use(express.session({
    secret: "jakfakljsflalskfksflsjfklasfklasjfkjaskfwoowowoo",
    store: new RedisStore
  }));
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('test', function(){
  app.set('port', 3001);
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

// Helpers
require('./apps/helpers')(app);

// Routes
require('./apps/authentication/routes')(app) 
require('./apps/forum/routes')(app) 

app.listen(app.settings.port, function(){
  console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
});
