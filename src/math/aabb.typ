#import "vector.typ"

#let from-vectors(vecs, initial: none) = {
  let bounds = initial

  if type(vecs) == array {
    for (i, pt) in vecs.enumerate() {
      if bounds == none and i == 0 {
        bounds = (low: pt, high: pt)
      } else {
        assert(type(pt) == array, message: repr(initial) + repr(vecs))
        let (x, y,) = pt

        let (lo-x, lo-y,) = bounds.low
        bounds.low = (calc.min(lo-x, x), calc.min(lo-y, y))

        let (hi-x, hi-y) = bounds.high
        bounds.high = (calc.max(hi-x, x), calc.max(hi-y, y))
      }
    }
    return bounds
  } else if type(vecs) == dictionary {
    if initial == none {
      return vecs
    } else {
      return from-vectors((vecs.low, vecs.high,), initial: initial)
    }
  }
}

/// Get the size of an aabb as vector. This is a vector from the aabb's low to high.
///
/// - bounds (aabb): The aabb to get the size of.
/// -> vector
#let size(bounds) = {
  return vector.sub(bounds.high, bounds.low)
}