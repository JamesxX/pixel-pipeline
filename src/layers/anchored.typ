#let validation(input, output, next) = {
  output.push("Initializing Anchored")
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

#let layer() = (:
  validation: validation,
  input-assembler: input-assembler,
  compute: compute,
  vertex: vertex,
)