#import "../math/vector.typ"
#import "../utility/lib.typ" as utility

#import "sorting/lib.typ" as sorting
#import "stages/lib.typ" as stages

#import "primitives.typ"
#import "middleware.typ"

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

  // TODO: There must be a better way of doing this without going through
  //       layers multiple times
  let validate-middleware = middleware.through-layers(layers, "validation")
  let compute-middleware = middleware.through-layers(layers, "compute")
  let vertex-middleware = middleware.through-layers(layers, "vertex")
  let render-middleware = middleware.through-layers(layers, "render")
  let layout-middleware = middleware.through-layers(layers, "layout")

  /// - commands (array): Test
  return (commands, scale: 1em) => {

    // Early exit where there aren't any commands. This is usually
    // the case when someone is still declaring things in code, so
    // lets not have this be a fatal error
    if type(commands) != array {return}
    if commands.len() == 0 {return}

    // TODO: Input assembly stage

    // Stage: Validation ------------------------------------------------------
    if "validation" in active-middleware {
      
      let results = validate-middleware(commands, ())
      if results.len() > 0 {panic(results)}
    }

    // Stage: Compute ---------------------------------------------------------
    if "compute" in active-middleware {
      commands = stages.compute(commands, compute-middleware)
    }

    // Stage: Vertex ----------------------------------------------------------
    if "vertex" in active-middleware {

      if "anchor" in active-middleware {
        // sort by dependency
        if anchor-sorter != none {commands = anchor-sorter(commands)}
      }

    }

    
    
    // transformation 

    // Anchor shader (pipeline space - relative)

    
    // BVH sorted (structured)
    // Intersection tests
    

    // Final vertex projection
    commands = commands.map( cmd => {
      cmd.positions = utility.arguments.map(cmd.positions, (pos) => {
        primitives.position(
          vector.scale(pos.position, scale),
          space: "screen"
        )
      })
      return cmd
    })
    
    // Stage: Render ----------------------------------------------------------
    if "render" in active-middleware {
      commands = stages-render(commands, render-middleware)
    }
    
    // Stage: Layout ----------------------------------------------------------
    commands = commands.filter(cmd => cmd != none)

    context if "layout" in active-middleware { 
      let commands = commands.filter(
        cmd => cmd.at("content", default: none) != none
      )

      // Provide measure of content, but allow it to be overriden
      commands = commands.map(cmd => (: measures: measure(cmd.content)) + cmd)

      // Invoke layout middleware and pass to typesetter
      commands = stages-layout(commands, layout-middleware, scale: scale)
      stages.typeset(commands)

      // return commands
    }
  }
}