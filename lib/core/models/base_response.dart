class BaseResponse<T> {
  final int code;
  final String message;
  final T? data;

  BaseResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) dataFromJson,
  ) {
    return BaseResponse<T>(
      code: json['response']['code'],
      message: json['response']['message'] ?? '',
      data: json['data'] != null ? dataFromJson(json['data']) : null,
    );
  }
}
