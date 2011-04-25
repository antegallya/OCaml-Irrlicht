type 'a dimension_2d = 'a * 'a

type 'a pos_2d = 'a * 'a

type 'a vector_3d = 'a * 'a * 'a

type vector3df = float * float * float

type line3df = vector3df * vector3df

type triangle3df = vector3df * vector3df * vector3df

type 'a rect = 'a * 'a * 'a * 'a

type color = {a : int; r : int; g : int; b : int}

type colorf = {af : float; rf : float; gf : float; bf : float}

type matrix4

type 'a aabbox3d = 'a vector_3d * 'a vector_3d

val color_ARGB : a:int -> r:int -> g:int -> b:int -> color

val colorf_RGB : ?a:float -> float -> float -> float -> colorf

val matrix_identity : unit -> matrix4
