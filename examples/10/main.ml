module Id : sig
  type t =
    Quit_button | New_window_button | File_open_button |
    Transparency_scroll_bar
  val of_int : int -> t option
  val to_int : t -> int
end = struct
  type t =
    Quit_button | New_window_button | File_open_button |
    Transparency_scroll_bar
  let assoc =
    [(Quit_button, 101); (New_window_button, 1); (File_open_button, 2);
    (Transparency_scroll_bar, 3)]
  let assoc_inv = List.map (fun (x, y) -> (y, x)) assoc
  let of_int i = try Some (List.assoc i assoc_inv) with Not_found -> None
  let to_int x = try List.assoc x assoc with Not_found -> assert false
end

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
    ~id:(Id.to_int Id.Quit_button) (10, 240, 110, 240 + 32) in
  let _ = env#add_button ~text:"New window" ~tooltiptext:"Launches a new Window"
    ~id:(Id.to_int Id.New_window_button) (10, 280, 110, 280 + 32) in
  let _ = env#add_button ~text:"File open" ~tooltiptext:"Opens a file"
    ~id:(Id.to_int Id.File_open_button) (10, 320, 110, 320 + 32) in
  let _ = env#add_static_text "Transparent Control:"
    ~border:true (150, 20, 350, 40) in
  let scroll_bar = env#add_scroll_bar true
    ~id:(Id.to_int Id.Transparency_scroll_bar) (150, 45, 350, 60) in
  scroll_bar#set_max 255;
  let _ = env#add_static_text "Logging ListBox" ~border:true
    (50, 110, 250, 130) in
  let list_box = env#add_list_box (50, 140, 250, 210) in
  let _ = env#add_edit_box "Editable Text" (350, 80, 550, 100) in
  let counter = ref 0 in
  let on_event = function
    | `gui_event {Irr_base.ge_caller = id; ge_type = `button_clicked} ->
        (match Id.of_int id with
        | Some Id.Quit_button -> device#close; true
        | Some Id.New_window_button ->
            let _ = list_box#add_item "Window created" in
            counter := (!counter + 30) mod 200;
            true
        | _ -> false)
    | _ -> false in
  device#set_on_event on_event;
  while device#run do
    if device#is_window_active then (
      driver#begin_scene ~color:(Irr_core.color_ARGB 0 200 200 200) ();
      env#draw_all;
      driver#end_scene
    );
  done
