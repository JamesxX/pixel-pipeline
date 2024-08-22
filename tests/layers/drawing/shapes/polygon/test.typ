#import "/tests/preamble.typ": *
#import dynamic-canvas: *

#let plotter = pipeline.factory(
  layers: (
    layer.debug(),
    layer.drawing.layer(validation: true),
  ),
)


#import layer: drawing

#plotter({
  drawing.shapes.polygon(
    fill: blue.lighten(80%),
    stroke: blue,
    ((2,0), (2,1), (3,1),)
  )
})