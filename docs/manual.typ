#import "@preview/springer-spaniel:0.1.0"

#show: springer-spaniel.template(
  title: [PixelPipeline],
  authors: (
    (
      name: "James R. Swift",
      institute: none,
      address: "",
      email: ""
    ),
    // ... and so on
  ),
  abstract: lorem(75),

  // debug: true, // Highlights structural elements and links
  // frame: 1pt, // A border around the page for white on white display
  // printer-test: true, // Suitably placed CMYK printer tests
)

#show "PixelPipeline": raw("PixelPipeline")

#pagebreak()
#outline(indent: auto)
#pagebreak()

#include "chapters/package.typ"


= Pipeline Creation

See @fig:pipeline

#figure(
  image("assets/images/Pipeline.svg"),
  caption: lorem(25)
) <fig:pipeline>

== Primitives

#springer-spaniel.gentle-clues.warning[
  PixelPipeline doesn't support cyclic anchors. Such would result in an infinite loop.
]

== Stages

== layers

= Pipeline Invocation