define [], ->
  ask: (what, body, cb) ->
    console.log 'this is go to server ', body
    fetch "./#{what}",
            method: 'POST'
            body: body
      .then (res) -> res.json()
      .then (res) ->
        console.log res
        if cb
          cb res
