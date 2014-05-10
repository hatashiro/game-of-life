do ->
  getNeighbors = (point) ->
    x = point[0]
    y = point[1]
    [
      [x-1, y-1], [x, y-1], [x+1, y-1],
      [x-1, y], [x+1, y]
      [x-1, y+1], [x, y+1], [x+1, y+1]
    ]

  arrayEqual = (a, b) ->
    a.length is b.length and a.every (elem, i) -> elem is b[i]

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
      if arrayEqual(resultObj[point], [1, 2]) or arrayEqual(resultObj[point], [1, 3]) or arrayEqual(resultObj[point], [0, 3])
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
