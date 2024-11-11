export function debounce(callback, delay) {
  let timeout

  return (...args) => {
    clearTimeout(timeout)

    // @ts-expect-error
    timeout = setTimeout(() => {
      callback.apply(this, args)
    }, delay)
  }
}