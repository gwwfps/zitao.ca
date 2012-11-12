r = require 'rethinkdb'
fs = require 'fs'

posts = fs.readFileSync(fileName, 'utf-8') for fileName in process.argv.slice(2)
r.db('zitaoca').table('blog').insert(JSON.parse(post)).run() for post in posts
