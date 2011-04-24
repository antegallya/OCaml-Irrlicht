open Printf

let key_is_down = Array.make (Irr_base.key_count) false

let is_key_down key = key_is_down.(Irr_base.int_of_key key)

let on_event = function
| `key_input ki ->
  let key = Irr_base.int_of_key ki.Irr_base.ki_key in
  key_is_down.(key) <- ki.Irr_base.ki_pressed_down;
  false
| _ -> false

let add_sphere (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let node = smgr#add_sphere_node () in
  node#set_pos (0., 0., 30.);
  node#set_material_texture (driver#get_texture "../../media/wall.bmp");
  node#set_material_flag `lighting false;
  node

let add_cube (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let n = smgr#add_cube_node () in
  n#set_material_texture (driver#get_texture "../../media/t351sml.jpg");
  n#set_material_flag `lighting false;
  let anim = smgr#create_fly_circle ~center:(0., 0., 30.) ~radius:20. () in
  n#add_animator anim

let add_anms (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let anms = smgr#add_animated_mesh_node
    (smgr#get_mesh "../../media/ninja.b3d") in
  let anim = smgr#create_fly_straight (100., 0., 60.) (-100., 0., 60.)
    ~loop:true 3500 in
  anms#add_animator anim;
  anms#set_material_flag `lighting false;
  anms#set_frame_loop 1 13;
  anms#set_animation_speed 15.;
  anms#set_scale (2., 2., 2.);
  anms#set_rot (0., -90., 0.)

let update_sphere node fdt =
  let aux (x, y, z) (key, u, v) =
    if is_key_down key then (x +. fdt *. u, y +. fdt *. v, z) else (x, y, z) in
  let list = [ (`key_d, 1., 0.); (`key_z, 0., 1.); (`key_q, -1., 0.);
    (`key_s, 0., -1.)] in
  let new_pos = List.fold_left aux node#pos list in
  node#set_pos new_pos

let () =
  let device = Irr.create_device ~dtype:`opengl ~on_event () in
  let driver = device#driver in
  let smgr = device#scene_manager in
  let node = add_sphere driver smgr in
  add_cube driver smgr;
  add_anms driver smgr;
  let _ = smgr#add_camera_fps () in
  device#cursor#set_visible false;
  let _ = device#gui_env#add_image
    (driver#get_texture "../../media/irrlichtlogoalpha2.tga") (10, 20) in
  let diagnostics = device#gui_env#add_static_text "" (10, 10, 400, 20) in
  diagnostics#set_override_color (Irr_core.color_ARGB 255 255 255 0);
  let rec loop last_fps last_time =
    let current_time = device#timer#time in
    let fdt = float (current_time - last_time) /. 1000.  in
    update_sphere node fdt;
    driver#begin_scene ~color:(Irr_core.color_ARGB 255 113 113 113) ();
    smgr#draw_all;
    device#gui_env#draw_all;
    driver#end_scene;
    let fps = driver#fps in
    if last_fps <> fps then (
      let tmp = sprintf "Movement Example - Irrlicht Engine [%s] fps:%d"
        driver#name fps in
      device#set_window_caption tmp
    );
    if device#run then loop fps current_time
  in loop (-1) device#timer#time
