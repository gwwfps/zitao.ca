// Generated by CoffeeScript 1.4.0
var fileName, fs, post, posts, r, _i, _j, _len, _len1, _ref;

r = require('rethinkdb');

fs = require('fs');

_ref = process.argv.slice(2);
for (_i = 0, _len = _ref.length; _i < _len; _i++) {
  fileName = _ref[_i];
  posts = fs.readFileSync(fileName, 'utf-8');
}

for (_j = 0, _len1 = posts.length; _j < _len1; _j++) {
  post = posts[_j];
  r.db('zitaoca').table('blog').insert(JSON.parse(post)).run();
}
