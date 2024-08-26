#import "../primitives/position.typ": position

#let assembled(
  tags: (),
  ..data
) = {
  (: tags: tags)
  data.named()
}

#let positioned(
  positions: arguments( root: position((0,0)) ),
  name: none,
) = {
  (: positions: positions,)
  if name != none {(: name: name)}
}

#let stroked(
  fill: none,
  stroke: none,
) = {
  if fill != none {(: fill: fill)}
  if stroke != none {(: stroke: stroke)}
}

#let rendered(
  content: none,
) = (:
  content: content,
)