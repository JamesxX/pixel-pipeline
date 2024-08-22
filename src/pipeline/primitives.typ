
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
  positions: (root:(0,0)),
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

#let rendered(
  content: none,
  tags: (),
  ..positioned,
) = (:
  ..positioned.named(),
  content: content,
  tags: (..tags, "rendered")
)