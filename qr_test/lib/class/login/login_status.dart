class LoginStatus {
  final String status;
  final String token;
  final String message;

  const LoginStatus({required this.status, required this.token, required this.message});

  factory LoginStatus.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'status' : String status,
      'token' : String token,
      } =>
      LoginStatus(
        status: status,
        token: token,
        message: "",
      ),
      {
        'status' : String status,
        'message' : String message,
      } => LoginStatus(
        status: status,
        token: "",
        message: message
      ),
      _ => throw const FormatException('Failed to Login'),
    };
  }
}