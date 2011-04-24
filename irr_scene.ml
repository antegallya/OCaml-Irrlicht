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

class node obj = object(self)
  inherit Irr_base.attribute_exchanging_object obj
  method pos = node_get_position self#obj
  method material i =
    let obj = node_get_material self#obj i in
    object
      val node = self
      inherit Irr_video.material obj
    end
  method add_animator (anim : animator) = node_add_animator self#obj anim#obj
  method add_child (node : node) = node_add_child self#obj node#obj
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

(* Binding for class IMesh *)

(******************************************************************************)

class mesh obj = object(self)
  inherit Irr_base.reference_counted obj
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

class billboard_node obj = object(self)
  inherit node obj
  method set_size d = billboard_node_set_size self#obj d
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

let free x = (print_endline "free"; x#drop)

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
  method draw_all = manager_draw_all self#obj
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
