#import "/tests/preamble.typ": *
#import dynamic-canvas: *

#let plotter = pipeline.factory(
  layers: (
    layer.debug(),
    layer.drawing.layer(validation: true),
  ),
)

#let duff-cmd(pos: (0,0)) = (
  pipeline.primitives.rendered(
    pipeline.primitives.positioned(
      pipeline.primitives.assembled(
        tags: ("hello",)
      ),
      positions: (:
        root: pos
      )
    ),
    content: [Hello]
  ),
)

#import layer: drawing

#plotter({
  drawing.shapes.polygon()
})