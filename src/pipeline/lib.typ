#import "../math/vector.typ"
#import "../utility/lib.typ" as utility

#import "sorting/lib.typ" as sorting
#import "stages/lib.typ" as stages

#import "primitives.typ"
#import "middleware.typ"
#import "space.typ"

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
    // This stage takes every position, and attempts to transform it from one
    // space to another. Where a point is relative to another, for each space,
    // it is checked whether both points exist in the same space. If so, the
    // position that is relative is made relative to the point (if any) the anchor
    // itself is relative to.
    if "vertex" in active-middleware {

      if anchor-sorter != none {commands = anchor-sorter(commands)}

      let available-anchors = (:)

      // TODO: Make into mapping or otherwise refactor
    //   for (index, cmd) in commands.enumerate() {

    //     let resolved-named = (:)
    //     let resolved-positioned = ()

    //     for (name, position) in cmd.positions.named() {
    //       if "relative" in position {

    //       }
    //       resolved-named.insert(name, position)
    //     }

    //     for (position) in cmd.positions.pos(){
    //       if "relative" in position {
    //         let (obj, anchor) = position.relative.split(".")
    //         if obj == "" {
    //           anchor = anchor.slice(1)

    //         } else {

    //         }
    //       }
    //       resolved-positioned.push(position)
    //     }

    //     available-anchors += resolved-named
    //     commands.at(index).positions = arguments(
    //       ..resolved-named,
    //       ..resolved-positioned
    //     )
    //   }

    //   let x = available-anchors

    }


    
    
    // transformation 

    // Anchor shader (pipeline space - relative)

    
    // BVH sorted (structured)
    // Intersection tests
    

    // Final vertex projection
    commands = commands.map( cmd => {
      if "positions" not in cmd {return cmd}
      cmd.positions = utility.arguments.map(cmd.positions, (pos) => {
        primitives.position(
          vector.scale(pos.position, scale),
          space: "screen",
          relative: pos.at("relative", default: none),
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

      if commands.len() == 0 {return}

      // Provide measure of content, but allow it to be overriden
      commands = commands.map(cmd => (: measures: measure(cmd.content)) + cmd)

      // Invoke layout middleware and pass to typesetter
      commands = stages-layout(commands, layout-middleware, scale: scale)
      stages.typeset(commands)

      // return commands
    }
  }
}