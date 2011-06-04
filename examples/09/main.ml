module Colour_func : sig
  type t = float -> float -> float -> Irr_core.color
  val grey : t
  val yellow : t
  val white : t
end = struct
  type t = float -> float -> float -> Irr_core.color
  let grey x y z =
    let n = int_of_float (255. *. z) in
    Irr_core.color_ARGB 255 n n n
  let yellow x y z =
    let aux w = 128 + int_of_float (127. *. w) in
    Irr_core.color_ARGB 255 (aux x) (aux y) 255
  let white x y z = Irr_core.color_ARGB 255 255 255 255
end
