module.exports = (grunt) ->
  config = grunt.file.readJSON 'config.json'

  couchAppJsonPath = 'tmp/app.json'
  couchCompileOptions =
    app:
      files: {}
  couchCompileOptions.app.files[couchAppJsonPath] = 'tmp/couch'
  couchPushOptions =
    localhost:
      files: {}
  couchPushOptions.localhost.files[config['couch-url']] = couchAppJsonPath

  grunt.initConfig
    clean: ['js', 'tmp']
    wisp:
      js:
        files: [
          expand: true,
          cwd: 'wisp/',
          src: ['**/*.wisp'],
          dest: 'js/',
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
    'couch-compile': couchCompileOptions      
    'couch-push': couchPushOptions
      

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
    main = require './js/main.js'
    main.start config
    this.async()
