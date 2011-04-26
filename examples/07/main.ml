let add_room (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let mesh = smgr#get_mesh "../../media/room.3ds" in
  let node = smgr#add_animated_mesh_node mesh in
  node#set_material_texture (driver#get_texture "../../media/wall.jpg");
  node#set_material_flag `lighting false

let add_water (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let mesh = smgr#add_hill_plane_mesh "myHill" (20., 20.)
    ~texture_repeat_count:(10., 10.) (40, 40) in
  let node = smgr#add_water_surface_node ~wave_height:3. ~wave_length:30.
    (mesh#mesh 0) in
  node#set_pos (0., 7., 0.);
  node#set_material_texture (driver#get_texture "../../media/stones.jpg");
  let water_texture = driver#get_texture "../../media/water.jpg" in
  node#set_material_texture ~layer:1 water_texture;
  node#set_material_type `reflection_2_layer;
  node#set_material_flag `lighting false

let add_lighting_ball (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let light_node = smgr#add_light_node ~color:(Irr_core.colorf_RGB 1. 0.6 0.7)
    ~radius:800. () in
  let anim = smgr#create_fly_circle ~center:(0., 150., 0.) ~radius:250. () in
  light_node#add_animator anim;
  let bill_node = smgr#add_billboard_node ~parent:light_node ~size:(50., 50.)
    () in
  bill_node#set_material_flag `lighting false;
  bill_node#set_material_type `transparent_add_color;
  let particle_texture = driver#get_texture "../../media/particlewhite.bmp" in
  bill_node#set_material_texture particle_texture
  
let add_camera (device : Irr.device) (smgr : Irr_scene.manager) =
  let camera = smgr#add_camera_fps () in
  camera#set_pos (-50., 50., -150.);
  device#cursor#set_visible false

let () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver and smgr = device#scene_manager in
  add_room driver smgr;
  add_water driver smgr;
  add_lighting_ball driver smgr;
  add_camera device smgr;
  while device#run do
    driver#begin_scene ();
    smgr#draw_all;
    driver#end_scene
  done
