import "permission_model.dart";

class Respond {
  final String status;
  final dynamic data;
  final String? token;
  final Permission? permission;
  final String? message;

  const Respond({required this.status, this.data, this.token, this.permission, this.message});

  factory Respond.fromJson(Map<String,dynamic> json){
    return switch(json) {
      {
        "status" : String status,
        "data" : dynamic data,
        "permission" : dynamic permission,
        "token" : String token
      } => Respond(status: status, data: data, permission: Permission.fromJson(permission), token: token),
      {
        "status" : String status,
        "token" : String token
      } => Respond(status: status, token: token),
      {
        "status" : String status,
        "message" : String message
      } => Respond(status: status, message: message),
      _ => throw const FormatException("Respond format incorrect.")
    };
  }
}