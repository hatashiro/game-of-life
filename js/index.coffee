do (iter=iter) ->
  clear = (ctx, width, height) ->
    ctx.clearRect 0, 0, width, height

  mark = (pixelData, x, y, width) ->
    index = (x + y * width) * 4

    pixelData.data[index] = 255
    pixelData.data[index + 1] = 255
    pixelData.data[index + 2] = 255
    pixelData.data[index + 3] = 255

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
    ctx = grid.getContext('2d')

    width = window.innerWidth
    height = window.innerHeight
    grid.width = width
    grid.height = height

    g0 = getRandomGrid width, height
    iterLoop = iter g0, (g) ->
      clear ctx, width, height

      pixelData = ctx.getImageData 0, 0, width, height
      g.forEach (point) ->
        mark pixelData, point[0], point[1], width
      ctx.putImageData pixelData, 0, 0

  window.onresize = init
  init()
