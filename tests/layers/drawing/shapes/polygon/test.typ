#import "/tests/preamble.typ": *
#import dynamic-canvas: *

#let plotter = pipeline.factory(
  layers: (
    layer.debug(),
    layer.drawing.layer(validation: true),
  ),
)


#import layer: drawing

#let my-polygon(pos, ..args) = drawing.shapes.polygon(
  position: primitives.position(pos),
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

Hello
#plotter({
  my-polygon((0,0))
  my-polygon((1,1), stroke: red)
})
World