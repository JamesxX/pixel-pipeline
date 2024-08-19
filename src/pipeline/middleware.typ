#let apply(input, output, layers) = {
  if layers.len() == 0 {return output}
  (layers.first())(input, output, 
    (input, output) => apply(input, output, layers.slice(1))
  )
}

#let through-layers(input, output, layers, named, key) = {

  layers = layers.map(layer=>layer.at(key, default: none))
  layers.push(named.at(key, default: none))
  layers = layers.filter(it=>it!=none)

  apply(
    input, 
    output, 
    layers
  )
}
