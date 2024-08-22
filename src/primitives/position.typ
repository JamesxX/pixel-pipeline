#let position(
  space: "", // Which coordinate system
  anchor: none,
  name: none,
  coord
) = {
  (:
    position: coord,
    space: space
  )
  if anchor != none {(: anchor: anchor)}
  if name != none {(: name: name)}
}