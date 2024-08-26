#import "/tests/preamble.typ": pixel

#let plotter = pixel.pipeline.factory(
  layers: (
    pixel.layer.debug(),
    pixel.layer.drawing.layer(validation: true),
  ),
)


#import pixel.layer: drawing

#let my-polygon(pos, ..args) = drawing.shapes.polygon(
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

Hello
#plotter({
  my-polygon((0,0))
  my-polygon((1,1), stroke: red)
})
World