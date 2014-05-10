do ->
  getNeighbors = (point) ->
    x = point[0]
    y = point[1]
    [
      [x-1, y-1], [x, y-1], [x+1, y-1],
      [x-1, y], [x+1, y]
      [x-1, y+1], [x, y+1], [x+1, y+1]
    ]

  willAlive = (point) ->
    point[1] is 3 or point[0] and point[1] is 2

  step = (currentGeneration) ->
    resultObj = {}
    currentGeneration.forEach (point) ->
      if resultObj[point]?
        resultObj[point][0] = 1
      else
        resultObj[point] = [1, 0]

      getNeighbors(point).forEach (neighborPoint) ->
        if resultObj[neighborPoint]?
          resultObj[neighborPoint][1]++
        else
          resultObj[neighborPoint] = [0, 1]

    nextGeneration = []
    for point of resultObj
      if willAlive resultObj[point]
        nextGeneration.push point.split(',').map(Number)
    nextGeneration

  iter = (g0, forEachStep) ->
    g = g0
    forEachStep g
    setInterval (() ->
      g = step g
      forEachStep g
    ), 100

  window.iter = iter
