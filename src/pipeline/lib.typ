#import "canvas/lib.typ" as canvas
#import "sorting/lib.typ" as sorting
#import "stages/lib.typ" as stages
#import "primitives.typ"
#import "middleware.typ"
#import "../math/vector.typ"

#let stages-render(commands, middleware) = {
  commands.map(cmd=>cmd + middleware(cmd,(:)))
}

#let stages-measure(commands, middleware) = {
  commands.map(cmd=>cmd + middleware(cmd,(:)))
}

#let stages-layout(commands, middleware, scale: 1em) = {
  commands.map(cmd=>cmd + middleware(cmd,(:)))
}

///
#let factory(
  layers: (),
  anchor-sorter: sorting.dependency,
) = {

  let active-middleware = layers.map(layer=>layer.keys())
          .flatten()
          .dedup() 

  let validate-middleware = middleware.through-layers(layers, "validation")
  let compute-middleware = middleware.through-layers(layers, "compute")
  let render-middleware = middleware.through-layers(layers, "render")
  let layout-middleware = middleware.through-layers(layers, "layout")

  /// - commands (array): Test
  return (commands, scale: 1em) => {

    if type(commands) != array {return}
    if commands.len() == 0 {return}

    // Validation layer
    if "validation" in active-middleware {
      
      let results = validate-middleware(commands, ())
      if results.len() > 0 {panic(results)}
    }

    // Compute
    if "compute" in active-middleware {commands = stages.compute(commands, compute-middleware)}

    // Vertex Shader Pre
    // -> anchor
    if "vertex-1" in active-middleware {

    }

    
    
    // transformation 

    // Anchor shader (pipeline space - relative)
    if "anchor" in active-middleware {
      // sort by dependency
      if anchor-sorter != none {commands = anchor-sorter(commands)}
    }
    
    // BVH sorted (structured)
    // Intersection tests
    

    // Final vertex projection
    commands = commands.map(cmd => {
      cmd.positions = arguments(
        ..for (name, pos) in cmd.positions.named() {
          (: (name): primitives.position(vector.scale(pos.position, scale), space: "screen"))
        },
        ..for (pos) in cmd.positions.pos(){
          (primitives.position(vector.scale(pos.position, scale), space: "screen"),)
        }
      )
      return cmd
    })
    
    // make content
    if "render" in active-middleware {
      commands = stages-render(commands, render-middleware)
    }
    
    context if "layout" in active-middleware { 
      let commands = commands.filter(cmd => cmd != none and cmd.at("content", default: none) != none)
      commands = commands.map(cmd => (: measures: measure(cmd.content)) + cmd)
      commands = stages-layout(commands, layout-middleware, scale: scale)
      stages.typeset(commands)
      // return commands
    }
  }
}