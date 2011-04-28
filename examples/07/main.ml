open Printf

let add_room (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let mesh = smgr#get_mesh "../../media/room.3ds" in
  let node = smgr#add_animated_mesh_node mesh in
  node#set_material_texture (driver#get_texture "../../media/wall.jpg")

let add_water (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let mesh = smgr#add_hill_plane_mesh "myHill" (20., 20.)
    ~texture_repeat_count:(10., 10.) (40, 40) in
  let node = smgr#add_water_surface_node ~wave_height:3. ~wave_length:30.
    (mesh#mesh 0) in
  node#set_pos (0., 7., 0.);
  node#set_material_texture (driver#get_texture "../../media/stones.jpg");
  let water_texture = driver#get_texture "../../media/water.jpg" in
  node#set_material_texture ~layer:1 water_texture;
  node#set_material_type `reflection_2_layer

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
  
let add_particles (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let ps = smgr#add_particle_system_node ~with_default_emitter:false () in
  let em = ps#create_box_emitter ~box:((-7., 0., -7.), (7., 1., 7.))
    ~direction:(0., 0.06, 0.) ~min_particles_per_second:80
    ~max_particles_per_second:100
    ~min_start_color:(Irr_core.color_ARGB 255 255 255 255)
    ~life_time_min:800 ~life_time_max:2000 ~min_start_size:(10., 10.)
    ~max_start_size:(20., 20.) () in
  let af = ps#create_fade_out_affector () in
  ps#add_affector af;
  ps#set_emitter em;
  ps#set_pos (-70., 60., 40.);
  ps#set_scale (2., 2., 2.);
  ps#set_material_flag `lighting false;
  ps#set_material_flag `zwrite_enable false;
  ps#set_material_type `transparent_add_color;
  ps#set_material_texture (driver#get_texture "../../media/fire.bmp")

let add_volume_light (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let node = smgr#add_volume_light_node
    ~foot:(Irr_core.color_ARGB 0 255 255 255) () in
  node#set_scale (56., 56., 56.);
  node#set_pos (-120., 50., 40.);
  let aux i = driver#get_texture (sprintf "../../media/portal%d.bmp" (i + 1)) in
  let textures = Array.to_list (Array.init 7 aux) in
  node#add_animator (smgr#create_texture_animator textures 150)

let add_dwarf (smgr : Irr_scene.manager) =
  let mesh = smgr#get_mesh "../../media/dwarf.x" in
  let anode = smgr#add_animated_mesh_node mesh in
  anode#set_pos (-50., 20., -60.);
  anode#set_animation_speed 15.;
  let _ = anode#add_shadow_volume_node () in
  smgr#set_shadow_color (Irr_core.color_ARGB 150 0 0 0);
  anode#set_scale (2., 2., 2.);
  anode#set_material_flag `normalize_normals true

let add_camera (device : Irr.device) (smgr : Irr_scene.manager) =
  let camera = smgr#add_camera_fps () in
  camera#set_pos (-50., 50., -150.);
  device#cursor#set_visible false

let () =
  let device = Irr.create_device ~dtype:`opengl ~stencilbuffer:true () in
  let driver = device#driver and smgr = device#scene_manager in
  add_room driver smgr;
  add_water driver smgr;
  add_lighting_ball driver smgr;
  add_particles driver smgr;
  add_volume_light driver smgr;
  add_dwarf smgr;
  add_camera device smgr;
  while device#run do
    driver#begin_scene ();
    smgr#draw_all;
    driver#end_scene
  done
