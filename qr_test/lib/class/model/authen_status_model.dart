class AuthenStatus {
  final String status;
  final String? token;
  final String? message;

  const AuthenStatus({required this.status,  this.token,  this.message});

  factory AuthenStatus.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'status' : String status,
      'token' : String token,
      } =>
      AuthenStatus(
        status: status,
        token: token,
      ),
      {
        'status' : String status,
        'message' : String message,
      } => AuthenStatus(
        status: status,
        message: message
      ),
      _ => throw const FormatException('Failed to Login'),
    };
  }
}