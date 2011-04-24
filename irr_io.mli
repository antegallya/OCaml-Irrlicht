(** This module implement some part of irr:io *)

type obj = Irr_base.obj

exception File_archive_exn

(** Class IFileSystem *)
class file_system : obj -> object
  inherit Irr_base.reference_counted
  method add_archive : ?ignore_case:bool -> ?ignore_paths:bool ->
    ?archive_type:Irr_enums.file_archive_type -> ?passwd:string -> string ->
      unit
  method add_zip_archive : ?ignore_case:bool -> ?ignore_paths:bool ->
    string -> unit
end
