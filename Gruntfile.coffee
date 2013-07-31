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

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-wisp-compile'

  grunt.registerTask 'default', ['clean', 'wisp', 'run']

  grunt.registerTask 'run', () ->
    require('./main/main.js')
    this.async()
