class Animated
    constructor: (@holder) ->
        @chars = 'ABCDEFGHIJKLMNOPRSTUWQXYZ1234567890`~,. :;()[]{}-_+=\\/|\'\"'
        @chars_cache = {}
        @cl = @chars.length
        @target = $(@holder).html()
        @current = new Array(@target.length)
        @dists = new Array(@target.length)
        @fps = 7

        for i in [0...@chars.length]
            @chars_cache[@chars[i]] = i

        for i in [0...@dists.length]
            @dists[i] = @cl

        for i in [0...@current.length]
            @current[i] = @get_char(i)
        @run_iteration()

    run_iteration: ->
        for i in [0...@current.length]
            if @current[i] == @target[i]
                continue
            @current[i] = @get_char(i)

        $(@holder).html @current.join('')

        for i in [0...@current.length]
            if @current[i] != @target[i]
                setTimeout(((that) -> () -> that.run_iteration())(@), 
                    1000/@fps)
                break


    get_char: (i) ->
        if @target[i] == '\n'
            @dists[i] = '\n'
            return '\n'

        num = Math.floor(Math.random()*@dists[i]*2)
        num -= @dists[i]
        index = (@chars_cache[@target[i]]+num)%@cl
        @dists[i] = Math.floor(abs(index-@chars_cache[@target[i]])*2)
        return @chars[index]

class Body
    constructor: (@holder) ->
        @set_locale()
        @bind_buttons()

        @get_details()

    bind_buttons: ->
        for button in $('#flags')[0].children
            $(button).on 'click', {that: @}, (e) ->
                e.data.that.set_locale $(@).attr 'data-locale'
                e.data.that.get_details()

    get_details: ->
        $.get(@locale+'.html', (data) => @holder.html(data))

    set_locale:(locale=null) ->
        if locale != null
            @locale = locale
            $.cookie('rhok.lang', @locale)
            return

        if $.cookie('rhok.lang')?
            @locale = $.cookie('rhok.lang')
            return

        if navigator?.language?
            if navigator.language.slice(0, 2) == 'pl'
                @locale = 'pl'
                return

        @locale = 'en'


abs = (num) ->
    if num < 0
        return -num
    return num

header = new Animated $('#header')
pozn = new Animated $('#pozn')
body = new Body $('#body')
