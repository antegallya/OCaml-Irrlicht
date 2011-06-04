let iteri f list =
  let rec aux i = function
    | [] -> ()
    | x :: xs -> f i x; aux (i + 1) xs in
  aux 0 list

let create_mesh () =
  let vertices = [(0., 0., 0.); (0., 1., 0.); (1., 0., 0.)] in
  let indices = [0; 1; 2] in
  let buf = new Irr_scene.fresh_mesh_buffer in
  buf#set_vertices_used (List.length vertices);
  buf#set_indices_used (List.length indices);
  let add_vertex i pos =
    let vert =
      {Irr_video.Vertex.pos = pos; normal = (0., 0., 0.);
      color = Irr_core.color_ARGB 255 255 0 0; t_coords = (0., 0.)} in
    buf#set_vertex i vert in
  iteri add_vertex vertices;
  iteri (fun i j -> buf#set_index i j) indices;
  let mesh = new Irr_scene.fresh_mesh in
  mesh#add_buffer (buf :> Irr_scene.mesh_buffer);
  mesh

let () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver in
  let smgr = device#scene_manager in
  let _ = smgr#add_camera_fps () in
  let node = smgr#add_mesh_node ~pos:(0., 0., 100.) ~scale:(10., 10., 10.)
    (create_mesh () :> Irr_scene.mesh) in
  node#set_material_flag `lighting false;
  while device#run do
    driver#begin_scene ~color:(Irr_core.color_ARGB 255 255 255 255) ();
    smgr#draw_all;
    driver#end_scene
  done
