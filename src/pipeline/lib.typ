#import "canvas/lib.typ" as canvas
#import "layers/lib.typ" as layer
#import "sorting/lib.typ" as sorting
#import "primitives.typ"
#import "middleware.typ"

#let factory(
  layers: (),
  stages: auto,
  anchor-sorter: sorting.dependency,
  ..outer
) = {

  let stages = if (stages == auto){ 
    layers.map(layer=>layer.keys())
          .flatten()
          .dedup() 
  } else {stages}

  let (positional, named) = (outer.pos(), outer.named())
  
  return (body, ..inputs) => {


    if body.len() == 0 {return}
    // (Required): Input assembly

    let commands = body.map(cmd => {
      middleware.through-layers(cmd, primitives.assembled(..cmd), layers, named, "input-assembler")
    })

    // Validation layer
    if "validation" in stages {
      let validation-errors = middleware.through-layers(commands, (), layers, named, "validation")
    }

    // Compute
    if "compute" in stages {
      commands = commands.map(cmd =>{
        middleware.through-layers(cmd, cmd, layers, named, "compute")
      })
    }

    // Vertex shader (pipeline space)
    if "vertex" in stages {
      commands = commands.map(cmd => {
        middleware.through-layers(cmd, primitives.positioned(..cmd), layers, named, "vertex")
      })
    }

    // Vector resolver

    
    // sort by dependency
    // Anchor shader (pipeline space - relative)
    // 
    // BVH sorted (structured)
    // Intersection tests
    // Projection
    // Fragment shader
    // 
    // sort by z-index
    // Typesetter
  }
}