#import "../primitives.typ"

#let validation(input, output, next) = {
  output.push("Hello")
  next(input, output)
}

#let input-assembler(input, output, next)={
  next(input, output)
}

#let compute(input, output, next)={
  next(input, output)
}

#let vertex(input, output, next)={
  next(input, output)
}

#let render(input, output, next)={
  next(input, input)
}

#let layer() = (:
  validation: validation,
  input-assembler: input-assembler,
  compute: compute,
  vertex: vertex,
  render: render,
)