let () =
  let device = Irr.create_device ~dtype:`opengl ~size:(512, 384) () in
  device#set_window_caption "Irrlicht Engine - 2D Graphics Demo";
  let driver = device#driver in
  let images = driver#get_texture "../../media/2ddemo.png" in
  driver#make_color_key_from_px images (0, 0);
  let font = device#gui_env#built_in_font in
  let font2 = device#gui_env#font "../../media/fonthaettenschweiler.bmp" in
  let imp1 = (349, 15, 385, 78) in
  let imp2 = (387, 15, 423, 78) in
  (driver#material_2d#layer 0)#set_bilinear_filter true;
  driver#material_2d#set_anti_aliasing `full_basic;
  while device#run do
    if device#is_window_active then (
      let time = device#timer#time in
      driver#begin_scene ~color:(Irr_core.color_ARGB 255 120 102 136) ();
      driver#draw_2d_image images ~src:(0, 0, 342, 224) ~alpha:true (50, 50);
      let imp = if (time / 500) mod 2 = 0 then imp1 else imp2 in
      driver#draw_2d_image images ~src:imp ~alpha:true (164, 125);
      let x = time mod 255 in
      let color = Irr_core.color_ARGB 255 x 255 255 in
      driver#draw_2d_image images ~src:imp ~alpha:true ~color (270, 105);
      font#draw "This demo shows that Irrlicht is also capable of drawing 2D \
        graphics." (130, 10, 300, 50) (Irr_core.color_ARGB 255 255 255 255);
      font2#draw "Also mixing with 3d graphics is possible." (130, 20, 300, 60)
        (Irr_core.color_ARGB 255 x x 255);
      driver#enable_material_2d;
      driver#draw_2d_image_scale images ~src:(354, 87, 442, 118)
        (10, 10, 108, 48);
      driver#disable_material_2d;
      let x, y = device#cursor#pos in
      driver#draw_2d_rect (Irr_core.color_ARGB 100 255 255 255)
        (x - 20, y - 20, x + 20, y + 20);
      driver#end_scene
    )
  done
