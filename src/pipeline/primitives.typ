
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
  assembly
) = (:
  ..assembly,
  name: name,
  positions: positions,
  relative: relative,
  tags: (..tags, "positioned")
)

#let rendered(
  content: none,
  tags: (),
  positioned,
) = (:
  ..positioned,
  content: content,
  tags: (..tags, "rendered")
)