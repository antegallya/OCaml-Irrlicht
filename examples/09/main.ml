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

module Generate_func : sig
  type t = int -> int -> float -> float
  val eggbox : t
  val moresine : t
  val justexp : t
end = struct
  type t = int -> int -> float -> float
  let eggbox x y s =
    let r = 4. *. sqrt (float_of_int (x * x + y * y)) /. s in
    let aux z = cos (0.2 *. float_of_int x) in
    let z = exp (-. r *. 2.) *. (aux x) *. (aux y) in
    0.25 +. 0.25 *. z
  let moresine x y s =
    let xx = 0.3 *. (float_of_int x) /. s in
    let yy = 12. *. (float_of_int y) /. s in
    let z = sin (xx *. xx +. yy) *. sin (xx +. yy *. yy) in
    0.25 +. 0.25 *. z
  let justexp x y s =
    let aux z = 6. *. (float_of_int z) /. s in
    let xx = aux x and yy = aux y in
    let z = xx *. xx +. yy *. yy in
    0.3 *. z *. cos (xx *. yy)
end
