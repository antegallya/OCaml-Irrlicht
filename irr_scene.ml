type obj = Irr_base.obj

(******************************************************************************)

(* Binding for class ISceneNodeAnimator *)

(******************************************************************************)

class animator obj = object
  inherit Irr_base.attribute_exchanging_object obj
  inherit Irr_base.event_receiver obj
end

(******************************************************************************)

(* Binding for class ISceneNodeAnimatorCollisionResponse *)

(******************************************************************************)

class animator_collision_response obj = object
  inherit animator obj
end

(******************************************************************************)

(* Binding for class ITriangleSelector *)

(******************************************************************************)

class triangle_selector obj = object(self)
  inherit Irr_base.reference_counted obj
end

(******************************************************************************)

(* Binding for class ISceneNode *)

(******************************************************************************)

external node_get_position : obj -> Irr_core.vector3df =
  "ml_ISceneNode_getPosition"

external node_add_animator : obj -> obj -> unit =
  "ml_ISceneNode_addAnimator"

external node_set_material_flag :
  obj -> Irr_enums.material_flag -> bool -> unit =
    "ml_ISceneNode_setMaterialFlag"

external node_set_material_texture : obj -> int -> obj -> unit =
  "ml_ISceneNode_setMaterialTexture"

external node_set_material_type : obj -> Irr_enums.material_type -> unit =
  "ml_ISceneNode_setMaterialType"

external node_set_position : obj -> Irr_core.vector3df -> unit =
  "ml_ISceneNode_setPosition"

external node_set_rotation : obj -> Irr_core.vector3df -> unit =
  "ml_ISceneNode_setRotation"

external node_set_scale : obj -> Irr_core.vector3df -> unit =
  "ml_ISceneNode_setScale"

external node_set_triangle_selector : obj -> obj -> unit =
  "ml_ISceneNode_setTriangleSelector"

external node_set_visible : obj -> bool -> unit =
  "ml_ISceneNode_setVisible"

external node_get_absolute_position : obj -> Irr_core.vector3df =
  "ml_ISceneNode_getAbsolutePosition"

external node_get_material : obj -> int -> obj =
  "ml_ISceneNode_getMaterial"

external node_set_id : obj -> int -> unit = "ml_ISceneNode_setID"

external node_get_id : obj -> int = "ml_ISceneNode_getID"

external node_add_child : obj -> obj -> unit = "ml_ISceneNode_addChild"

external node_clone : obj -> obj option -> obj = "ml_ISceneNode_clone"

external node_get_automatic_culling : obj -> Irr_enums.culling_type =
  "ml_ISceneNode_getAutomaticCulling"

external node_get_bounding_box : obj -> float Irr_core.aabbox3d =
  "ml_ISceneNode_getBoundingBox"

external node_get_material_count : obj -> int =
  "ml_ISceneNode_getMaterialCount"

external node_get_name : obj -> string = "ml_ISceneNode_getName"

external node_set_automatic_culling : obj -> Irr_enums.culling_type -> unit =
  "ml_ISceneNode_setAutomaticCulling"

external node_get_rotation : obj -> Irr_core.vector3df =
  "ml_ISceneNode_getRotation"

external node_get_scale : obj -> Irr_core.vector3df =
  "ml_ISceneNode_getScale"

external node_get_type : obj -> Irr_enums.node_type =
  "ml_ISceneNode_getType"

external node_is_truly_visible : obj -> bool = "ml_ISceneNode_isTrulyVisible"

external node_is_visible : obj -> bool = "ml_ISceneNode_isVisible"

external node_set_name : obj -> string -> unit = "ml_ISceneNode_setName"

class node obj = object(self)
  inherit Irr_base.attribute_exchanging_object obj
  method pos = node_get_position self#obj
  method rot = node_get_rotation self#obj
  method scale = node_get_scale self#obj
  method material i =
    let obj = node_get_material self#obj i in
    object
      val node = self
      inherit Irr_video.material obj
    end
  method add_animator (anim : animator) = node_add_animator self#obj anim#obj
  method add_child (node : node) = node_add_child self#obj node#obj
  method clone ?parent () =
    let p = match parent with None -> None | Some (x : node) -> Some x#obj in
    let obj = node_clone self#obj p in
    new node obj
  method automatic_culling = node_get_automatic_culling self#obj
  method bounding_box = node_get_bounding_box self#obj
  method material_count = node_get_material_count self#obj
  method name = node_get_name self#obj
  method get_type = node_get_type self#obj
  method is_truly_visible = node_is_truly_visible self#obj
  method is_visible = node_is_visible self#obj
  method set_automatic_culling t = node_set_automatic_culling self#obj t
  method set_name name = node_set_name self#obj name
  method set_material_flag flag b =
    node_set_material_flag self#obj flag b
  method set_material_texture ?(layer = 0) (tex : Irr_video.texture) =
    node_set_material_texture self#obj layer tex#obj
  method set_material_type t = node_set_material_type self#obj t 
  method set_pos pos = node_set_position self#obj pos
  method set_rot rot = node_set_rotation self#obj rot
  method set_scale scale = node_set_scale self#obj scale
  method set_triangle_selector (ts : triangle_selector) =
    node_set_triangle_selector self#obj ts#obj
  method set_visible b = node_set_visible self#obj b
  method set_id n = node_set_id self#obj n
  method abs_pos = node_get_absolute_position self#obj
  method id = node_get_id self#obj
end

(******************************************************************************)

(* Binding for class ICameraSceneNode *)

(******************************************************************************)

external camera_set_far_value : obj -> float -> unit =
  "ml_ICameraSceneNode_setFarValue"

external camera_set_target : obj -> Irr_core.vector3df -> unit =
  "ml_ICameraSceneNode_setTarget"

external camera_get_target : obj -> Irr_core.vector3df =
  "ml_ICameraSceneNode_getTarget"

class camera obj = object(self)
  inherit node obj
  inherit Irr_base.event_receiver obj
  method target = camera_get_target self#obj
  method set_far_value x = camera_set_far_value self#obj x
  method set_target pos = camera_set_target self#obj pos
end

(******************************************************************************)

(* Binding for class IMeshBuffer *)

(******************************************************************************)

class mesh_buffer obj = object(self)
  inherit Irr_base.reference_counted obj
end

(******************************************************************************)

(* Binding for class IMesh *)

(******************************************************************************)

external mesh_create : unit -> obj = "ml_SMesh_create"

external mesh_destroy : obj -> unit = "ml_SMesh_destroy"

let free x = mesh_destroy x#obj

class mesh obj = object(self)
  inherit Irr_base.reference_counted obj
end

class fresh_mesh = object(self)
  inherit mesh (mesh_create ())
  initializer Gc.finalise free self
end

(******************************************************************************)

(* Binding for class IAnimatedMesh *)

(******************************************************************************)

external animated_mesh_get_mesh : obj -> int -> int -> int -> int -> obj =
  "ml_IAnimatedMesh_getMesh"

class animated_mesh obj = object(self)
  inherit mesh obj
  method mesh ?(detail_lv = 255) ?(start = -1)
    ?(ends = -1) frame =
    let obj = animated_mesh_get_mesh self#obj frame detail_lv start ends in
    object
      val p = self
      inherit mesh obj
    end 
end

(******************************************************************************)

(* Binding for class IMeshSceneNode *)

(******************************************************************************)

external mesh_node_get_mesh : obj -> obj =
  "ml_IMeshSceneNode_getMesh"

class mesh_node obj = object(self)
  inherit node obj
  method mesh =
    let obj = mesh_node_get_mesh self#obj in
    object
      val node = self
      inherit mesh obj
    end
end

(******************************************************************************)

(* Binding for class IShadowVolumeSceneNode *)

(******************************************************************************)

class shadow_volume_node obj = object(self)
  inherit node obj
end

(******************************************************************************)

(* Binding for class IAnimatedMeshSceneNode *)

(******************************************************************************)

exception MD2_animation_exn

external animated_mesh_node_set_animation_speed : obj -> float -> unit =
  "ml_IAnimatedMeshSceneNode_setAnimationSpeed"

external animated_mesh_node_set_frame_loop : obj -> int -> int -> bool =
  "ml_IAnimatedMeshSceneNode_setFrameLoop"

external animated_mesh_node_set_md2_animation :
  obj -> Irr_enums.md2_animation_type -> bool =
    "ml_IAnimatedMeshSceneNode_setMD2Animation"

external animated_mesh_node_add_shadow_volume_scene_node :
  obj -> obj option -> int -> bool -> float -> obj =
    "ml_IAnimatedMeshSceneNode_addShadowVolumeSceneNode"

class animated_mesh_node obj = object(self)
  inherit node obj
  method set_animation_speed x =
    animated_mesh_node_set_animation_speed self#obj x
  method set_frame_loop_bool b e =
    animated_mesh_node_set_frame_loop self#obj b e
  method set_frame_loop b e = ignore (self#set_frame_loop_bool b e)
  method set_md2_animation t =
    if not (animated_mesh_node_set_md2_animation self#obj t) then
      raise MD2_animation_exn
  method add_shadow_volume_node ?mesh ?(id = -1) ?(zfail_method = true)
    ?(infinity = 10000.) () =
    let m = match mesh with None -> None | Some (x : mesh) -> Some x#obj in
    let obj = animated_mesh_node_add_shadow_volume_scene_node
      self#obj m id zfail_method infinity in
    object
      inherit shadow_volume_node obj
      val smgr = self
    end
end

(******************************************************************************)

(* Binding for class ITerrainSceneNode *)

(******************************************************************************)

external terrain_node_scale_texture : obj -> float -> float -> unit =
  "ml_ITerrainSceneNode_scaleTexture"

external terrain_node_get_height : obj -> float -> float -> float =
  "ml_ITerrainSceneNode_getHeight"

class terrain_node obj = object(self)
  inherit node obj
  method scale_texture x y = terrain_node_scale_texture self#obj x y
  method height x y = terrain_node_get_height self#obj x y
end

(******************************************************************************)

(* Binding for class IBillboardSceneNode *)

(******************************************************************************)

external billboard_node_set_size : obj -> (float * float) -> unit =
  "ml_IBillboardSceneNode_setSize"

external billboard_node_get_size : obj -> (float * float) =
  "ml_IBillboardSceneNode_getSize"

external billboard_node_set_color :
  obj -> Irr_core.color -> Irr_core.color -> unit =
    "ml_IBillboardSceneNode_setColor"

external billboard_node_get_color : obj -> Irr_core.color * Irr_core.color =
  "ml_IBillboardSceneNode_getColor"

class billboard_node obj = object(self)
  inherit node obj
  method set_size d = billboard_node_set_size self#obj d
  method size = billboard_node_get_size self#obj
  method set_color c_top c_bot = billboard_node_set_color self#obj c_top c_bot
  method color = billboard_node_get_color self#obj
end

(******************************************************************************)

(* Binding for class ISceneCollisionManager *)

(******************************************************************************)

external collision_manager_get_scene_node_and_collision_point_from_ray :
  obj -> Irr_core.line3df -> int -> obj option -> bool ->
    (obj * Irr_core.vector3df * Irr_core.triangle3df) option
  = "ml_ISceneCollisionManager_getSceneNodeAndCollisionPointFromRay"

class collision_manager obj = object(self)
  inherit Irr_base.reference_counted obj
  method node_and_point_from_ray ?(id = 0) ?root ?(no_debug_object = false)
    ray =
    let root1 = match root with Some (x : node) -> Some x#obj | None -> None in
    let r = collision_manager_get_scene_node_and_collision_point_from_ray
      self#obj ray id root1 no_debug_object in
    match r with
    | None -> None
    | Some(obj, p, t) ->
        let node = object
          val coll_man = self
          inherit node obj end in
        Some(node, p, t)
end

(******************************************************************************)

(* Binding for class ILightSceneNode *)

(******************************************************************************)

class light_node obj = object(self)
  inherit node obj
end

(******************************************************************************)

(* Binding for class IVolumeLightSceneNode *)

(******************************************************************************)

class volume_light_node obj = object(self)
  inherit node obj
end

(******************************************************************************)

(* Binding for class IParticleEmitter *)

(******************************************************************************)

class particle_emitter obj = object(self)
  inherit Irr_base.attribute_exchanging_object obj
end

(******************************************************************************)

(* Binding for class IParticleBoxEmitter *)

(******************************************************************************)

class particle_box_emitter obj = object(self)
  inherit particle_emitter obj
end

(******************************************************************************)

(* Binding for class IParticleAffector *)

(******************************************************************************)

class particle_affector obj = object(self)
  inherit Irr_base.attribute_exchanging_object obj
end

(******************************************************************************)

(* Binding for class IParticleFadeOutAffector *)

(******************************************************************************)

class particle_fade_out_affector obj = object(self)
  inherit particle_affector obj
end

(******************************************************************************)

(* Binding for class IParticleSystemSceneNode *)

(******************************************************************************)

external particle_system_node_create_box_emitter :
  obj -> float Irr_core.aabbox3d -> Irr_core.vector3df -> int -> int ->
    Irr_core.color -> Irr_core.color -> int -> int -> int -> (float * float) ->
    (float * float) -> obj
  =
    "ml_IParticleSystemSceneNode_createBoxEmitter_bytecode"
    "ml_IParticleSystemSceneNode_createBoxEmitter_native"

external particle_system_node_set_emitter : obj -> obj -> unit =
  "ml_IParticleSystemSceneNode_setEmitter"

external particle_system_node_create_fade_out_particle_affector :
  obj -> Irr_core.color -> int -> obj =
    "ml_IParticleSystemSceneNode_createFadeOutParticleAffector"

external particle_system_node_add_affector : obj -> obj -> unit =
  "ml_IParticleSystemSceneNode_addAffector"

let free x = x#drop

class particle_system_node obj = object(self)
  inherit node obj
  method create_box_emitter ?(box = ((-10., 28., -10.), (10., 30., 10.)))
    ?(direction = (0., 0.03, 0.)) ?(min_particles_per_second = 5)
    ?(max_particles_per_second = 10)
    ?(min_start_color = Irr_core.color_ARGB 255 0 0 0)
    ?(max_start_color = Irr_core.color_ARGB 255 255 255 255)
    ?(life_time_min = 2000) ?(life_time_max = 4000) ?(max_angle_degrees = 0)
    ?(min_start_size = (5., 5.)) ?(max_start_size = (5., 5.)) () =
    let obj = particle_system_node_create_box_emitter self#obj box direction
      min_particles_per_second max_particles_per_second
      min_start_color max_start_color life_time_min life_time_max
      max_angle_degrees min_start_size max_start_size in
    object(self1)
      inherit particle_box_emitter obj
      initializer Gc.finalise free self1
    end
  method set_emitter (emitter : particle_emitter) =
    particle_system_node_set_emitter self#obj emitter#obj
  method create_fade_out_affector ?(color = Irr_core.color_ARGB 0 0 0 0)
    ?(time = 1000) () =
    let obj = particle_system_node_create_fade_out_particle_affector self#obj
      color time in
    object(self1)
      inherit particle_fade_out_affector obj
      initializer Gc.finalise free self1
    end
  method add_affector (affector : particle_affector) =
    particle_system_node_add_affector self#obj affector#obj
end

(******************************************************************************)

(** Binding for the class ISceneManager *)

(******************************************************************************)

external manager_add_animated_mesh_scene_node :
  obj -> obj -> obj option -> int -> Irr_core.vector3df ->
    Irr_core.vector3df-> Irr_core.vector3df -> obj =
  "ml_ISceneManager_addAnimatedMeshSceneNode_bytecode"
  "ml_ISceneManager_addAnimatedMeshSceneNode_native"

external manager_add_camera_scene_node :
  obj -> obj option -> Irr_core.vector3df -> Irr_core.vector3df -> int ->
    bool -> obj =
  "ml_ISceneManager_addCameraSceneNode_bytecode"
  "ml_ISceneManager_addCameraSceneNode_native"

external manager_add_camera_scene_node_fps :
  obj -> obj option -> float -> float -> int -> Irr_base.key_map list -> int ->
    bool -> float -> bool -> bool -> obj =
  "ml_ISceneManager_addCameraSceneNodeFPS_bytecode"
  "ml_ISceneManager_addCameraSceneNodeFPS_native"

external manager_add_cube_scene_node :
  obj -> float -> obj option -> int -> Irr_core.vector3df ->
    Irr_core.vector3df -> Irr_core.vector3df -> obj =
      "ml_ISceneManager_addCubeSceneNode_bytecode"
      "ml_ISceneManager_addCubeSceneNode_native"

external manager_add_mesh_scene_node :
  obj -> obj -> obj option -> int -> Irr_core.vector3df -> Irr_core.vector3df ->
    Irr_core.vector3df -> obj =
      "ml_ISceneManager_addMeshSceneNode_bytecode"
      "ml_ISceneManager_addMeshSceneNode_native"

external manager_add_octree_scene_node :
  obj -> obj -> obj option -> int -> int -> obj =
    "ml_ISceneManager_addOctreeSceneNode"

external manager_add_sphere_scene_node :
  obj -> float -> int -> obj option -> int -> Irr_core.vector3df ->
    Irr_core.vector3df -> Irr_core.vector3df -> obj =
      "ml_ISceneManager_addSphereSceneNode_bytecode"
      "ml_ISceneManager_addSphereSceneNode_native"

external manager_add_sky_box_scene_node :
  obj -> obj -> obj -> obj -> obj -> obj -> obj -> obj option -> int -> obj =
    "ml_ISceneManager_addSkyBoxSceneNode_bytecode"
    "ml_ISceneManager_addSkyBoxSceneNode_native"

external manager_add_sky_dome_scene_node :
  obj -> obj -> int -> int -> float -> float -> float -> obj option -> int ->
    obj
  =
    "ml_ISceneManager_addSkyDomeSceneNode_bytecode"
    "ml_ISceneManager_addSkyDomeSceneNode_native"

external manager_add_billboard_scene_node :
  obj -> obj option -> float Irr_core.dimension_2d -> Irr_core.vector3df ->
    int -> Irr_core.color -> Irr_core.color -> obj
  =
    "ml_ISceneManager_addBillboardSceneNode_bytecode"
    "ml_ISceneManager_addBillboardSceneNode_native"

external manager_create_fly_circle_animator :
  obj -> Irr_core.vector3df -> float -> float -> Irr_core.vector3df -> float ->
    float -> obj =
      "ml_ISceneManager_createFlyCircleAnimator_bytecode"
      "ml_ISceneManager_createFlyCircleAnimator_native"

external manager_create_fly_straight_animator :
  obj -> Irr_core.vector3df -> Irr_core.vector3df -> int -> bool -> bool ->
    obj =
      "ml_ISceneManager_createFlyStraightAnimator_bytecode"
      "ml_ISceneManager_createFlyStraightAnimator_native"

external manager_draw_all : obj -> unit = "ml_ISceneManager_drawAll"

external manager_get_mesh : obj -> string -> obj = "ml_ISceneManager_getMesh"

external manager_add_terrain_scene_node :
  obj -> string -> obj option -> int -> Irr_core.vector3df ->
    Irr_core.vector3df -> Irr_core.vector3df -> Irr_core.color -> int ->
    Irr_enums.terrain_patch_size -> int -> bool -> obj
  =
    "ml_ISceneManager_addTerrainSceneNode_bytecode"
    "ml_ISceneManager_addTerrainSceneNode_native"

external manager_create_terrain_triangle_selector : obj -> obj -> int -> obj =
  "ml_ISceneManager_createTerrainTriangleSelector"

external manager_create_collision_response_animator :
  obj -> obj -> obj -> Irr_core.vector3df -> Irr_core.vector3df ->
    Irr_core.vector3df -> float -> obj
  =
    "ml_ISceneManager_createCollisionResponseAnimator_bytecode"
    "ml_ISceneManager_createCollisionResponseAnimator_native"

external manager_create_octree_triangle_selector :
  obj -> obj -> obj -> int -> obj =
    "ml_ISceneManager_createOctreeTriangleSelector"

external manager_get_scene_collision_manager : obj -> obj =
  "ml_ISceneManager_getSceneCollisionManager"

external manager_create_triangle_selector : obj -> obj -> obj =
  "ml_ISceneManager_createTriangleSelector"

external manager_add_light_scene_node :
  obj -> obj option -> Irr_core.vector3df -> Irr_core.colorf -> float -> int ->
    obj
  =
    "ml_ISceneManager_addLightSceneNode_bytecode"
    "ml_ISceneManager_addLightSceneNode_native"

external manager_add_hill_plane_mesh :
  obj -> string -> (float * float) -> (int * int) -> obj option -> float ->
    (float * float) -> (float * float) -> obj
  =
    "ml_ISceneManager_addHillPlaneMesh_bytecode"
    "ml_ISceneManager_addHillPlaneMesh_native"

external manager_add_water_surface_scene_node :
  obj -> obj -> float -> float -> float -> obj option -> int ->
    Irr_core.vector3df -> Irr_core.vector3df -> Irr_core.vector3df -> obj
  =
    "ml_ISceneManager_addWaterSurfaceSceneNode_bytecode"
    "ml_ISceneManager_addWaterSurfaceSceneNode_native"

external manager_add_particle_system_scene_node :
  obj -> bool -> obj option -> int -> Irr_core.vector3df ->
    Irr_core.vector3df -> Irr_core.vector3df -> obj
  =
    "ml_ISceneManager_addParticleSystemSceneNode_bytecode"
    "ml_ISceneManager_addParticleSystemSceneNode_native"

external manager_add_volume_light_scene_node :
  obj -> obj option -> int -> int -> int -> Irr_core.color -> Irr_core.color ->
    Irr_core.vector3df -> Irr_core.vector3df -> Irr_core.vector3df -> obj
  =
    "ml_ISceneManager_addVolumeLightSceneNode_bytecode"
    "ml_ISceneManager_addVolumeLightSceneNode_native"

external manager_create_texture_animator :
  obj -> obj list -> int -> bool -> obj =
    "ml_ISceneManager_createTextureAnimator"

external manager_set_shadow_color : obj -> Irr_core.color -> unit =
  "ml_ISceneManager_setShadowColor"

let free x = x#drop

class manager obj = object(self)
  inherit Irr_base.reference_counted obj
  method add_animated_mesh_node ?parent ?(id = -1)
    ?(pos = (0., 0., 0.)) ?(rot = (0., 0., 0.)) ?(scale = (1., 1., 1.))
      (mesh : animated_mesh)
    =
    let p = match parent with
    | None -> None
    | Some (x : node) -> Some x#obj in
    let obj = manager_add_animated_mesh_scene_node self#obj mesh#obj p id pos
      rot scale in
    object
      val smgr = self
      inherit animated_mesh_node obj
    end
  method add_camera ?parent ?(pos = (0., 0., 0.))  ?(lookat = (0., 0., 100.))
    ?(id = -1) ?(make_active = true) () =
    let p = match parent with
    | None -> None
    | Some (x : node) -> Some x#obj in
    let obj = manager_add_camera_scene_node self#obj p pos lookat id
      make_active in
    object
      val smgr = self
      inherit camera obj
    end
  method add_camera_fps ?parent ?(rs = 100.) ?(ms = 0.5) ?(id = -1)
    ?(km = []) ?(nvm = false) ?(js = 0.) ?(im = false) ?(ma = true) () =
    let p = match parent with
    | None -> None
    | Some (x : node) -> Some x#obj in
    let obj = manager_add_camera_scene_node_fps self#obj p rs ms id km
      (List.length km) nvm js im
      ma in
    object
      val smgr = self
      inherit camera obj
    end
  method add_cube_node ?(size = 10.) ?parent ?(id = -1) ?(pos = (0., 0., 0.))
    ?(rot = (0., 0., 0.)) ?(scale = (1., 1., 1.)) () =
    let p = match parent with None -> None | Some (x : node) -> Some x#obj in
    let obj = manager_add_cube_scene_node self#obj size p id pos rot scale in
    object
      val smgr = self
      inherit mesh_node obj
    end
  method add_mesh_node ?parent ?(id = -1) ?(pos = (0., 0., 0.))
    ?(rot = (0., 0., 0.)) ?(scale = (1., 1., 1.)) (mesh : mesh) =
    let p = match parent with
    | None -> None
    | Some (x : node) -> Some x#obj in
    let obj =
      manager_add_mesh_scene_node self#obj mesh#obj p id pos rot scale in
    object
      val smgr = self
      inherit mesh_node obj
    end
  method add_octree_node ?parent ?(id = -1) ?(min = 256) (mesh : mesh) =
    let p = match parent with
    | None -> None
    | Some (x : node) -> Some x#obj in
    let obj = manager_add_octree_scene_node self#obj mesh#obj p id min in
    object
      val smgr = self
      inherit mesh_node obj
    end
  method add_sphere_node ?(radius = 5.) ?(poly_count = 16) ?parent ?(id = -1)
    ?(pos = (0., 0., 0.)) ?(rot = (0., 0., 0.)) ?(scale = (1., 1., 1.)) () =
    let p = match parent with None -> None | Some (x : node) -> Some x#obj in
    let obj = manager_add_sphere_scene_node self#obj radius poly_count p id pos
      rot scale in
    object
      val smgr = self
      inherit mesh_node obj
    end
  method add_terrain_node ?parent ?(id = -1) ?(pos = (0., 0., 0.))
    ?(rot = (0., 0., 0.)) ?(scale = (0., 0., 0.))
    ?(color = Irr_core.color_ARGB 255 255 255 255) ?(max_lod = 5)
    ?(patch_size = `tps_17) ?(smooth_factor = 0)
    ?(add_also_if_heightmap_empty = false) filename =
    let p = match parent with Some (p1 : node) -> Some p1#obj | None -> None in
    let obj = manager_add_terrain_scene_node self#obj filename p id pos rot
      scale color max_lod patch_size smooth_factor
      add_also_if_heightmap_empty in
    object
      val smgr = self
      inherit terrain_node obj
    end
  method add_sky_box_node ~(top:Irr_video.texture) ~(bottom:Irr_video.texture)
    ~(left:Irr_video.texture) ~(right:Irr_video.texture)
    ~(front:Irr_video.texture) ~(back:Irr_video.texture) ?parent ?(id = -1) () =
    let p = match parent with Some (x : node) -> Some x#obj | None -> None in
    let obj = manager_add_sky_box_scene_node self#obj top#obj bottom#obj
      left#obj right#obj front#obj back#obj p id in
    object
      val smgr = self
      inherit node obj
    end
  method add_sky_dome_node ?(hori_res = 16) ?(vert_res = 8)
    ?(texture_percentage = 0.9) ?(sphere_percentage = 2.) ?(radius = 1000.)
    ?parent ?(id = -1) (texture : Irr_video.texture) =
    let p = match parent with Some (x : node) -> Some x#obj | None -> None in
    let obj = manager_add_sky_dome_scene_node self#obj texture#obj hori_res
      vert_res texture_percentage sphere_percentage radius p id in
    object
      val smgr = self
      inherit node obj
    end
  method add_billboard_node ?parent ?(size = (10., 10.)) ?(pos = (0., 0., 0.))
    ?(id = -1) ?(color_top = Irr_core.color_ARGB 255 255 255 255)
    ?(color_bottom = Irr_core.color_ARGB 255 255 255 255) () =
    let p = match parent with Some (x : node) -> Some x#obj | None -> None in
    let obj = manager_add_billboard_scene_node self#obj p size pos id color_top
      color_bottom in
    object
      val smgr = self
      inherit billboard_node obj
    end
  method add_light_node ?parent ?(pos = (0., 0., 0.))
    ?(color = Irr_core.colorf_RGB 1. 1. 1.) ?(radius = 100.) ?(id = -1) () =
    let p = match parent with Some (x : node) -> Some x#obj | None -> None in
    let obj = manager_add_light_scene_node self#obj p pos color radius id in
    object
      val smgr = self
      inherit light_node obj
    end
  method add_hill_plane_mesh name tile_size ?material ?(height = 0.)
    ?(count_hills = (0., 0.)) ?(texture_repeat_count = (1., 1.)) tile_count =
    let m = match material with
    | None -> None
    | Some (x : Irr_video.material) -> Some x#obj in
    let obj = manager_add_hill_plane_mesh self#obj name tile_size tile_count m
      height count_hills texture_repeat_count in
    object
      inherit animated_mesh obj
      val smgr = self
    end
  method add_water_surface_node ?(wave_height = 2.) ?(wave_speed = 300.)
    ?(wave_length = 10.) ?parent ?(id = -1) ?(pos = (0., 0., 0.))
    ?(rot = (0., 0., 0.)) ?(scale = (1., 1., 1.)) (mesh : mesh) =
    let p = match parent with None -> None | Some (x : node) -> Some x#obj in
    let obj = manager_add_water_surface_scene_node self#obj mesh#obj
      wave_height wave_speed wave_length p id pos rot scale in
    object
      inherit node obj
      val smgr = self
    end
  method add_particle_system_node ?(with_default_emitter = true)
    ?parent ?(id = -1) ?(pos = (0., 0., 0.)) ?(rot = (0., 0., 0.))
    ?(scale = (1., 1., 1.)) () =
    let p = match parent with None -> None | Some (x : node) -> Some x#obj in
    let obj = manager_add_particle_system_scene_node self#obj
      with_default_emitter p id pos rot scale in
    object
      inherit particle_system_node obj
      val smgr = self
    end
  method add_volume_light_node ?parent ?(id = -1) ?(subdiv_u = 32)
    ?(subdiv_v = 32) ?(foot = Irr_core.color_ARGB 51 0 260 180)
    ?(tail = Irr_core.color_ARGB 0 0 0 0) ?(pos = (0., 0., 0.))
    ?(rot = (0., 0., 0.)) ?(scale = (1., 1., 1.)) () =
    let p = match parent with None -> None | Some (x : node) -> Some x#obj in
    let obj = manager_add_volume_light_scene_node self#obj p id subdiv_u
      subdiv_v foot tail pos rot scale in
    object
      inherit volume_light_node obj
      val smgr = self
    end
  method create_fly_circle ?(center = (0., 0., 0.)) ?(radius = 100.)
    ?(speed = 0.001) ?(dir = (0., 1., 0.)) ?(start = 0.)
    ?(radius_ellipsoid = 0.) () =
    let obj = manager_create_fly_circle_animator self#obj center radius speed
      dir start radius_ellipsoid in
    object(self1)
      inherit animator obj
      initializer Gc.finalise free self1
    end
  method create_fly_straight start ends ?(loop = false) ?(pingpong = false)
    time =
    let obj = manager_create_fly_straight_animator self#obj start ends time
      loop pingpong in
    object(self1)
      inherit animator obj
      initializer Gc.finalise free self1
    end
  method create_terrain_triangle_selector ?(lod = 0) (node : terrain_node) =
    let obj = manager_create_terrain_triangle_selector self#obj node#obj lod in
    object(self1)
      inherit triangle_selector obj
      initializer Gc.finalise free self1
    end
  method create_octree_triangle_selector (mesh : mesh) ?(mppn = 32)
    (node : node) =
    let obj = manager_create_octree_triangle_selector self#obj mesh#obj node#obj
      mppn in
    object(self1)
      inherit triangle_selector obj
      initializer Gc.finalise free self1
    end
  method create_collision_response_animator (world : triangle_selector)
    ?(ellipsoid_radius = (30., 60., 30.))
    ?(gravity_per_second = (0., -10., 0.))
    ?(ellipsoid_translation = (0., 0., 0.)) ?(sliding = 0.0005) (node : node) =
    let obj = manager_create_collision_response_animator self#obj world#obj
      node#obj ellipsoid_radius gravity_per_second ellipsoid_translation
      sliding in
    object(self1)
      inherit animator_collision_response obj
      initializer Gc.finalise free self1
    end
  method create_triangle_selector (node : animated_mesh_node) =
    let obj = manager_create_triangle_selector self#obj node#obj in
    object(self1)
      inherit triangle_selector obj
      initializer Gc.finalise free self1
    end
  method create_texture_animator textures ?(loop = true) time =
    let list = List.map (fun (x : Irr_video.texture) -> x#obj) textures in
    let obj = manager_create_texture_animator self#obj list time loop in
    object(self1)
      inherit animator obj
      initializer Gc.finalise free self1
    end
  method draw_all = manager_draw_all self#obj
  method set_shadow_color c = manager_set_shadow_color self#obj c
  method get_mesh filename =
    let obj = manager_get_mesh self#obj filename in
    object
      val smgr = self
      inherit animated_mesh obj
    end
  method collision_manager =
    let obj = manager_get_scene_collision_manager self#obj in
    object
      val smgr = self
      inherit collision_manager obj
    end
end
