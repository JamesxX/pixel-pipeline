#import "shapes/lib.typ" as shapes

#import "validation.typ": validation as _validate

#let layer(
  validation: false
) = (:
  validation: _validate.with(enabled: validation),
  // input-assembler: input-assembler,
  // compute: compute,
  // vertex: vertex,
)