open Printf

let () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver in
  let smgr = device#scene_manager in
  device#file_system#add_zip_archive "../../media/map-20kdm2.pk3";
  let mesh = smgr#get_mesh "../../media/20kdm2.bsp" in
  (*let _ = smgr#add_mesh_node (mesh#mesh 0) in*)
  let node = smgr#add_octree_node (mesh#mesh 0) in
  node#set_pos (-1300., -144., -1249.);
  let _ = smgr#add_camera_fps () in
  let last_fps = ref (-1) in
  let driver_name = driver#name in
  device#cursor#set_visible false;
  while device#run do
    if device#is_window_active then (
      driver#begin_scene ~color:(Irr_core.color_ARGB 255 200 200 200) ();
      smgr#draw_all;
      driver#end_scene;
      let fps = driver#fps in
      if !last_fps <> fps then (
        let str = sprintf "Irrlicht Engine - Quake 3 Map Example [%s] FPS:%d"
          driver_name fps in
        device#set_window_caption str;
        last_fps := fps)
    ) else device#yield
  done
