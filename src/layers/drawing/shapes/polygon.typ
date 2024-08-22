#import "../primitives.typ"

#let polygon(
  position: (0,0),
  vertices,
  fill: none,
  stroke: auto,
) = (
  primitives.rendered(
    ..primitives.positioned(
      ..primitives.assembled(tags: ("draw", "polygon")),
      vertices: vertices,
      fill: fill,
      stroke: stroke,
    ),
  ),
)