r = require 'rethinkdb'
fs = require 'fs'
_ = require 'underscore'

r.connect({},
  (conn)->
    console.log  'Connected to database.'
    r.dbCreate('zitaoca').run()
    conn.use 'zitaoca'
    r.db('zitaoca').tableCreate('blog').run()
    posts = _.flatten(JSON.parse(fs.readFileSync fileName, 'utf-8') for fileName in process.argv.slice(2), true)
    for post in posts
      result = r.table('blog').insert(post).run() 
      if result.errors
        console.log 'Failed to insert ' + result.errors + ' post(s).'
      else
        console.log 'Successfully updated post: ' + post.id
    conn.close()
  , () ->
    throw 'Cannot connect to database.'
  )
