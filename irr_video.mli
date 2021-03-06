(** This module implements some of the namespace irr:video *)

(** Exception raised when begin_scene or end_scene fails *)
exception Rendering_failed_exn

type obj = Irr_base.obj

(** Class S3DVertex *)
module Vertex : sig
  type t =
    {color : int Irr_core.color; normal : Irr_core.vector3df;
      pos : Irr_core.vector3df; t_coords : float * float}
end

(** Class SLight *)
module Light : sig
  type t = {
    ambient : float Irr_core.color;
    attenuation : Irr_core.vector3df;
    cast_shadows : bool;
    diffuse : float Irr_core.color;
    direction : Irr_core.vector3df;
    falloff : float;
    inner_cone : float;
    outer_cone : float;
    pos : Irr_core.vector3df;
    radius : float;
    specular : float Irr_core.color;
    ty : Irr_enums.light_type;
  }
  val cons :
    t -> ?ambient:float Irr_core.color -> ?attenuation:Irr_core.vector3df ->
      ?cast_shadows:bool -> ?diffuse:float Irr_core.color ->
      ?direction:Irr_core.vector3df -> ?falloff:float -> ?inner_cone:float ->
      ?outer_cone:float -> ?pos:Irr_core.vector3df -> ?radius:float ->
      ?specular:float Irr_core.color -> ?ty:Irr_enums.light_type -> unit -> t
end

(** Class ITexture *)
class texture : obj -> object
  inherit Irr_base.reference_counted
  method original_size : int Irr_core.dimension_2d
end

(** Class SMaterialLayer *)
class material_layer : obj -> object
  method obj : obj
  method set_bilinear_filter : bool -> unit
end

(** Class SMaterial *)
class material : obj -> object
  method obj : obj
  method layer : int -> material_layer
  method wireframe : bool
  method point_cloud : bool
  method material_type : Irr_enums.material_type
  method ambient_color : int Irr_core.color
  method anti_aliasing : Irr_enums.anti_aliasing_mode
  method backface_culling : bool
  method color_mask : Irr_enums.color_plane
  method color_material : Irr_enums.colormaterial
  method diffuse_color : int Irr_core.color
  method emissive_color : int Irr_core.color
  method fog_enable : bool
  method shininess : float
  method specular_color : int Irr_core.color
  method flag : Irr_enums.material_flag -> bool
  method thickness : float
  method zbuffer : Irr_enums.comparison_func
  method zwrite : bool
  method material_type_param : float
  method material_type_param2 : float
  method set_anti_aliasing : Irr_enums.anti_aliasing_mode -> unit
  method set_texture : int -> texture -> unit
  method set_lighting : bool -> unit
  method set_normalize_normals : bool -> unit
  method set_wireframe : bool -> unit
  method set_ambient_color : int Irr_core.color -> unit
  method set_backface_culling : bool -> unit
  method set_color_mask : Irr_enums.color_plane -> unit
  method set_color_material : Irr_enums.colormaterial -> unit
  method set_diffuse_color : int Irr_core.color -> unit
  method set_emissive_color : int Irr_core.color -> unit
  method set_fog_enable : bool -> unit
  method set_material_type : Irr_enums.material_type -> unit
  method set_shininess : float -> unit
  method set_flag : Irr_enums.material_flag -> bool -> unit
  method set_specular_color : int Irr_core.color -> unit
  method set_thickness : float -> unit
  method set_zbuffer : Irr_enums.comparison_func -> unit
  method set_zwrite : bool -> unit
  method set_material_type_param : float -> unit
  method set_material_type_param2 : float -> unit
end

class material_fresh : object
  inherit material
end

(** Class IVideoDriver *)
class driver : obj -> object
  inherit Irr_base.reference_counted
  method begin_scene : ?backbuffer:bool -> ?zbuffer:bool ->
    ?color:int Irr_core.color -> unit -> unit
  method end_scene : unit
  method draw_2d_image :
    texture -> ?src:int Irr_core.rect -> ?clip:int Irr_core.rect ->
      ?color:int Irr_core.color -> ?alpha:bool -> int Irr_core.dimension_2d -> unit
  method draw_2d_image_scale :
    texture -> ?src:int Irr_core.rect -> ?clip:int Irr_core.rect ->
    ?colors:(int Irr_core.color * int Irr_core.color * int Irr_core.color *
      int Irr_core.color) ->
    ?alpha:bool -> int Irr_core.rect -> unit
  method draw_2d_rect :
    int Irr_core.color -> ?clip:int Irr_core.rect -> int Irr_core.rect -> unit
  method get_texture : string -> texture
  method material_2d : material
  method enable_material_2d : unit
  method disable_material_2d : unit
  method make_color_key_from_px :
    texture -> ?zero_texels:bool -> int Irr_core.dimension_2d -> unit
  method fps : int
  method name : string
  method set_texture_creation_flag :
    Irr_enums.texture_creation_flag -> bool -> unit
  method set_transform :
    Irr_enums.transformation_state -> Irr_core.matrix4 -> unit
  method draw_3d_line : ?color:int Irr_core.color -> Irr_core.vector3df ->
    Irr_core.vector3df -> unit
  method draw_3d_triangle :
    ?color:int Irr_core.color -> Irr_core.triangle3df -> unit
  method draw_vertex_primitive_list_16 : Vertex.t array ->
    (int, Bigarray.int16_signed_elt, Bigarray.c_layout) Bigarray.Array1.t ->
    int -> Irr_enums.primitive_type -> unit
  method draw_vertex_primitive_list_32 : Vertex.t array ->
    (int32, Bigarray.int32_elt, Bigarray.c_layout) Bigarray.Array1.t ->
    int -> Irr_enums.primitive_type -> unit
  method set_material : material -> unit
  method max_prim_count : int
end
