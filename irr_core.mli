type 'a dimension_2d = 'a * 'a

type 'a pos_2d = 'a * 'a

type 'a vector_3d = 'a * 'a * 'a

type vector3df = float vector_3d

type line3df = vector3df * vector3df

type triangle3df = vector3df * vector3df * vector3df

type 'a rect = 'a * 'a * 'a * 'a

type 'a color = {a : 'a; r : 'a; g : 'a; b : 'a}

type matrix4

type 'a aabbox3d = 'a vector_3d * 'a vector_3d

val color_ARGB : a:'a -> r:'a -> g:'a -> b:'a -> 'a color

val color_RGB : ?a:int -> r:int -> g:int -> b:int -> int color

val colorf_RGB : ?a:float -> r:float -> g:float -> b:float -> float color

val matrix_identity : unit -> matrix4
