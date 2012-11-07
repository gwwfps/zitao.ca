express = require 'express'
app = express()

app.configure () ->
  app.set 'views', __dirname + '/views'
  app.engine 'jade', require('jade').__express
  app.set 'view engine', 'jade'

app.get '/', (req, res) ->
  res.render 'main.jade'

app.listen 3000
console.log 'Started application'