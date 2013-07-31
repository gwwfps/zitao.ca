module.exports = (grunt) ->
  grunt.initConfig
    clean: ['main']
    wisp:
      main:
        files: [
          expand: true,
          cwd: 'wisp/',
          src: ['**/*.wisp'],
          dest: 'main/',
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

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-wisp-compile'

  grunt.registerTask 'default', ['clean', 'wisp', 'stylus', 'run']

  grunt.registerTask 'run', () ->
    require('./main/main.js')
    this.async()
