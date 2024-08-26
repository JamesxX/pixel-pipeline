#let apply(input, output, layers) = {
  if layers.len() == 0 {return output}
  (layers.first())(input, output, 
    (input, output) => apply(input, output, layers.slice(1))
  )
}

#let stack(layers, key) = {
  layers.map(layer=>layer.at(key, default: none))
        .filter(it=>it!=none)
}

#let through-layers(layers, key) = (input, output) => apply(
  input,
  output,
  stack(layers, key)
)