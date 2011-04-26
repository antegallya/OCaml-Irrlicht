let add_room (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let mesh = smgr#get_mesh "../../media/room.3ds" in
  let node = smgr#add_animated_mesh_node mesh in
  node#set_material_texture (driver#get_texture "../../media/wall.jpg");
  node#set_material_flag `lighting false

let add_camera (device : Irr.device) (smgr : Irr_scene.manager) =
  let camera = smgr#add_camera_fps () in
  camera#set_pos (-50., 50., -150.);
  device#cursor#set_visible false

let () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver and smgr = device#scene_manager in
  add_room driver smgr;
  add_camera device smgr;
  while device#run do
    driver#begin_scene ();
    smgr#draw_all;
    driver#end_scene
  done
