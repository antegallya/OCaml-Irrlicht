let change_font (env : Irr_gui.environment) =
  let skin = env#skin in
  let font = env#font "../../media/fonthaettenschweiler.bmp" in
  skin#set_font font;
  skin#set_font ~which:`tooltip env#built_in_font

let () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver in
  let env = device#gui_env in
  change_font env;
  let _ = env#add_button ~text:"Quit" ~tooltiptext:"Exits program"
    (10, 240, 110, 240 + 32) in
  let _ = env#add_button ~text:"New window" ~tooltiptext:"Launches a new Window"
    (10, 280, 110, 280 + 32) in
  let _ = env#add_button ~text:"File open" ~tooltiptext:"Opens a file"
    (10, 320, 110, 320 + 32) in
  let _ = env#add_static_text "Transparent Control:"
    ~border:true (150, 20, 350, 40) in
  let scroll_bar = env#add_scroll_bar true (150, 45, 350, 60) in
  scroll_bar#set_max 255;
  let _ = env#add_static_text "Logging ListBox" ~border:true
    (50, 110, 250, 130) in
  let _ = env#add_list_box (50, 140, 250, 210) in
  while device#run do
    driver#begin_scene ~color:(Irr_core.color_ARGB 0 200 200 200) ();
    env#draw_all;
    driver#end_scene
  done
