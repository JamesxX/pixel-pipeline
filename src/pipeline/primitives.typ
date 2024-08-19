
#let assembled(
  stages: (),
  tags: (),
  ..data
) = (:
  stages: stages,
  tags: tags,
  ..data.named()
)

#let positioned(
  name: none,
  positions: (),
  relative: none,
  tags: (),
  ..assembly
) = (:
  ..assembly.named(),
  name: name,
  positions: positions,
  relative: relative,
  tags: (..tags, "positioned")
)