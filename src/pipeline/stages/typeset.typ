#import "/src/math/lib.typ": vector, aabb

#let _get-bounds(commands) = {
  return (
    high: (1, 1),
    low: (-1, -1),
  )

  // TODO: Make this a fold
  let bounds = none
  for cmd in commands {
    
  }
}

// TODO: Throw away commands without root position or body
#let draw(cmd, scale: 1em, bounds: (:)) = context {
  let (width, height) = measure(cmd.content)
  // let pos = vector.scale(cmd.positions.root)
  place(
    top + left,
    float: false,
    // dx: cmd.x * scale, dy: cmd.y * scale,
    move(
      dx: (cmd.positions.root.at(0) - bounds.low.at(0)) * scale - width / 2,
      dy: (cmd.positions.root.at(1) - bounds.low.at(1)) * scale - height / 2,
      cmd.content,
    )
  )
}


#let typeset(commands, render-middleware, scale: 1em) = {
  let commands = commands.map(cmd=>render-middleware(cmd,cmd)).filter(it=>"content" in it)
  let bounds = _get-bounds(commands)
  let (width, height) = vector.scale(aabb.size(bounds), scale)

  box(
    width: width, height: height,
    align(top, commands.map(draw.with(scale: scale, bounds: bounds)).join())
  )
}