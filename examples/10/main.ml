let () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver in
  let env = device#gui_env in
  let _ = env#add_button ~text:"Quit" ~tooltiptext:"Exits program"
    (10, 240, 110, 240 + 32) in
  let _ = env#add_button ~text:"New window" ~tooltiptext:"Launches a new Window"
    (10, 280, 110, 280 + 32) in
  let _ = env#add_button ~text:"File open" ~tooltiptext:"Opens a file"
    (10, 320, 110, 320 + 32) in
  while device#run do
    driver#begin_scene ();
    env#draw_all;
    driver#end_scene
  done
