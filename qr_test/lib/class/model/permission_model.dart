class Permission {
  final bool access;
  final bool create;
  final bool update;
  final bool delete;

  Permission({required this.access, required this.create, required this.update, required this.delete});

  factory Permission.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        "access" : bool access,
        "create" : bool create,
        "update" : bool update,
        "delete" : bool delete
      } => Permission(access: access, create: create, update: update, delete: delete),
       _ => throw const FormatException("Permission Model: Failed to load user data")
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['create'] = create;
    data['update'] = update;
    data['delete'] = delete;
    return data;
  }
}