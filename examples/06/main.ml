open Printf

let is_not_pickable = 0
let is_pickable = 1
let is_highlightable = 2

let add_q3node_and_cam (device : Irr.device) (driver : Irr_video.driver)
  (smgr : Irr_scene.manager) =
  let q3levelmesh = smgr#get_mesh "../../media/20kdm2.bsp" in
  let q3node = smgr#add_octree_node ~id:is_pickable (q3levelmesh#mesh 0) in
  q3node#set_pos (-1350., -130., -1400.);
  let selector = smgr#create_octree_triangle_selector q3node#mesh ~mppn:128
    (q3node :> Irr_scene.node) in
  q3node#set_triangle_selector selector;
  let camera = smgr#add_camera_fps ~rs:100. ~ms:0.3 ~id:is_not_pickable
    ~js:3. () in
  camera#set_pos (50., 50., -60.);
  camera#set_target (-70., 30., -60.);
  let anim = smgr#create_collision_response_animator selector
    ~ellipsoid_radius:(30., 50., 30.) ~ellipsoid_translation:(0., 30., 0.)
    (camera :> Irr_scene.node) in
  camera#add_animator anim;
  device#cursor#set_visible false;
  camera


let add_bill (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let bill = smgr#add_billboard_node () in
  bill#set_material_type `transparent_add_color;
  bill#set_material_texture (driver#get_texture "../../media/particle.bmp");
  bill#set_material_flag `lighting false;
  bill#set_material_flag `zbuffer false;
  bill#set_size (20., 20.);
  bill#set_id is_not_pickable;
  bill

let get_ray camera =
  let x0, y0, z0 = camera#pos in
  let x1, y1, z1 = camera#target in
  let x = x1 -. x0 and y = y1 -. y0 and z = z1 -. z0 in
  let len = sqrt (x *. x +. y *. y +. z *. z) in
  let f w w0 = w0 +. w /. len *. 1000. in
  ((x0, y0, z0), (f x x0, f y y0, f z z0))

let add_md2 (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let node = smgr#add_animated_mesh_node ~id:(is_pickable lor is_highlightable)
    (smgr#get_mesh "../../media/faerie.md2") in
  node#set_pos (-70., -15., -120.);
  node#set_scale (2., 2., 2.);
  node#set_md2_animation `point;
  node#set_animation_speed 20.;
  let material = node#material 0 in
  material#set_texture 0 (driver#get_texture "../../media/faerie2.bmp");
  material#set_lighting false;
  material#set_normalize_normals true;
  let selector = smgr#create_triangle_selector node in
  node#set_triangle_selector selector

let add_x (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let node = smgr#add_animated_mesh_node ~id:(is_pickable lor is_highlightable)
    (smgr#get_mesh "../../media/dwarf.x") in
  node#set_pos (-70., -66., 0.);
  node#set_rot (0., -90., 0.);
  node#set_animation_speed 20.;
  let selector = smgr#create_triangle_selector node in
  node#set_triangle_selector selector

let add_b3d (smgr : Irr_scene.manager) =
  let node = smgr#add_animated_mesh_node ~id:(is_pickable lor is_highlightable)
    (smgr#get_mesh "../../media/ninja.b3d") in
  node#set_scale (10., 10., 10.);
  node#set_pos (-70., -66., -60.);
  node#set_rot (0., 90., 0.);
  node#set_animation_speed 10.;
  (node#material 0)#set_normalize_normals true;
  let selector = smgr#create_triangle_selector node in
  node#set_triangle_selector selector

let add_light (smgr : Irr_scene.manager) =
  let light = smgr#add_light_node ~pos:(-60., 100., 400.)
    ~radius:600. () in
  light#set_id is_not_pickable

let main () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver and smgr = device#scene_manager in
  device#file_system#add_zip_archive "../../media/map-20kdm2.pk3";
  let camera = add_q3node_and_cam device driver smgr in
  let bill = add_bill driver smgr in
  add_md2 driver smgr;
  add_x driver smgr;
  add_b3d smgr;
  add_light smgr;
  let highlighted_node = ref None in
  let coll_man = smgr#collision_manager in
  let mat = new Irr_video.material_fresh in
  mat#set_wireframe true;
  mat#set_lighting false;
  let last_fps = ref (- 1) in
  while device#run do
    driver#begin_scene ();
    smgr#draw_all;
    (match !highlighted_node with
    | None -> ()
    | Some x ->
        x#set_material_flag `lighting true;
        highlighted_node := None);
    (match coll_man#node_and_point_from_ray ~id:is_pickable
      (get_ray camera) with
    | None -> ()
    | Some(node, p, triangle) ->
        driver#set_transform `world (Irr_core.matrix_identity ());
        driver#set_material mat;
        driver#draw_3d_triangle triangle ~color:(Irr_core.color_ARGB 0 255 0 0);
        bill#set_pos p;
        if node#id land is_highlightable = is_highlightable then (
          highlighted_node := Some node;
          node#set_material_flag `lighting false
        );
        let fps = driver#fps in
        if !last_fps <> fps then (
          let str = sprintf
            "Collision detection example - Irrlicht Engine[%s] FPS:%d"
            driver#name fps in
          device#set_window_caption str;
          last_fps := fps
        )
    );
    driver#end_scene
  done

let () = main ()
