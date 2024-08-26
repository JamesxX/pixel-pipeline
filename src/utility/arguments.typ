#let map(args, fn) = arguments(
  ..for (key, value) in args.named() {
    (: (key): fn(value))
  },
  ..args.pos().map(fn),
)