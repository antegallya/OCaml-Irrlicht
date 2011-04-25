#include "global.h"

/* Stub for class IFileSystem */

extern "C" CAMLprim value ml_IFileSystem_addFileArchive_native(
		value v_fs, value v_filename,  value v_ignore_case, value v_ignore_paths,
		value v_archive_type, value v_passwd)
{
	return Val_bool(((IFileSystem*) v_fs)->addFileArchive(String_val(v_filename),
			Bool_val(v_ignore_case), Bool_val(v_ignore_paths),
			file_archive_type_val(v_archive_type), String_val(v_passwd)));
}

extern "C" CAMLprim value ml_IFileSystem_addFileArchive_bytecode(
		value* argv, int argn)
{
	return ml_IFileSystem_addFileArchive_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5]);
}

