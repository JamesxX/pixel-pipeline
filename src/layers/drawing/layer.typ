
#let _validate(input, output, next, enabled: false) = {
  next(input, output)
}

#let _vertex(input, output, next) = {
  if "draw" not in input.tags {return next(input, output)}

  // Polygon
  if "polygon" in input.tags {
    return next(input, output)
  }
}

#let _render(input, output, next) = {
  if "draw" not in input.tags {return next(input, output)}
  next(input, input + (:
    content: [Hello]
  ))
}

#let layer(
  validation: false
) = (:
  validation: _validate.with(enabled: validation),
  // input-assembler: input-assembler,
  // compute: compute,
  vertex: _vertex,
  render: _render,
)