
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
  
  if "polygon" in input.tags {
    return input + (:
      content: polygon(
        ..input.positions.pos().map(pos=>pos.position),
        fill: input.at("fill", default: none), 
        stroke: input.at("stroke", default: auto)
      )
    )
  }
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