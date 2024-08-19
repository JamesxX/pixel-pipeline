// #import "/src/package.typ": package
#import "/src/math/lib.typ": *
#import "process.typ"

#let paint(
  scale: 1em,
  background: none,
  body
) = context {

  if body == none {return []}

  let (bounds, drawables) = process.many(body)
  if bounds == none {return []}

  // Filter hidden drawables
  drawables = drawables.filter(
    d => not d.at("hidden", default: false)
  )

  // Order draw commands by z-index
  drawables = drawables.sorted(key: (cmd) => {
    return cmd.at("z-index", default: 0)
  })

  // Final canvas size
  let (width, height, ..) = vector.scale(aabb.size(bounds), scale)

  box(
    width: width, height: height,
    fill: background,
    align(top, {

      for drawable in drawables {

        let (x, y, _) = if drawable.type == "path" {
          vector.sub(
            aabb.aabb(path-util.bounds(drawable.segments)).low,
            bounds.low)
        } else {
          (0, 0, 0)
        }

        place(
          top + left,
          float: false,
          {
            let (width, height) = measure(drawable.body)
            move(
              dx: (drawable.pos.at(0) - bounds.low.at(0)) * scale - width / 2,
              dy: (drawable.pos.at(1) - bounds.low.at(1)) * scale - height / 2,
              drawable.body,
            )
          },
          dx: x * scale, dy: y * scale
        )
      }
    })
  )
}