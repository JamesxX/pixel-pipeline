#import "../pipeline/primitives.typ"

#let validation(input, output, next) = {
  output += input.map(it=>{
    if type(it) != dictionary {return "Unexpected command structure " + repr(it)}
  }).filter(it=>it!=none)
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