#let validation(input, output, next, enabled: false) = {
  output.push("Hello")
  next(input, output)
}