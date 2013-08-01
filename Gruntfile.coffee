module.exports = (grunt) ->
  grunt.initConfig
    clean: ['main', 'tmp']
    wisp:
      main:
        files: [
          expand: true,
          cwd: 'wisp/',
          src: ['**/*.wisp'],
          dest: 'main/',
          ext: '.js'
        ]
      couch:
        files: [
          expand: true,
          cwd: 'wisp-couch/',
          src: ['**/*.wisp'],
          dest: 'tmp/couch/',
          ext: '.js'
        ]
    stylus:
      css:
        options:
          use: [
            require 'nib'
          ]
        files:
          'css/app.css': 'stylus/app.styl'
    'couch-compile':
      app:
        files:
          'tmp/app.json': 'tmp/couch'
    'couch-push':
      localhost:
        files:
          'http://localhost:5984/zitao-ca': 'tmp/app.json'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-wisp-compile'
  grunt.loadNpmTasks 'grunt-couch'

  grunt.registerTask 'default', ['clean', 'wisp', 'stylus', 'couch-compile', 'couch-id', 'couch-push', 'run']

  grunt.registerTask 'couch-id', () ->
    bulk = grunt.file.readJSON 'tmp/app.json'
    bulk.docs[0]._id = '_design/web'    
    grunt.file.write 'tmp/app.json', JSON.stringify(bulk)

  grunt.registerTask 'run', () ->
    require './main/main.js'
    this.async()
