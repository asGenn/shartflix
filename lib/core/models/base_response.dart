class BaseResponse<T> {
  final int code;
  final String message;
  final T? data;

  BaseResponse({required this.code, required this.message, this.data});

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

  // List tipi data için özel fromJson
  static BaseResponse<List<T>> fromJsonList<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) itemFromJson,
  ) {
    return BaseResponse<List<T>>(
      code: json['response']['code'],
      message: json['response']['message'] ?? '',
      data: json['data'] != null
          ? (json['data'] as List).map((item) => itemFromJson(item)).toList()
          : null,
    );
  }
}
