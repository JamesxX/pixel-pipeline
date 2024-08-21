#import "/tests/preamble.typ": *
#import dynamic-canvas: *

#let plotter = pipeline.factory(
  layers: (
    pipeline.layer.debug(),
  ),
)

#let duff-cmd = (pipeline.primitives.assembled(),)

#plotter({
  duff-cmd
  duff-cmd
  duff-cmd
})