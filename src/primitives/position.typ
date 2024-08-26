#let position(
  space: "canvas", // Which coordinate system
  relative: none,
  name: none,
  coord
) = {
  (:
    position: coord,
    space: space
  )
  if relative != none {(: relative: relative)}
  if name != none {(: name: name)}
}