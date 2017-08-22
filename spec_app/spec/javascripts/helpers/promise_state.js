function promiseState(promise, callback) {
  var uniqueValue = window['Symbol'] ? Symbol('unique') : Math.random().toString(36)

  function notifyPendingOrResolved(value) {
    if (value === uniqueValue) {
      return callback('pending')
    } else {
      return callback('fulfilled', value)
    }
  }

  function notifyRejected(reason) {
    return callback('rejected', reason)
  }

  var race = [promise, Promise.resolve(uniqueValue)]
  Promise.race(race).then(notifyPendingOrResolved, notifyRejected)
}

function promiseState2(promise) {
  var uniqueValue = window['Symbol'] ? Symbol('unique') : Math.random().toString(36)

  function notifyPendingOrResolved(value) {
    if (value === uniqueValue) {
      return Promise.resolve('pending')
    } else {
      return Promise.resolve('fulfilled', value)
    }
  }

  function notifyRejected(reason) {
    return Promise.resolve('rejected', reason)
  }

  var race = [promise, Promise.resolve(uniqueValue)]
  return Promise.race(race).then(notifyPendingOrResolved, notifyRejected)
}
