let normalize (x, y, z) =
  let len = sqrt (x *. x +. y *. y +. z *. z) in
  (x /. len, y /. len, z /. len)

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

module Height_map : sig
  type t
  val create : int -> int -> t
  val generate : t -> Generate_func.t -> unit
  val width : t -> int
  val height : t -> int
  val calc : t -> Generate_func.t -> int -> int -> float
  val set : t -> int -> int -> float -> unit
  val set_i : t -> int -> float -> unit
  val get : t -> int -> int -> float
  val get_normal : t -> int -> int -> float -> Irr_core.vector3df
end = struct
  type t = {width : int; height : int; s : float; data : float array}
  let create w h =
    let s = sqrt (float_of_int (w * w + h * h)) in
    let data = Array.make (w * h) 0. in
    {width = w; height = h; s = s; data = data}
  let set_i map x z = map.data.(x) <- z
  let set map x y z = set_i map (y * map.width + x) z
  let get map x y = map.data.(y * map.width + x)
  let calc map f x y =
    let aux z d = int_of_float (float z -. float d *. 0.5) in
    f (aux x map.width) (aux y map.height) map.s
  let width map = map.width
  let height map = map.height
  let generate map f =
    for y = 0 to map.height - 1 do
      for x = 0 to map.width - 1 do
        set map x y (calc map f x y)
      done
    done
  let get_normal map x y s =
    let zc = get map x y in
    let zl, zr =
      if x = 0 then let zr = get map (x + 1) y in (zc +. zc -. zr, zr)
      else if x = map.width - 1 then
        let zl = get map (x - 1) y in (zl, zc +. zc -. zl)
      else (get map (x - 1) y, get map (x + 1) y) in
    let zu, zd =
      if y = 0 then let zd = get map x (y + 1) in (zc +. zc -. zd, zd)
      else if y = map.height - 1 then
        let zu = get map x (y - 1) in (zu, zc +. zc -. zu)
      else (get map x (y - 1), get map x (y + 1)) in
    normalize (s *. 2. *. (zl -. zr), 4., s *. 2. *. (zd -. zu))
end
