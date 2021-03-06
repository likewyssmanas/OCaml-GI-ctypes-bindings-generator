open Ctypes

val c_DESKTOP_APP_INFO_LOOKUP_EXTENSION_POINT_NAME : string
val c_FILE_ATTRIBUTE_ACCESS_CAN_DELETE : string
val c_FILE_ATTRIBUTE_ACCESS_CAN_EXECUTE : string
val c_FILE_ATTRIBUTE_ACCESS_CAN_READ : string
val c_FILE_ATTRIBUTE_ACCESS_CAN_RENAME : string
val c_FILE_ATTRIBUTE_ACCESS_CAN_TRASH : string
val c_FILE_ATTRIBUTE_ACCESS_CAN_WRITE : string
val c_FILE_ATTRIBUTE_DOS_IS_ARCHIVE : string
val c_FILE_ATTRIBUTE_DOS_IS_SYSTEM : string
val c_FILE_ATTRIBUTE_ETAG_VALUE : string
val c_FILE_ATTRIBUTE_FILESYSTEM_FREE : string
val c_FILE_ATTRIBUTE_FILESYSTEM_READONLY : string
val c_FILE_ATTRIBUTE_FILESYSTEM_REMOTE : string
val c_FILE_ATTRIBUTE_FILESYSTEM_SIZE : string
val c_FILE_ATTRIBUTE_FILESYSTEM_TYPE : string
val c_FILE_ATTRIBUTE_FILESYSTEM_USED : string
val c_FILE_ATTRIBUTE_FILESYSTEM_USE_PREVIEW : string
val c_FILE_ATTRIBUTE_GVFS_BACKEND : string
val c_FILE_ATTRIBUTE_ID_FILE : string
val c_FILE_ATTRIBUTE_ID_FILESYSTEM : string
val c_FILE_ATTRIBUTE_MOUNTABLE_CAN_EJECT : string
val c_FILE_ATTRIBUTE_MOUNTABLE_CAN_MOUNT : string
val c_FILE_ATTRIBUTE_MOUNTABLE_CAN_POLL : string
val c_FILE_ATTRIBUTE_MOUNTABLE_CAN_START : string
val c_FILE_ATTRIBUTE_MOUNTABLE_CAN_START_DEGRADED : string
val c_FILE_ATTRIBUTE_MOUNTABLE_CAN_STOP : string
val c_FILE_ATTRIBUTE_MOUNTABLE_CAN_UNMOUNT : string
val c_FILE_ATTRIBUTE_MOUNTABLE_HAL_UDI : string
val c_FILE_ATTRIBUTE_MOUNTABLE_IS_MEDIA_CHECK_AUTOMATIC : string
val c_FILE_ATTRIBUTE_MOUNTABLE_START_STOP_TYPE : string
val c_FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE : string
val c_FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE_FILE : string
val c_FILE_ATTRIBUTE_OWNER_GROUP : string
val c_FILE_ATTRIBUTE_OWNER_USER : string
val c_FILE_ATTRIBUTE_OWNER_USER_REAL : string
val c_FILE_ATTRIBUTE_PREVIEW_ICON : string
val c_FILE_ATTRIBUTE_RECENT_MODIFIED : string
val c_FILE_ATTRIBUTE_SELINUX_CONTEXT : string
val c_FILE_ATTRIBUTE_STANDARD_ALLOCATED_SIZE : string
val c_FILE_ATTRIBUTE_STANDARD_CONTENT_TYPE : string
val c_FILE_ATTRIBUTE_STANDARD_COPY_NAME : string
val c_FILE_ATTRIBUTE_STANDARD_DESCRIPTION : string
val c_FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME : string
val c_FILE_ATTRIBUTE_STANDARD_EDIT_NAME : string
val c_FILE_ATTRIBUTE_STANDARD_FAST_CONTENT_TYPE : string
val c_FILE_ATTRIBUTE_STANDARD_ICON : string
val c_FILE_ATTRIBUTE_STANDARD_IS_BACKUP : string
val c_FILE_ATTRIBUTE_STANDARD_IS_HIDDEN : string
val c_FILE_ATTRIBUTE_STANDARD_IS_SYMLINK : string
val c_FILE_ATTRIBUTE_STANDARD_IS_VIRTUAL : string
val c_FILE_ATTRIBUTE_STANDARD_IS_VOLATILE : string
val c_FILE_ATTRIBUTE_STANDARD_NAME : string
val c_FILE_ATTRIBUTE_STANDARD_SIZE : string
val c_FILE_ATTRIBUTE_STANDARD_SORT_ORDER : string
val c_FILE_ATTRIBUTE_STANDARD_SYMBOLIC_ICON : string
val c_FILE_ATTRIBUTE_STANDARD_SYMLINK_TARGET : string
val c_FILE_ATTRIBUTE_STANDARD_TARGET_URI : string
val c_FILE_ATTRIBUTE_STANDARD_TYPE : string
val c_FILE_ATTRIBUTE_THUMBNAILING_FAILED : string
val c_FILE_ATTRIBUTE_THUMBNAIL_IS_VALID : string
val c_FILE_ATTRIBUTE_THUMBNAIL_PATH : string
val c_FILE_ATTRIBUTE_TIME_ACCESS : string
val c_FILE_ATTRIBUTE_TIME_ACCESS_USEC : string
val c_FILE_ATTRIBUTE_TIME_CHANGED : string
val c_FILE_ATTRIBUTE_TIME_CHANGED_USEC : string
val c_FILE_ATTRIBUTE_TIME_CREATED : string
val c_FILE_ATTRIBUTE_TIME_CREATED_USEC : string
val c_FILE_ATTRIBUTE_TIME_MODIFIED : string
val c_FILE_ATTRIBUTE_TIME_MODIFIED_USEC : string
val c_FILE_ATTRIBUTE_TRASH_DELETION_DATE : string
val c_FILE_ATTRIBUTE_TRASH_ITEM_COUNT : string
val c_FILE_ATTRIBUTE_TRASH_ORIG_PATH : string
val c_FILE_ATTRIBUTE_UNIX_BLOCKS : string
val c_FILE_ATTRIBUTE_UNIX_BLOCK_SIZE : string
val c_FILE_ATTRIBUTE_UNIX_DEVICE : string
val c_FILE_ATTRIBUTE_UNIX_GID : string
val c_FILE_ATTRIBUTE_UNIX_INODE : string
val c_FILE_ATTRIBUTE_UNIX_IS_MOUNTPOINT : string
val c_FILE_ATTRIBUTE_UNIX_MODE : string
val c_FILE_ATTRIBUTE_UNIX_NLINK : string
val c_FILE_ATTRIBUTE_UNIX_RDEV : string
val c_FILE_ATTRIBUTE_UNIX_UID : string
val c_MENU_ATTRIBUTE_ACTION : string
val c_MENU_ATTRIBUTE_ACTION_NAMESPACE : string
val c_MENU_ATTRIBUTE_ICON : string
val c_MENU_ATTRIBUTE_LABEL : string
val c_MENU_ATTRIBUTE_TARGET : string
val c_MENU_LINK_SECTION : string
val c_MENU_LINK_SUBMENU : string
val c_NATIVE_VOLUME_MONITOR_EXTENSION_POINT_NAME : string
val c_NETWORK_MONITOR_EXTENSION_POINT_NAME : string
val c_PROXY_EXTENSION_POINT_NAME : string
val c_PROXY_RESOLVER_EXTENSION_POINT_NAME : string
val c_SETTINGS_BACKEND_EXTENSION_POINT_NAME : string
val c_TLS_BACKEND_EXTENSION_POINT_NAME : string
val c_TLS_DATABASE_PURPOSE_AUTHENTICATE_CLIENT : string
val c_TLS_DATABASE_PURPOSE_AUTHENTICATE_SERVER : string
val c_VFS_EXTENSION_POINT_NAME : string
val c_VOLUME_IDENTIFIER_KIND_CLASS : string
val c_VOLUME_IDENTIFIER_KIND_HAL_UDI : string
val c_VOLUME_IDENTIFIER_KIND_LABEL : string
val c_VOLUME_IDENTIFIER_KIND_NFS_MOUNT : string
val c_VOLUME_IDENTIFIER_KIND_UNIX_DEVICE : string
val c_VOLUME_IDENTIFIER_KIND_UUID : string
val c_VOLUME_MONITOR_EXTENSION_POINT_NAME : string
(*DEPRECATED : async_initable_newv_async*)
(*DEPRECATED : initable_newv*)
(*DEPRECATED : io_scheduler_cancel_all_jobs*)
(*DEPRECATED : io_scheduler_push_job*)
(*DEPRECATED : simple_async_report_gerror_in_idle*)
val unix_mounts_get :
  unit -> (List.t structure (* Not implemented : interface *) ptr * Unsigned.uint64)

val unix_mounts_changed_since :
  Unsigned.uint64 -> bool

val unix_mount_points_get :
  unit -> (List.t structure (* Not implemented : interface *) ptr * Unsigned.uint64)

val unix_mount_points_changed_since :
  Unsigned.uint64 -> bool

val unix_mount_is_system_internal :
  Unix_mount_entry.t structure ptr -> bool

val unix_mount_is_readonly :
  Unix_mount_entry.t structure ptr -> bool

(*Not implemented g_unix_mount_guess_symbolic_icon return type interface not handled*)

val unix_mount_guess_should_display :
  Unix_mount_entry.t structure ptr -> bool

val unix_mount_guess_name :
  Unix_mount_entry.t structure ptr -> string option

(*Not implemented g_unix_mount_guess_icon return type interface not handled*)

val unix_mount_guess_can_eject :
  Unix_mount_entry.t structure ptr -> bool

val unix_mount_get_mount_path :
  Unix_mount_entry.t structure ptr -> string option

val unix_mount_get_fs_type :
  Unix_mount_entry.t structure ptr -> string option

val unix_mount_get_device_path :
  Unix_mount_entry.t structure ptr -> string option

val unix_mount_free :
  Unix_mount_entry.t structure ptr -> unit

val unix_mount_for :
  string -> (Unix_mount_entry.t structure ptr * Unsigned.uint64)

val unix_mount_copy :
  Unix_mount_entry.t structure ptr -> Unix_mount_entry.t structure ptr

val unix_mount_compare :
  Unix_mount_entry.t structure ptr -> Unix_mount_entry.t structure ptr -> int32

val unix_mount_at :
  string -> (Unix_mount_entry.t structure ptr * Unsigned.uint64)

val unix_is_system_fs_type :
  string -> bool

val unix_is_system_device_path :
  string -> bool

val unix_is_mount_path_system_internal :
  string -> bool

(*Not implemented g_tls_server_connection_new return type interface not handled*)

(*Not implemented g_tls_file_database_new return type interface not handled*)

val tls_error_quark :
  unit -> Unsigned.uint32

(*Not implemented g_tls_client_connection_new type interface not implemented*)

(*Not implemented g_tls_backend_get_default return type interface not handled*)

val settings_schema_source_get_default :
  unit -> Settings_schema_source.t structure ptr option

val resources_unregister :
  Resource.t structure ptr -> unit

val resources_register :
  Resource.t structure ptr -> unit

val resources_open_stream :
  string -> Resource_lookup_flags.t_list -> (Input_stream.t ptr option, Error.t structure ptr option) result

val resources_lookup_data :
  string -> Resource_lookup_flags.t_list -> (Bytes.t structure ptr option, Error.t structure ptr option) result

val resources_get_info :
  string -> Resource_lookup_flags.t_list -> (bool * Unsigned.uint64 * Unsigned.uint32, Error.t structure ptr option) result

(*Not implemented g_resources_enumerate_children return type C Array type for Types.Array tag not handled*)

val resource_load :
  string -> (Resource.t structure ptr option, Error.t structure ptr option) result

val resource_error_quark :
  unit -> Unsigned.uint32

val resolver_error_quark :
  unit -> Unsigned.uint32

(*Not implemented g_proxy_resolver_get_default return type interface not handled*)

(*Not implemented g_proxy_get_default_for_protocol return type interface not handled*)

(*Not implemented g_pollable_stream_write_all type C Array type for Types.Array tag not implemented*)

(*Not implemented g_pollable_stream_write type C Array type for Types.Array tag not implemented*)

(*Not implemented g_pollable_stream_read type C Array type for Types.Array tag not implemented*)

val pollable_source_create_full :
  Object.t ptr -> Source.t structure ptr option -> Cancellable.t ptr option -> Source.t structure ptr

val pollable_source_create :
  Object.t ptr -> Source.t structure ptr

val null_settings_backend_create :
  unit -> Settings_backend.t ptr

val networking_init :
  unit -> unit

(*Not implemented g_network_monitor_get_default return type interface not handled*)

val memory_settings_backend_create :
  unit -> Settings_backend.t ptr

val keyfile_settings_backend_create :
  string -> string -> string option -> Settings_backend.t ptr

val io_modules_scan_all_in_directory_with_scope :
  string -> IOModule_scope.t structure ptr -> unit

val io_modules_scan_all_in_directory :
  string -> unit

val io_modules_load_all_in_directory_with_scope :
  string -> IOModule_scope.t structure ptr -> List.t structure (* Not implemented : interface *) ptr

val io_modules_load_all_in_directory :
  string -> List.t structure (* Not implemented : interface *) ptr

val io_extension_point_register :
  string -> IOExtension_point.t structure ptr

val io_extension_point_lookup :
  string -> IOExtension_point.t structure ptr

(*Not implemented g_io_extension_point_implement type gType not implemented*)

val io_error_quark :
  unit -> Unsigned.uint32

val io_error_from_errno :
  int32 -> IOError_enum.t

(*Not implemented g_icon_new_for_string return type interface not handled*)

val icon_hash :
  unit ptr -> Unsigned.uint32

(*Not implemented g_icon_deserialize return type interface not handled*)

(*Not implemented g_file_parse_name return type interface not handled*)

(*Not implemented g_file_new_tmp return type interface not handled*)

(*Not implemented g_file_new_for_uri return type interface not handled*)

(*Not implemented g_file_new_for_path return type interface not handled*)

(*Not implemented g_file_new_for_commandline_arg_and_cwd return type interface not handled*)

(*Not implemented g_file_new_for_commandline_arg return type interface not handled*)

(*Not implemented g_dtls_server_connection_new type interface not implemented*)

(*Not implemented g_dtls_client_connection_new type interface not implemented*)

val dbus_is_unique_name :
  string -> bool

val dbus_is_supported_address :
  string -> (bool, Error.t structure ptr option) result

val dbus_is_name :
  string -> bool

val dbus_is_member_name :
  string -> bool

val dbus_is_interface_name :
  string -> bool

val dbus_is_guid :
  string -> bool

val dbus_is_address :
  string -> bool

val dbus_gvariant_to_gvalue :
  Variant.t structure ptr -> (Value.t structure)

val dbus_gvalue_to_gvariant :
  Value.t structure ptr -> Variant_type.t structure ptr -> Variant.t structure ptr

val dbus_generate_guid :
  unit -> string option

val dbus_error_unregister_error :
  Unsigned.uint32 -> int32 -> string -> bool

val dbus_error_strip_remote_error :
  Error.t structure ptr -> bool

(*Not implemented g_dbus_error_register_error_domain type C Array type for Types.Array tag not implemented*)

val dbus_error_register_error :
  Unsigned.uint32 -> int32 -> string -> bool

val dbus_error_quark :
  unit -> Unsigned.uint32

val dbus_error_create_for_dbus_error :
  string -> string -> Error.t structure ptr

val dbus_error_is_remote_error :
  Error.t structure ptr -> bool

val dbus_error_get_remote_error :
  Error.t structure ptr -> string option

val dbus_error_encode_gerror :
  Error.t structure ptr -> string option

(*Not implemented g_dbus_annotation_info_lookup type C Array type for Types.Array tag not implemented*)

val dbus_address_get_stream_sync :
  string -> Cancellable.t ptr option -> (IOStream.t ptr option * string, Error.t structure ptr option) result

(*Not implemented g_dbus_address_get_stream_finish type interface not implemented*)

(*Not implemented g_dbus_address_get_stream type callback not implemented*)

val dbus_address_get_for_bus_sync :
  Bus_type.t -> Cancellable.t ptr option -> (string option, Error.t structure ptr option) result

val dbus_address_escape_value :
  string -> string option

val content_types_get_registered :
  unit -> List.t structure (* string *) ptr

val content_type_is_unknown :
  string -> bool

val content_type_is_mime_type :
  string -> string -> bool

val content_type_is_a :
  string -> string -> bool

(*Not implemented g_content_type_guess_for_tree type interface not implemented*)

(*Not implemented g_content_type_guess type C Array type for Types.Array tag not implemented*)

(*Not implemented g_content_type_get_symbolic_icon return type interface not handled*)

val content_type_get_mime_type :
  string -> string option

(*Not implemented g_content_type_get_icon return type interface not handled*)

val content_type_get_generic_icon_name :
  string -> string option

val content_type_get_description :
  string -> string option

val content_type_from_mime_type :
  string -> string option

val content_type_equals :
  string -> string -> bool

val content_type_can_be_executable :
  string -> bool

val bus_watch_name :
  Bus_type.t -> string -> Bus_name_watcher_flags.t_list -> Closure.t structure ptr option -> Closure.t structure ptr option -> Unsigned.uint32

val bus_watch_name_on_connection :
  DBus_connection.t ptr -> string -> Bus_name_watcher_flags.t_list -> Closure.t structure ptr option -> Closure.t structure ptr option -> Unsigned.uint32

val bus_unwatch_name :
  Unsigned.uint32 -> unit

val bus_unown_name :
  Unsigned.uint32 -> unit

val bus_own_name :
  Bus_type.t -> string -> Bus_name_owner_flags.t_list -> Closure.t structure ptr option -> Closure.t structure ptr option -> Closure.t structure ptr option -> Unsigned.uint32

val bus_own_name_on_connection :
  DBus_connection.t ptr -> string -> Bus_name_owner_flags.t_list -> Closure.t structure ptr option -> Closure.t structure ptr option -> Unsigned.uint32

val bus_get_sync :
  Bus_type.t -> Cancellable.t ptr option -> (DBus_connection.t ptr option, Error.t structure ptr option) result

(*Not implemented g_bus_get_finish type interface not implemented*)

(*Not implemented g_bus_get type callback not implemented*)

val app_info_reset_type_associations :
  string -> unit

(*Not implemented g_app_info_launch_default_for_uri_finish type interface not implemented*)

(*Not implemented g_app_info_launch_default_for_uri_async type callback not implemented*)

val app_info_launch_default_for_uri :
  string -> App_launch_context.t ptr option -> (bool, Error.t structure ptr option) result

val app_info_get_recommended_for_type :
  string -> List.t structure (* Not implemented : interface *) ptr

val app_info_get_fallback_for_type :
  string -> List.t structure (* Not implemented : interface *) ptr

(*Not implemented g_app_info_get_default_for_uri_scheme return type interface not handled*)

(*Not implemented g_app_info_get_default_for_type return type interface not handled*)

val app_info_get_all_for_type :
  string -> List.t structure (* Not implemented : interface *) ptr

val app_info_get_all :
  unit -> List.t structure (* Not implemented : interface *) ptr

(*Not implemented g_app_info_create_from_commandline return type interface not handled*)

val action_print_detailed_name :
  string -> Variant.t structure ptr option -> string option

val action_parse_detailed_name :
  string -> (bool * string * Variant.t structure ptr, Error.t structure ptr option) result

val action_name_is_valid :
  string -> bool

