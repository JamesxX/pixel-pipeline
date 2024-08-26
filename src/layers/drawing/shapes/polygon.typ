#import "/src/primitives/lib.typ" as primitives

#let polygon(
  position: primitives.position((0,0)),
  vertices,
  fill: none,
  stroke: auto,
  ..args
) = ({
  primitives.pipeline.assembled(tags: ("draw", "polygon"), ..args )
  primitives.pipeline.positioned(
    positions: arguments(..vertices.map(primitives.position), root: position),
  )
  primitives.pipeline.stroked(fill: fill, stroke: stroke)
},)