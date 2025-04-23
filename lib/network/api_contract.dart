abstract class ApiContract {
  Future<String?> get(String url, [Map<String, dynamic>? query]);
}
