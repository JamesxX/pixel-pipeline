#import "canvas/lib.typ" as canvas
#import "layers/lib.typ" as layer
#import "sorting/lib.typ" as sorting
#import "stages/lib.typ" as stages
#import "primitives.typ"
#import "middleware.typ"

#let factory(
  layers: (),
  stages: auto,
  anchor-sorter: sorting.dependency,
) = {

  let stages = if (stages == auto){ 
    layers.map(layer=>layer.keys())
          .flatten()
          .dedup() 
  } else {stages}
  
  return (commands, ..inputs) => {


    if commands.len() == 0 {return}

    // Validation layer
    if "validation" in stages {
      let validate = middleware.through-layers(layers, "validation")
      let results = validate(commands, ())
    }

    // Compute
    if "compute" in stages {
      let compute = middleware.through-layers(layers, "compute")
      commands = commands.map(cmd=>compute(cmd,cmd))
    }

    // Vertex shader (pipeline space)
    if "vertex" in stages {
      let compute = middleware.through-layers(layers, "vertex")
      commands = commands.map(cmd=>compute(cmd,cmd))
    }

    // Vector resolver
    
    
    // Projection

    // Anchor shader (pipeline space - relative)
    if "anchor" in stages {
      // sort by dependency
      if anchor-sorter != none {commands = anchor-sorter(commands)}
    }
    
    // BVH sorted (structured)
    // Intersection tests
    
    // Fragment shader
    // 
    // sort by z-index
    // Typesetter
    // 
    return commands
  }
}