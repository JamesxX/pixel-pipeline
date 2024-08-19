#import "/tests/preamble.typ": *

#dynamic-canvas.pipeline.canvas.paint((
  (drawables: (
    (
      type: "content",
      pos: (0, 0, 0),
      width: 1,
      height: 1,
      body: [H]
    ),
      (
      type: "content",
      pos: (3, 3, 0),
      width: 1,
      height: 1,
      body: [H1]
    ),
  )),
))