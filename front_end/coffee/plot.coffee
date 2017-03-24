# TODO:
# 1. make history of user inputs
# 2. plot error(vertical line as in course_work1) #done
# 3. problem with digits after point (solve it) #done
# 4. upload to heroku (try to give it reasonable name) #done

define [], ->
  plot: () ->
    x = [-1000..1000].map (x) -> x / 200
    y = x.map (x) -> Math.sin x

    trace1 =
      x: x
      y: y

    trace2 =
      x: x
      y: x.map (x) -> Math.cos x

    # Plotly.newPlot 'plot', [trace1, trace2]

  fromArrs: (x, y, x_approx, y_approx, approx, max_err_line) ->
    Plotly.newPlot 'plot', [{
      x: x, y: y, mode: 'markers', name: 'Точки (викор. в МНК)'
    }, {
      x: x_approx, y: y_approx, mode: 'line', name: 'Функція'
    }, {
      x: x_approx, y: approx, mode: 'line', name: 'Апроксимація'
    }, {
      x: max_err_line.x, y: max_err_line.y, mode: 'line', name: 'Макс. похибка'
    }]
    # plot also max_error
