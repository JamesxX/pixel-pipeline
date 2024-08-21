#import "/tests/preamble.typ": *
#import dynamic-canvas: *

#let plotter = pipeline.factory(
  layers: (
    pipeline.layer.debug(),
    pipeline.layer.drawing.layer(validation: true),
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

#plotter({
  duff-cmd()
  duff-cmd(pos: (0, 1))
  duff-cmd(pos: (1, 2))
})