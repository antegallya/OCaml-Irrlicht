(** Implements some parts of the namespace irr:scene *)

type obj = Irr_base.obj

exception MD2_animation_exn

(** Class ISceneNodeAnimator *)
class animator : obj -> object
  inherit Irr_base.attribute_exchanging_object
  inherit Irr_base.event_receiver
end

(** Class ISceneNodeAnimatorCollisionResponse *)
class animator_collision_response : obj -> object
  inherit animator
end

(** Class ITriangleSelector *)
class triangle_selector : obj -> object
  inherit Irr_base.reference_counted
end

(** Class ISceneNode *)
class node : obj -> object
  inherit Irr_base.attribute_exchanging_object
  method pos : Irr_core.vector3df
  method id : int
  method material : int -> Irr_video.material
  method add_animator : animator -> unit
  method add_child : node -> unit
  method automatic_culling : Irr_enums.culling_type
  method clone : ?parent:node -> unit -> node
  method set_material_flag : Irr_enums.material_flag -> bool -> unit
  method set_material_texture : ?layer:int -> Irr_video.texture -> unit
  method set_material_type : Irr_enums.material_type -> unit
  method set_pos : Irr_core.vector3df -> unit
  method set_rot : Irr_core.vector3df -> unit
  method set_scale : Irr_core.vector3df -> unit
  method set_triangle_selector : triangle_selector -> unit
  method set_visible : bool -> unit
  method set_id : int -> unit
  method abs_pos : Irr_core.vector3df
end

(** Class ICameraSceneNode *)
class camera : obj -> object
  inherit node
  inherit Irr_base.event_receiver
  method target : Irr_core.vector3df
  method set_far_value : float -> unit
  method set_target : Irr_core.vector3df -> unit
end

(** Class IMesh *)
class mesh : obj -> object
  inherit Irr_base.reference_counted
end

(** Class IAnimatedMesh *)
class animated_mesh : obj -> object
  inherit mesh
  method mesh : ?detail_lv:int -> ?start:int -> ?ends:int -> int -> mesh
end

(** Class IMeshSceneNode *)
class mesh_node : obj -> object
  inherit node
  method mesh : mesh
end

(** Class IAnimatedMeshSceneNode *)
class animated_mesh_node : obj -> object
  inherit node
  method set_animation_speed : float -> unit
  method set_frame_loop_bool : int -> int -> bool
  method set_frame_loop : int -> int -> unit
  method set_md2_animation : Irr_enums.md2_animation_type -> unit
end

(** Class ITerrainSceneNode *)
class terrain_node : obj -> object
  inherit node
  method scale_texture : float -> float -> unit
  method height : float -> float -> float
end

(** Class IBillboardSceneNode *)
class billboard_node : obj -> object
  inherit node
  method set_size : (float * float) -> unit
end

(** Class ISceneCollisionManager *)
class collision_manager : obj -> object
  inherit Irr_base.reference_counted
  method node_and_point_from_ray :
    ?id:int -> ?root:node -> ?no_debug_object:bool -> Irr_core.line3df ->
      (node * Irr_core.vector3df * Irr_core.triangle3df) option
end

(** Class ILightSceneNode *)
class light_node : obj -> object
  inherit node
end

(** Class ISceneManager *)
class manager : obj -> object
  inherit Irr_base.reference_counted
  method add_animated_mesh_node :
    ?parent:node -> ?id:int -> ?pos:Irr_core.vector3df ->
      ?rot:Irr_core.vector3df -> ?scale:Irr_core.vector3df -> animated_mesh ->
      animated_mesh_node
  method add_camera :
    ?parent:node -> ?pos:Irr_core.vector3df -> ?lookat:Irr_core.vector3df ->
      ?id:int -> ?make_active:bool -> unit -> camera
  method add_camera_fps :
    ?parent:node -> ?rs:float -> ?ms:float -> ?id:int ->
      ?km:Irr_base.key_map list -> ?nvm:bool -> ?js:float -> ?im:bool ->
      ?ma:bool -> unit -> camera
  method add_cube_node :
    ?size:float -> ?parent:node -> ?id:int -> ?pos:Irr_core.vector3df ->
      ?rot:Irr_core.vector3df -> ?scale:Irr_core.vector3df -> unit -> mesh_node
  method add_mesh_node :
    ?parent:node -> ?id:int -> ?pos:Irr_core.vector3df ->
      ?rot:Irr_core.vector3df -> ?scale:Irr_core.vector3df -> mesh -> mesh_node
  method add_octree_node :
    ?parent:node -> ?id:int -> ?min:int -> mesh -> mesh_node
  method add_sphere_node :
    ?radius:float -> ?poly_count:int -> ?parent:node -> ?id:int ->
      ?pos:Irr_core.vector3df -> ?rot:Irr_core.vector3df ->
        ?scale:Irr_core.vector3df -> unit -> mesh_node
  method add_terrain_node :
    ?parent:node -> ?id:int -> ?pos:Irr_core.vector3df ->
      ?rot:Irr_core.vector3df -> ?scale:Irr_core.vector3df ->
      ?color:Irr_core.color -> ?max_lod:int ->
      ?patch_size:Irr_enums.terrain_patch_size -> ?smooth_factor:int ->
      ?add_also_if_heightmap_empty:bool -> string -> terrain_node
  method add_sky_box_node :
    top:Irr_video.texture -> bottom:Irr_video.texture ->
      left:Irr_video.texture -> right:Irr_video.texture ->
      front:Irr_video.texture -> back:Irr_video.texture ->
      ?parent:node -> ?id:int -> unit -> node
  method add_sky_dome_node :
    ?hori_res:int -> ?vert_res:int -> ?texture_percentage:float ->
      ?sphere_percentage:float -> ?radius:float -> ?parent:node -> ?id:int ->
      Irr_video.texture -> node
  method add_billboard_node :
    ?parent:node -> ?size:(float * float) -> ?pos:Irr_core.vector3df ->
      ?id:int -> ?color_top:Irr_core.color -> ?color_bottom:Irr_core.color ->
      unit -> billboard_node
  method add_light_node :
    ?parent:node -> ?pos:Irr_core.vector3df -> ?color:Irr_core.colorf ->
      ?radius:float -> ?id:int -> unit -> light_node
  method create_fly_circle :
    ?center:Irr_core.vector3df -> ?radius:float -> ?speed:float ->
      ?dir:Irr_core.vector3df -> ?start:float -> ?radius_ellipsoid:float ->
        unit -> animator
  method create_fly_straight :
    Irr_core.vector3df -> Irr_core.vector3df -> ?loop:bool -> ?pingpong:bool ->
      int -> animator
  method create_terrain_triangle_selector :
    ?lod:int -> terrain_node -> triangle_selector
  method create_octree_triangle_selector :
    mesh -> ?mppn:int -> node -> triangle_selector
  method create_collision_response_animator :
    triangle_selector -> ?ellipsoid_radius:Irr_core.vector3df ->
      ?gravity_per_second:Irr_core.vector3df ->
      ?ellipsoid_translation:Irr_core.vector3df -> ?sliding:float ->
      node -> animator_collision_response
  method create_triangle_selector : animated_mesh_node -> triangle_selector
  method draw_all : unit
  method get_mesh : string -> animated_mesh
  method collision_manager : collision_manager
end