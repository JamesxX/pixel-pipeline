#import "/src/math/lib.typ": *

#let individual(element, anchors: (:)) = {
  let bounds = none
  let element = element // mutable
  
  if "drawables" in element {
    if type(element.drawables) == dictionary {
      element.drawables = (element.drawables,)
    }
    for drawable in element.drawables {
      bounds = aabb.from-vectors(
        if drawable.type == "path" {
          path-util.bounds(drawable.segments)
        } else if drawable.type == "content" {
          let (x, y, _, w, h,) = drawable.pos + (drawable.width, drawable.height)
          ((x + w / 2, y - h / 2, 0), (x - w / 2, y + h / 2, 0))
        },
        initial: bounds
      )
    }
  }

  return (
    bounds: bounds,
    drawables: element.at("drawables", default: ()),
  )
}

#let many(body, anchors: (:)) = {
  let drawables = ()
  let anchors = anchors // mutable
  let bounds = none

  for element in body {
    if type(element) == array {
      (bounds, drawables, anchors) = many(element, anchors)
    } else {
      let processed = individual(element)
      if processed != none {
        if processed.bounds != none {
          bounds = aabb.from-vectors(processed.bounds, initial: bounds)
        }
        drawables += processed.drawables
      }
    }
  }

  return (
    bounds: bounds, 
    drawables: drawables, 
    anchors: anchors
  )
}