#import "/src/primitives/lib.typ" as primitives

#let polygon(
  position: primitives.position((0,0)),
  vertices,
  fill: none,
  stroke: auto,
) = ({
  primitives.pipeline.assembled(tags: ("draw", "polygon")  )
  primitives.pipeline.positioned(
    positions: arguments(..vertices.map(primitives.position), root: position),
  )
  primitives.pipeline.stroked(fill: fill, stroke: stroke)
},)