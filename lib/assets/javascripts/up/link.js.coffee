up.link = (->
  
  visit = (url, options) ->
    console.log("up.visit", url)
    # options = up.util.options(options, )
    up.replace('body', url, options)

  follow = (link, options) ->
    $link = $(link)
    options = up.util.options(options)
    url = up.util.presentAttr($link, 'href', 'up-follow')
    selector = options.target || $link.attr("up-target") || 'body'
    options.transition ||= $link.attr('up-transition')
    up.replace(selector, url, options)

  resolve = (element) ->
    $element = $(element)
    if $element.is('a') || up.util.presentAttr($element, 'up-follow')
      $element
    else
      $element.find('a:first')

  resolveUrl = (element) ->
    if link = resolve(element)
      up.util.presentAttr(link, 'href', 'up-follow')
      
  markActive = (element) ->
    markUnactive()
    $element = $(element)
    $clickArea = $element.ancestors('up-follow')
    $clickArea = $element unless $clickArea.length
    $clickArea.addClass('up-active')
    
  markUnactive = ->
    $('[up-active]').removeClass('up-active')

  up.on 'click', 'a[up-target]', (event, $link) ->
    event.preventDefault()
    follow($link)

  up.on 'click', '[up-follow]', (event, $element) ->

    childLinkClicked = ->
      $target = $(event.target)
      $target.closest('a').length > 0 && $element.has($target).length > 0

    unless childLinkClicked()
      event.preventDefault()
      follow(resolve($element))

  visit: visit
  follow: follow
  resolve: resolve
  resolveUrl: resolveUrl

)()

up.visit = up.link.visit
up.follow = up.link.follow