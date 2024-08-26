#import "preamble.typ": *

#let _validate(input, output, next) = {
  next(input, output)
}

#let _compute(input, output, next) = {
  next(input, output)
}

#let _vertex(input, output, next) = {
  next(input, output)
}

#let _render(input, output, next) = {
  next(input, output)
}

#let _layout(input, output, next) = {
  next(input, output)
}

#let test-pipeline = pixel.pipeline.factory(
  layers: (
    pixel.layer.debug(),
    // pixel.layer.drawing.layer(validation: true),
    (:
      validation: _validate,
      vertex: _vertex,
      render: _render,
      layout: _layout,
    )
  ),
)

#let my-polygon(pos, ..args) = pixel.layer.drawing.shapes.polygon(
  position: pixel.primitives.position(pos),
  fill: blue.lighten(80%),
  stroke: blue,
  (
    (0,1), 
    (1,1), 
    (1,0),
    (0,0),
  ),
  ..args
)

#test-pipeline({
  my-polygon((0,0), stroke: red)
})