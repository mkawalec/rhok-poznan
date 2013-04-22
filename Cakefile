fs = require 'fs'

{print} = require 'sys'
{spawn} = require 'child_process'

build = (callback) ->
    coffee = spawn 'coffee', ['-c', '-l', '-b', '-o', 'static/js', 'coffee']
    coffee.stderr.on 'data', (data) ->
        process.stderr.write data.toString()
    coffee.stdout.on 'data', (data) ->
        print data.toString()
    coffee.on 'exit', (code) ->
        callback?() if code is 0

task 'watch', 'Watch source for changes', ->
    coffee = spawn 'coffee', ['-w', '-c', '-l', '-b', '-o', 'static/js', 'coffee']
    coffee.stderr.on 'data', (data) ->
        process.stderr.write data.toString()
    coffee.stdout.on 'data', (data) ->
        print data.toString()

task 'build', 'Build from src', ->
    build()
