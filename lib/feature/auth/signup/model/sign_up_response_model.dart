class SignupResponseModel {
  final bool? status;
  final bool? success;
  final String? message;
  final String? token;
  final dynamic data;

  SignupResponseModel({
    this.status,
    this.success,
    this.message,
    this.token,
    this.data,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    String? extractedToken;
    if (json['token'] is String) {
      extractedToken = json['token'];
    } else if (json['data'] is Map && json['data']['token'] is String) {
      extractedToken = json['data']['token'];
    }

    return SignupResponseModel(
      status: json['status'] is bool
          ? json['status'] as bool
          : (json['success'] is bool ? json['success'] as bool : null),
      success: json['success'] is bool
          ? json['success'] as bool
          : (json['status'] is bool ? json['status'] as bool : null),
      message: (json['message'] ?? json['msg']) as String?,
      token: extractedToken,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'success': success,
      'message': message,
      'token': token,
      'data': data,
    };
  }
}
