(** This module implements some of the namespace irr:video *)

(** Exception raised when begin_scene or end_scene fails *)
exception Rendering_failed_exn

type obj = Irr_base.obj

(** Class ITexture *)
class texture : obj -> object
  inherit Irr_base.reference_counted
  method original_size : int Irr_core.dimension_2d
end

(** Class SMaterialLayer *)
(*module Material_layer : sig
  type t = {
    mutable aniosotropic_filter : int;
    mutable bilinear_filter : bool;
    mutable lod_bias : int;
    mutable texture : obj option;
    mutable texture_warp_u : Irr_enums.texture_clamp;
    mutable texture_warp_v : Irr_enums.texture_clamp;
    mutable trilinear_filter : bool;
    mutable matrix : Irr_core.matrix4;
  }
end*)
class material_layer : obj -> object
  method obj : obj
  method set_bilinear_filter : bool -> unit
end

(** Class SMaterial *)
(*module Material : sig
  type t = {
    mutable ambiant_color : Irr_core.color;
    mutable anti_aliasing : Irr_enums.anti_aliasing_mode;
    mutable backface_culling : bool;
    mutable color_mask : Irr_enums.color_plane;
    mutable color_material : Irr_enums.colormaterial;
    mutable diffuse_color : Irr_core.color;
    mutable emissive_color : Irr_core.color;
    mutable fog_enable : bool;
    mutable fontface_culling : bool;
    mutable shading : bool;
    mutable lighting : bool;
    mutable material_type : Irr_enums.material_type;
    mutable material_type_param : float;
    mutable material_type_param2 : float;
    mutable normalize_normals : bool;
    mutable point_cloud : bool;
    mutable shininess : float;
    mutable specular_color : Irr_core.color;
    mutable texture_layer : Material_layer.t array;
    mutable thickness : float;
    mutable wireframe : bool;
    mutable z_buffer : Irr_enums.comparison_func;
    mutable z_write_enable : bool;
  }
end*)
class material : obj -> object
  method obj : obj
  method layer : int -> material_layer
  method wireframe : bool
  method point_cloud : bool
  method material_type : Irr_enums.material_type
  method set_anti_aliasing : Irr_enums.anti_aliasing_mode -> unit
  method set_texture : int -> texture -> unit
  method set_lighting : bool -> unit
  method set_normalize_normals : bool -> unit
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
end
