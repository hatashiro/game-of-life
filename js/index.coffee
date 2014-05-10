do (iter=iter) ->
  clear = (grid) ->
    grid.getContext('2d').clearRect 0, 0, grid.width, grid.height

  mark = (ctx, x, y) ->
    grid.getContext('2d').fillStyle = '#FFFFFF'
    grid.getContext('2d').fillRect x, y, 1, 1

  getRandomGrid = (width, height) ->
    result = []
    i = 0
    while i < width
      j = 0
      while j < height
        if Math.random() * 100 < 10
          result.push [i, j]
        j++
      i++
    result

  iterLoop = null
  init = ->
    clearInterval iterLoop if iterLoop
    grid = document.getElementById 'grid'

    width = window.innerWidth
    height = window.innerHeight
    grid.width = width
    grid.height = height

    clear grid, width, height

    g0 = getRandomGrid width, height
    iterLoop = iter g0, (g) ->
      clear grid
      g.forEach (point) ->
        mark grid, point[0], point[1]

  window.onresize = init
  init()
