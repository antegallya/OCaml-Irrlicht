type obj = Irr_base.obj

(******************************************************************************)

(* Binding for class IFileSystem *)

(******************************************************************************)

exception File_archive_exn

external file_system_add_file_archive :
  obj -> string -> bool -> bool -> Irr_enums.file_archive_type -> string ->
    bool =
      "ml_IFileSystem_addFileArchive_bytecode"
      "ml_IFileSystem_addFileArchive_native"

class file_system obj = object(self)
  inherit Irr_base.reference_counted obj
  method add_archive ?(ignore_case = true) ?(ignore_paths = true)
    ?(archive_type = `unknown) ?(passwd = "") filename =
      if not (file_system_add_file_archive self#obj filename ignore_case
      ignore_paths archive_type passwd) then raise File_archive_exn
  method add_zip_archive ?ignore_case ?ignore_paths filename =
    self#add_archive ?ignore_case ?ignore_paths ~archive_type:`zip filename
end
