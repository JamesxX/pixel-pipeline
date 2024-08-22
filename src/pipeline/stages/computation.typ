#let compute(commands, middleware) = {
  commands.map(cmd=>cmd + middleware(cmd,(:)))
}