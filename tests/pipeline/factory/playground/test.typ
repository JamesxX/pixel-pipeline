#import "/tests/preamble.typ": *
#import pixel: *

#let plotter = pipeline.factory(
  layers: (
    layer.debug(),
  ),
)

#let duff-cmd(pos: (0,0)) = {
  pipeline.primitives.assembled(
    tags: ("hello", )
  )
  pipeline.primitives.positioned(
    positions: (:
      root: pos
    )
  )
  pipeline.primitives.rendered(
    content: [Hello]
  )
}

#plotter({
  duff-cmd()
  duff-cmd(pos: (0, 1))
  duff-cmd(pos: (1, 2))
})