open Printf

let () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver in
  let smgr = device#scene_manager in
  let env = device#gui_env in
  driver#set_texture_creation_flag `always_32_bit true;
  let _ = env#add_image (driver#get_texture "../../media/irrlichtlogo2.png")
    (10, 10) in
  env#skin#set_font (env#font "../../media/fontlucida.png");
  let _ = env#add_static_text
    ("Press 'W' to change wireframe mode\n" ^
      "Press 'D' to toggle detail map\n" ^
      "Press 'S' to toggle skybox/skydome")
    ~border:true ~fill_bg:true (10, 421, 250, 475) in
  let camera = smgr#add_camera_fps () in
  camera#set_pos (2700. *. 2., 255. *. 2., 2600. *. 2.);
  camera#set_target (2397. *. 2., 343. *. 2., 2700. *. 2.);
  camera#set_far_value 42000.;
  device#cursor#set_visible false;
  let terrain = smgr#add_terrain_node ~scale:(40., 4.4, 40.)
    ~smooth_factor:4 "../../media/terrain-heightmap.bmp" in
  terrain#set_material_flag `lighting false;
  terrain#set_material_texture
    (driver#get_texture "../../media/terrain-texture.jpg"); 
  terrain#set_material_texture ~layer:1
    (driver#get_texture "../../media/detailmap3.jpg");
  terrain#set_material_type `detail_map;
  terrain#scale_texture 1. 20.;
  let selector = smgr#create_terrain_triangle_selector terrain in
  terrain#set_triangle_selector selector;
  let anim = smgr#create_collision_response_animator selector
    ~ellipsoid_radius:(60., 100., 60.) ~gravity_per_second:(0., 0., 0.)
    ~ellipsoid_translation:(0., 50., 0.) (camera :> Irr_scene.node) in
  camera#add_animator anim;
  driver#set_texture_creation_flag `create_mip_maps false;
  let skybox = smgr#add_sky_box_node
    ~top:(driver#get_texture "../../media/irrlicht2_up.jpg")
    ~bottom:(driver#get_texture "../../media/irrlicht2_dn.jpg")
    ~left:(driver#get_texture "../../media/irrlicht2_lf.jpg")
    ~right:(driver#get_texture "../../media/irrlicht2_rt.jpg")
    ~front:(driver#get_texture "../../media/irrlicht2_ft.jpg")
    ~back:(driver#get_texture "../../media/irrlicht2_bk.jpg") () in
  let skydome = smgr#add_sky_dome_node
    (driver#get_texture "../../media/skydome.jpg") in
  driver#set_texture_creation_flag `create_mip_maps true;
  skydome#set_visible false;
  let show_box = ref true in
  let on_event = function
    | `key_input {Irr_base.ki_key = key; ki_pressed_down = true} ->
        (match key with
        | `key_w ->
            let flag = not (terrain#material 0)#wireframe in
            terrain#set_material_flag `wireframe flag;
            terrain#set_material_flag `pointcloud false;
            true
        | `key_p ->
            let flag = not (terrain#material 0)#point_cloud in
            terrain#set_material_flag `pointcloud flag;
            terrain#set_material_flag `wireframe false;
            true
        | `key_d ->
            let t = (terrain#material 0)#material_type in
            let t1 = if t = `solid then `detail_map else `solid in
            terrain#set_material_type t1;
            true
        | `key_s ->
            show_box := not !show_box;
            skybox#set_visible !show_box;
            skydome#set_visible (not !show_box);
            true
        | _ -> false)
    | _ -> false in
  device#set_on_event on_event;
  let last_fps = ref (-1) in
  while device#run do
    driver#begin_scene ~color:(Irr_core.color_ARGB 255 200 200 200) ();
    smgr#draw_all;
    env#draw_all;
    driver#end_scene;
    let fps = driver#fps in
    if fps <> !last_fps then (
      let x, y, _ = camera#abs_pos in
      let str = sprintf
        "Terrain renderer - Irrlicht Engine [%s] FPS:%d Height: %f"
        driver#name fps (terrain#height x y) in
      device#set_window_caption str;
      last_fps := fps;
    )
  done
