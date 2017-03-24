gulp = require 'gulp'
jade = require 'gulp-jade'
connect = require 'gulp-connect'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'
# uglify = require 'gulp-uglify'
clean = require 'gulp-clean'
rjs = require 'gulp-requirejs'

# gulp.task 'connect', ->
#   connect.server
#     port: 1337
#     livereload: on
    # root: './dist'

gulp.task 'jade', ->
  gulp.src 'jade/*.jade'
    .pipe jade(pretty: true)
    .pipe gulp.dest '../templates'
    # .pipe do connect.reload

gulp.task 'sass', ->
  gulp.src 'sass/*.sass'
    .pipe do sass
    .pipe gulp.dest '../static/css'
    # .pipe do connect.reload

gulp.task 'build', ['coffee'], ->
  rjs
    baseUrl: 'js'
    name: '../bower_components/almond/almond'
    include: ['main']
    insertRequire: ['main']
    out: 'all.js'
    wrap: on
  # .pipe do uglify
  .pipe gulp.dest '../static/js'
  # .pipe do connect.reload

  gulp.src 'js/', read: no
    .pipe do clean

gulp.task 'coffee', ->
  gulp.src 'coffee/*.coffee'
    .pipe do coffee
    .pipe gulp.dest 'js' # will be deleted

gulp.task 'watch', ->
  gulp.watch 'jade/*.jade', ['jade']
  gulp.watch 'sass/*.sass', ['sass']
  gulp.watch 'coffee/*.coffee', ['build']

gulp.task 'default', ['jade', 'sass', 'build', 'watch']
