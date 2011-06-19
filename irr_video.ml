type obj = Irr_base.obj

exception Rendering_failed_exn

let () = Callback.register_exception "Rendering_failed_exn" Rendering_failed_exn

(******************************************************************************)

(* Binding for class S3DVertex *)

(******************************************************************************)

module Vertex = struct
  type t =
    {color : Irr_core.color; normal : Irr_core.vector3df;
      pos : Irr_core.vector3df; t_coords : float * float}
end

(******************************************************************************)

(* Binding for class SLight *)

(******************************************************************************)

module Light = struct
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
  let cons l ?(ambient = l.ambient) ?(attenuation = l.attenuation)
    ?(cast_shadows = l.cast_shadows) ?(diffuse = l.diffuse)
    ?(direction = l.direction) ?(falloff = l.falloff)
    ?(inner_cone = l.inner_cone) ?(outer_cone = l.outer_cone) ?(pos = l.pos)
    ?(radius = l.radius) ?(specular = l.specular) ?(ty = l.ty) () =
    {ambient = ambient; attenuation = attenuation; cast_shadows = cast_shadows;
    diffuse = diffuse; direction  = direction; falloff = falloff;
    inner_cone = inner_cone; outer_cone = outer_cone; pos = pos;
    radius = radius; specular = specular; ty = ty}
end

(******************************************************************************)

(* Binding for class ITexture *)

(******************************************************************************)

external texture_get_original_size : obj -> int Irr_core.dimension_2d =
  "ml_ITexture_getOriginalSize"

class texture obj = object(self)
  inherit Irr_base.reference_counted obj
  method original_size = texture_get_original_size self#obj
end

(******************************************************************************)

(* Binding of class SMaterialLayer *)

(******************************************************************************)

external material_layer_set_bilinear_filter : obj -> bool -> unit =
  "ml_SMaterialLayer_set_BilinearFilter"

class material_layer (obj : obj) = object(self)
  val obj = obj
  method obj = obj
  method set_bilinear_filter b = material_layer_set_bilinear_filter self#obj b
end

(******************************************************************************)

(* Binding of class SMaterial *)

(******************************************************************************)

external material_texture_layer : obj -> int -> obj =
  "ml_SMaterial_TextureLayer"

external material_set_anti_aliasing :
  obj -> Irr_enums.anti_aliasing_mode -> unit =
    "ml_SMaterial_set_AntiAliasing"

external material_get_wireframe : obj -> bool = "ml_SMaterial_get_Wireframe"

external material_get_point_cloud : obj -> bool =
  "ml_SMaterial_get_PointCloud"

external material_get_material_type : obj -> Irr_enums.material_type =
  "ml_SMaterial_get_MaterialType"

external material_set_texture : obj -> int -> obj -> unit =
  "ml_SMaterial_setTexture"

external material_set_lighting : obj -> bool -> unit =
  "ml_SMaterial_set_Lighting"

external material_set_normalize_normals : obj -> bool -> unit =
  "ml_SMaterial_set_NormalizeNormals"

external material_set_wireframe : obj -> bool -> unit =
  "ml_SMaterial_set_Wireframe"

external material_create : unit -> obj =
  "ml_SMaterial_create"

external material_destroy : obj -> unit =
  "ml_SMaterial_destroy"

external material_set_ambient_color : obj -> Irr_core.color -> unit =
  "ml_SMaterial_set_AmbientColor"

external material_get_ambient_color : obj -> Irr_core.color =
  "ml_SMaterial_get_AmbientColor"

external material_get_anti_aliasing : obj -> Irr_enums.anti_aliasing_mode =
  "ml_SMaterial_get_AntiAliasing"

external material_set_backface_culling : obj -> bool -> unit =
  "ml_SMaterial_set_BackfaceCulling"

external material_get_backface_culling : obj -> bool =
  "ml_SMaterial_get_BackfaceCulling"

external material_set_flag : obj -> Irr_enums.material_flag -> bool -> unit =
  "ml_SMaterial_setFlag"

external material_get_flag : obj -> Irr_enums.material_flag -> bool =
  "ml_SMaterial_getFlag"

external material_set_specular_color : obj -> Irr_core.color -> unit =
  "ml_SMaterial_set_SpecularColor"

external material_set_color_mask : obj -> Irr_enums.color_plane -> unit =
  "ml_SMaterial_set_ColorMask"

external material_get_color_mask : obj -> Irr_enums.color_plane =
  "ml_SMaterial_get_ColorMask"

external material_set_color_material : obj -> Irr_enums.colormaterial -> unit =
  "ml_SMaterial_set_ColorMaterial"

external material_get_color_material : obj -> Irr_enums.colormaterial =
  "ml_SMaterial_get_ColorMaterial"

external material_set_diffuse_color : obj -> Irr_core.color -> unit =
  "ml_SMaterial_set_DiffuseColor"

external material_get_diffuse_color : obj -> Irr_core.color =
  "ml_SMaterial_get_DiffuseColor"

external material_set_emissive_color : obj -> Irr_core.color -> unit =
  "ml_SMaterial_set_EmissiveColor"

external material_get_emissive_color : obj -> Irr_core.color =
  "ml_SMaterial_get_EmissiveColor"

external material_get_fog_enable : obj -> bool = "ml_SMaterial_get_FogEnable"

external material_set_fog_enable : obj -> bool -> unit =
  "ml_SMaterial_set_FogEnable"

external material_set_material_type : obj -> Irr_enums.material_type -> unit =
  "ml_SMaterial_set_MaterialType"

external material_get_shininess : obj -> float = "ml_SMaterial_get_Shininess"

external material_set_shininess : obj -> float -> unit =
  "ml_SMaterial_set_Shininess"

external material_get_specular_color : obj -> Irr_core.color =
  "ml_SMaterial_get_SpecularColor"

external material_get_thickness : obj -> float = "ml_SMaterial_get_Thickness"

external material_set_thickness : obj -> float -> unit =
  "ml_SMaterial_set_Thickness"

let free x = material_destroy x#obj

class material (obj : obj) = object(self)
  val obj = obj
  method obj = obj
  method layer i =
    let obj = material_texture_layer self#obj i in
    object
      val mat = self
      inherit material_layer obj
    end
  method wireframe = material_get_wireframe self#obj
  method point_cloud = material_get_point_cloud self#obj
  method material_type = material_get_material_type self#obj
  method ambient_color = material_get_ambient_color self#obj
  method anti_aliasing = material_get_anti_aliasing self#obj
  method backface_culling = material_get_backface_culling self#obj
  method color_mask = material_get_color_mask self#obj
  method color_material = material_get_color_material self#obj
  method diffuse_color = material_get_diffuse_color self#obj
  method emissive_color = material_get_emissive_color self#obj
  method fog_enable = material_get_fog_enable self#obj
  method shininess = material_get_shininess self#obj
  method specular_color = material_get_specular_color self#obj
  method thickness = material_get_thickness self#obj
  method flag f = material_get_flag self#obj f
  method set_anti_aliasing m = material_set_anti_aliasing self#obj m
  method set_texture i (t : texture) =
    material_set_texture self#obj i t#obj
  method set_lighting flag = material_set_lighting self#obj flag
  method set_normalize_normals flag =
    material_set_normalize_normals self#obj flag
  method set_wireframe flag = material_set_wireframe self#obj flag
  method set_ambient_color c = material_set_ambient_color self#obj c
  method set_backface_culling b = material_set_backface_culling self#obj b
  method set_color_mask m = material_set_color_mask self#obj m
  method set_color_material cm = material_set_color_material self#obj cm
  method set_diffuse_color c = material_set_diffuse_color self#obj c
  method set_emissive_color c = material_set_emissive_color self#obj c
  method set_fog_enable b = material_set_fog_enable self#obj b
  method set_material_type mt = material_set_material_type self#obj mt
  method set_shininess x = material_set_shininess self#obj x
  method set_flag flag b = material_set_flag self#obj flag b
  method set_specular_color c = material_set_specular_color self#obj c
  method set_thickness x = material_set_thickness self#obj x
end

class material_fresh = object(self)
  inherit material (material_create ())
  initializer Gc.finalise free self
end

(******************************************************************************)

(* Binding of class IVideoDriver *)

(******************************************************************************)

external driver_begin_scene : obj -> bool -> bool -> Irr_core.color -> unit =
  "ml_IVideoDriver_beginScene"

external driver_end_scene : obj -> unit = "ml_IVideoDriver_endScene"

external driver_draw_2d_image :
  obj -> obj -> int Irr_core.dimension_2d -> int Irr_core.rect ->
    (int Irr_core.rect) option -> Irr_core.color -> bool -> unit =
      "ml_IVideoDriver_draw2DImage_bytecode"
      "ml_IVideoDriver_draw2DImage_native"

external driver_draw_2d_image_scale :
  obj -> obj -> int Irr_core.rect -> int Irr_core.rect ->
  (int Irr_core.rect) option ->
  (Irr_core.color * Irr_core.color * Irr_core.color * Irr_core.color) option ->
  bool -> unit =
    "ml_IVideoDriver_draw2DImage_scale_bytecode"
    "ml_IVideoDriver_draw2DImage_scale_native"

external driver_draw_2d_rectangle :
  obj -> Irr_core.color -> int Irr_core.rect -> (int Irr_core.rect) option ->
    unit =
      "ml_IVideoDriver_draw2DRectangle"

external driver_get_texture : obj -> string -> obj =
  "ml_IVideoDriver_getTexture"

external driver_get_fps : obj -> int = "ml_IVideoDriver_getFPS"

external driver_get_name : obj -> string = "ml_IVideoDriver_getName"

external driver_get_material_2d : obj -> obj =
  "ml_IVideoDriver_getMaterial2D"

external driver_make_color_key_from_px :
  obj -> obj -> int Irr_core.pos_2d -> bool -> unit =
    "ml_IVideoDriver_makeColorKeyTexture1"

external driver_enable_material_2d : obj -> bool -> unit =
  "ml_IVideoDriver_enableMaterial2D"

external driver_set_texture_creation_flag :
  obj -> Irr_enums.texture_creation_flag -> bool -> unit =
    "ml_IVideoDriver_setTextureCreationFlag"

external driver_set_transform :
  obj -> Irr_enums.transformation_state -> Irr_core.matrix4 -> unit =
    "ml_IVideoDriver_setTransform"

external driver_draw_3d_triangle :
  obj -> Irr_core.triangle3df -> Irr_core.color -> unit =
    "ml_IVideoDriver_draw3DTriangle"

external driver_set_material : obj -> obj -> unit =
  "ml_IVideoDriver_setMaterial"

external driver_get_maximal_primitive_count : obj -> int =
  "ml_IVideoDriver_getMaximalPrimitiveCount"

class driver obj = object(self)
  inherit Irr_base.reference_counted obj
  method begin_scene ?(backbuffer = true) ?(zbuffer = true)
    ?(color = Irr_core.color_ARGB 255 0 0 0) () =
    driver_begin_scene self#obj backbuffer zbuffer color
  method end_scene = driver_end_scene self#obj
  method draw_2d_image (tex : texture)
  ?(src = let w, h = tex#original_size in (0, 0, w, h)) ?clip
    ?(color = Irr_core.color_ARGB 255 255 255 255) ?(alpha = false) dst =
    driver_draw_2d_image self#obj tex#obj dst src clip color alpha
  method draw_2d_rect color ?clip pos =
    driver_draw_2d_rectangle self#obj color pos clip
  method draw_2d_image_scale (tex: texture)
    ?(src = let w, h = tex#original_size in (0, 0, w, h)) ?clip ?colors
    ?(alpha = false) dst =
    driver_draw_2d_image_scale self#obj tex#obj dst src clip colors alpha
  method get_texture filename =
    let obj = driver_get_texture self#obj filename in
    object
      val driver = self
      inherit texture obj
    end
  method material_2d =
    let obj = driver_get_material_2d self#obj in
    object
      val driver = self
      inherit material obj
    end
  method enable_material_2d = driver_enable_material_2d self#obj true
  method disable_material_2d = driver_enable_material_2d self#obj false
  method make_color_key_from_px (tex : texture) ?(zero_texels = false) pos =
    driver_make_color_key_from_px self#obj tex#obj pos zero_texels
  method fps = driver_get_fps self#obj
  method name =
    String.copy (driver_get_name self#obj)
  method set_texture_creation_flag flag b =
    driver_set_texture_creation_flag self#obj flag b
  method set_transform state mat = driver_set_transform self#obj state mat
  method draw_3d_triangle t c = driver_draw_3d_triangle self#obj t c
  method set_material (m : material) = driver_set_material self#obj m#obj
  method max_prim_count = driver_get_maximal_primitive_count self#obj
end
