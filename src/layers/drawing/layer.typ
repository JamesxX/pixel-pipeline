
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
  return input + (:
    content: box([He], stroke: 1pt)
  )
}

#let _layout(input, output, next) = {
  if "draw" not in input.tags {return next(input, output)}
  return input
}

#let layer(
  validation: false
) = (:
  validation: _validate.with(enabled: validation),
  // input-assembler: input-assembler,
  // compute: compute,
  vertex: _vertex,
  render: _render,
  layout: _layout,
)