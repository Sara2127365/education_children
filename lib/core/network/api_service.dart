import 'dart:convert';
import 'dart:io';

class ApiService {
  static final HttpClient _client = HttpClient()
    ..connectionTimeout = const Duration(seconds: 20);

  /// إرسال طلب POST بصيغة JSON
  static Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse(url);
      final request = await _client.postUrl(uri);

      // الرؤوس الأساسية
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=UTF-8');
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');

      if (headers != null) {
        headers.forEach((key, value) {
          request.headers.set(key, value);
        });
      }

      // كتابة البيانات وإرسال الطلب
      request.write(jsonEncode(body));
      final response = await request.close().timeout(const Duration(seconds: 20));

      final responseBody = await response.transform(utf8.decoder).join();

      if (responseBody.trim().isEmpty) {
        return {
          'status': response.statusCode >= 200 && response.statusCode < 300,
          'statusCode': response.statusCode,
        };
      }

      final dynamic decoded = jsonDecode(responseBody);
      if (decoded is Map<String, dynamic>) {
        decoded['statusCode'] = response.statusCode;
        return decoded;
      } else {
        return {
          'status': response.statusCode >= 200 && response.statusCode < 300,
          'statusCode': response.statusCode,
          'data': decoded,
        };
      }
    } on SocketException {
      throw Exception('لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.');
    } on HandshakeException {
      throw Exception('خطأ في شهادة أمان السيرفر، يرجى المحاولة لاحقاً.');
    } on FormatException {
      throw Exception('استجابة غير متوقعة من السيرفر.');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// إرسال طلب GET
  static Future<Map<String, dynamic>> get({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse(url);
      final request = await _client.getUrl(uri);

      request.headers.set(HttpHeaders.acceptHeader, 'application/json');

      if (headers != null) {
        headers.forEach((key, value) {
          request.headers.set(key, value);
        });
      }

      final response = await request.close().timeout(const Duration(seconds: 20));
      final responseBody = await response.transform(utf8.decoder).join();

      final dynamic decoded = jsonDecode(responseBody);
      if (decoded is Map<String, dynamic>) {
        decoded['statusCode'] = response.statusCode;
        return decoded;
      } else {
        return {
          'status': response.statusCode >= 200 && response.statusCode < 300,
          'statusCode': response.statusCode,
          'data': decoded,
        };
      }
    } on SocketException {
      throw Exception('لا يوجد اتصال بالإنترنت.');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
