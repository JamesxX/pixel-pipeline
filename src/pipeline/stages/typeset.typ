#import "/src/math/lib.typ": vector, aabb

#let _get-bounds(commands) = {
  // TODO: Make this a fold
  let bounds = none
  for cmd in commands {
    let half-measures = vector.scale( cmd.measures.values(), 0.5 )
    let position = cmd.positions.named().root.position.map(dim=>dim.to-absolute())
    bounds = aabb.from-vectors(
      (
        low: vector.sub(position, half-measures),
        high: vector.add(position, half-measures),
      ),
      initial: bounds,
    )
  }
  return bounds
}

// TODO: Throw away commands without root position or body
#let draw(cmd, scale: 1em, bounds: (:)) = context {

  let (width, height) = cmd.at("measures", default: (0pt, 0pt))
  let pos = vector.sub(
    cmd.positions.named().root.position,
    bounds.low
  )

  place(
    top + left,
    float: false,
    move(
      dx: pos.at(0) - width / 2,
      dy: pos.at(1) - height / 2,
      cmd.content,
    )
  )
}

#let typeset(commands) = {
  let bounds = _get-bounds(commands)
  let (width, height) = aabb.size(bounds)

  box(
    width: width, height: height,
    stroke: black,
    align(top, commands.map(draw.with(bounds: bounds)).join())
  )
}