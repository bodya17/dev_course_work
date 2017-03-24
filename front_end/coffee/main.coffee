define ['plot', 'server'], (plot, server) ->
  getParams = ->
    return JSON.parse(localStorage.getItem('params'))

  pushParams = (obj) ->
    localStorage.setItem 'params', JSON.stringify obj

  # addToHistory = () ->
  #   if (localStorage.getItem('history') === null) {
  #     localStorage.setItem('history', JSON.stringify([1,2]))
  #   } else {
  #     historyArr = JSON.parse(localStorage.getItem('history'))
  #     console.log historyArr
  #   }
  populateForm = ->
    params = getParams()
    console.log params
    if params != null
      els.func.value = params.func
      els.deg.value = params.deg
      els.start.value = params.start
      els.end.value = params.end
      els.points_ctn.value = params.points_ctn
      els.after_point.value = params.after_point

  els =
    func: document.getElementById('function')
    deg: document.getElementById('deg')
    start: document.getElementById('start')
    end: document.getElementById('end')
    points_ctn: document.getElementById('points_ctn')
    after_point: document.getElementById('after_point')
    formula: document.getElementById('formula')
    max_error: document.getElementById('max_err')
    x_of_max_error: document.getElementById('x_max_err')
  # console.log getParams()
  window.onload = ->
    console.log 'population'

  console.log 'population'
  populateForm()


  btnFind = document.getElementById 'btn-find'

  btnFind.addEventListener 'click', (e) ->
    pushParams
      func: els.func.value
      deg: els.deg.value
      start: els.start.value
      end: els.end.value
      points_ctn: els.points_ctn.value
      after_point: els.after_point.value

    # addToHistory()
    e.preventDefault()


    if (+els.deg.value > +els.points_ctn.value)
      alert 'Cтепінь більша за кількість точок (буде недобрий результат)'

    server.ask 'least_squares', "#{els.func.value}|#{els.deg.value}|#{els.start.value}|#{els.end.value}|#{els.points_ctn.value}", (res) ->
        # console.log formula

        removeDigits = new RegExp("(\\.\\d{#{els.after_point.value || 3}})\\d*", 'g')
        els.max_error.innerHTML = "Максимальна похибка: #{res.max_error.toFixed(3)}"
        els.x_of_max_error.innerHTML = "x в якому макс. похибка: #{res.x_of_max_error.toFixed(3)}"
        formula.innerHTML = "$$ #{res.formula.replace(removeDigits, '$1')} $$"
        MathJax.Hub.Queue(["Typeset", MathJax.Hub, formula])
        plot.fromArrs(res.x_vals, res.y_vals, res.x_approx ,res.f_x_approx, res.approximation, res.max_error_line)
    # server.ask 'minmax', "#{func}|#{deg}|#{start}|#{end}"
