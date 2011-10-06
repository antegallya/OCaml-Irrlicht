type 'a dimension_2d = 'a * 'a

type 'a pos_2d = 'a * 'a

type 'a vector_3d = 'a * 'a * 'a

type vector3df = float vector_3d

type line3df = vector3df * vector3df

type triangle3df = vector3df * vector3df * vector3df

type 'a rect = 'a * 'a * 'a * 'a

type 'a color = {a : 'a; r : 'a; g : 'a; b : 'a}

let color_ARGB ~a ~r ~g ~b = {a = a; r = r; g = g; b = b}

let color_RGB ?(a = 1) = color_ARGB ~a
let colorf_RGB ?(a = 1.) = color_ARGB ~a

type matrix4 = float array

let matrix_identity () =
  Array.init 16 (fun i -> if i mod 4 = i / 4 then 1. else 0.)

type 'a aabbox3d = 'a vector_3d * 'a vector_3d
