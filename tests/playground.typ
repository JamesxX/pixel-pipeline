#import "preamble.typ": *
#import pixel.math: vector

#let _validate(input, output, next) = {
  next(input, output)
}

#let _compute(input, output, next) = {
  next(input, output)
}

#let _vertex(input, output, next) = {
  next(input, output)
}

#let _render(input, output, next) = {
  if "plot" not in input.tags {return next(input, output)}

  if "axis" in input.tags {
    return input + (:
      content: {
        place(line(
          start: input.positions.named().start.position, 
          end: input.positions.named().end.position
        ))
        for i in range(0, 11) {
          let pos = vector.add(
            input.positions.named().start.position,
            vector.scale(
              vector.sub(
                input.positions.named().end.position,
                input.positions.named().start.position
              ), 
              i/10
            ),
          )
          place(line(
            start: pos,
            end: vector.add(pos, (-2pt,3pt))
          )) + place(
            dx: vector.add(pos, (-2pt,3pt)).first(),
            dy: vector.add(pos, (-2pt,3pt)).last(),
            $#i$
          )
        }
      }
    )
  }
}

#let _layout(input, output, next) = {
  next(input, output)
}

#let test-pipeline = pixel.pipeline.factory(
  layers: (

    pixel.layer.drawing.layer(validation: true),
    (:
      validation: _validate,
      compute: _compute,
      vertex: _vertex,
      render: _render,
      layout: _layout,
    ),
    // pixel.layer.debug(),
  ),
)


#test-pipeline({
  (
    {
      pixel.primitives.assembled(
        tags: ("plot","axis"),
        min: 0,
        max: 10,
      )
      pixel.primitives.positioned(
        positions: arguments(
          root: pixel.primitives.position((0,0)),
          start: pixel.primitives.position((0,0)),
          end: pixel.primitives.position((10,10)),
        )
      )
    },
  )
  (
    {
      pixel.primitives.assembled(
        tags: ("plot","axis"),
        min: 0,
        max: 10,
      )
      pixel.primitives.positioned(
        positions: arguments(
          root: pixel.primitives.position((1,0)),
          start: pixel.primitives.position((0,0)),
          end: pixel.primitives.position((10,10)),
        )
      )
    },
  )

})