#import "canvas/lib.typ" as canvas
#import "layers/lib.typ" as layer
#import "sorting/lib.typ" as sorting
#import "stages/lib.typ" as stages
#import "primitives.typ"
#import "middleware.typ"

///
#let factory(
  layers: (),
  anchor-sorter: sorting.dependency,
) = {

  let active-middleware = layers.map(layer=>layer.keys())
          .flatten()
          .dedup() 

  let validate = middleware.through-layers(layers, "validation")
  let compute = middleware.through-layers(layers, "compute")
  let render = middleware.through-layers(layers, "render")

  return (commands, scale: 1em) => {


    if commands.len() == 0 {return}

    // Validation layer
    if "validation" in active-middleware {
      
      let results = validate(commands, ())
    }

    // Compute
    if "compute" in active-middleware {
      
      commands = commands.map(cmd=>compute(cmd,cmd))
    }

    // Vertex shader (pipeline space)
    if "vertex" in active-middleware {
      let compute = middleware.through-layers(layers, "vertex")
      commands = commands.map(cmd=>compute(cmd,cmd))
    }

    // Vector resolver
    
    
    // Projection

    // Anchor shader (pipeline space - relative)
    if "anchor" in active-middleware {
      // sort by dependency
      if anchor-sorter != none {commands = anchor-sorter(commands)}
    }
    
    // BVH sorted (structured)
    // Intersection tests
    
    // Fragment shader
    // 
    // sort by z-index
    // Typesetter
    
    if "render" in active-middleware {
      stages.typeset(commands, render, scale: scale)
    }


    // return commands
  }
}