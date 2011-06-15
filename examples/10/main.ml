let () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver in
  let env = device#gui_env in
  while device#run do
    driver#begin_scene ();
    env#draw_all;
    driver#end_scene
  done
