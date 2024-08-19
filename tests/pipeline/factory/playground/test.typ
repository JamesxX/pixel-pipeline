#import "/tests/preamble.typ": *
#import dynamic-canvas: *

#let plotter = pipeline.factory(
  layers: (
    pipeline.layer.debug(),
  ),
  // input-assembler: (i,o,n)=>n(i, o)
  validation: (i,o,n)=>n(i, o)
)

#let duff-cmd = (pipeline.primitives.assembled(
  stages: ("compute","vertex")
),)

#plotter({
  duff-cmd
  duff-cmd
  duff-cmd
})