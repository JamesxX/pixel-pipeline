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
    position: primitives.position((1, 1)),
    fill: blue.lighten(80%),
    stroke: blue,
    (
      (2,0), 
      (2,1), 
      (3,1),
    )
  ) 
  
  drawing.shapes.polygon(
    position: primitives.position((0, 0)),
    fill: blue.lighten(80%),
    stroke: blue,
    (
      (2,0), 
      (2,1), 
      (3,1),
    )
  )
})