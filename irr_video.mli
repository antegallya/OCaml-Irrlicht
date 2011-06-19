(** This module implements some of the namespace irr:video *)

(** Exception raised when begin_scene or end_scene fails *)
exception Rendering_failed_exn

type obj = Irr_base.obj

(** Class S3DVertex *)
module Vertex : sig
  type t =
    {color : Irr_core.color; normal : Irr_core.vector3df;
      pos : Irr_core.vector3df; t_coords : float * float}
end

(** Class SLight *)
module Light : sig
  type t = {
    ambient : Irr_core.colorf;
    attenuation : Irr_core.vector3df;
    cast_shadows : bool;
    diffuse : Irr_core.colorf;
    direction : Irr_core.vector3df;
    falloff : float;
    inner_cone : float;
    outer_cone : float;
    pos : Irr_core.vector3df;
    radius : float;
    specular : Irr_core.colorf;
    ty : Irr_enums.light_type;
  }
  val cons :
    t -> ?ambient:Irr_core.colorf -> ?attenuation:Irr_core.vector3df ->
      ?cast_shadows:bool -> ?diffuse:Irr_core.colorf ->
      ?direction:Irr_core.vector3df -> ?falloff:float -> ?inner_cone:float ->
      ?outer_cone:float -> ?pos:Irr_core.vector3df -> ?radius:float ->
      ?specular:Irr_core.colorf -> ?ty:Irr_enums.light_type -> unit -> t
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
  method ambient_color : Irr_core.color
  method anti_aliasing : Irr_enums.anti_aliasing_mode
  method backface_culling : bool
  method color_mask : Irr_enums.color_plane
  method color_material : Irr_enums.colormaterial
  method diffuse_color : Irr_core.color
  method emissive_color : Irr_core.color
  method fog_enable : bool
  method flag : Irr_enums.material_flag -> bool
  method set_anti_aliasing : Irr_enums.anti_aliasing_mode -> unit
  method set_texture : int -> texture -> unit
  method set_lighting : bool -> unit
  method set_normalize_normals : bool -> unit
  method set_wireframe : bool -> unit
  method set_ambient_color : Irr_core.color -> unit
  method set_backface_culling : bool -> unit
  method set_color_mask : Irr_enums.color_plane -> unit
  method set_color_material : Irr_enums.colormaterial -> unit
  method set_diffuse_color : Irr_core.color -> unit
  method set_emissive_color : Irr_core.color -> unit
  method set_fog_enable : bool -> unit
  method set_flag : Irr_enums.material_flag -> bool -> unit
  method set_specular_color : Irr_core.color -> unit
end

class material_fresh : object
  inherit material
end

(** Class IVideoDriver *)
class driver : obj -> object
  inherit Irr_base.reference_counted
  method begin_scene : ?backbuffer:bool -> ?zbuffer:bool ->
    ?color:Irr_core.color -> unit -> unit
  method end_scene : unit
  method draw_2d_image :
    texture -> ?src:int Irr_core.rect -> ?clip:int Irr_core.rect ->
      ?color:Irr_core.color -> ?alpha:bool -> int Irr_core.dimension_2d -> unit
  method draw_2d_image_scale :
    texture -> ?src:int Irr_core.rect -> ?clip:int Irr_core.rect ->
    ?colors:(Irr_core.color * Irr_core.color * Irr_core.color *
      Irr_core.color) ->
    ?alpha:bool -> int Irr_core.rect -> unit
  method draw_2d_rect :
    Irr_core.color -> ?clip:int Irr_core.rect -> int Irr_core.rect -> unit
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
  method draw_3d_triangle : Irr_core.triangle3df -> Irr_core.color -> unit
  method set_material : material -> unit
  method max_prim_count : int
end
