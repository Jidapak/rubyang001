import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://dataapi.moc.go.th/gis-product-prices";

  Future<Map<String, dynamic>> fetchData(String productId, String fromDate, String toDate) async {
    final response = await http.get(
      Uri.parse("$baseUrl?product_id=$productId&from_date=$fromDate&to_date=$toDate"),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("Raw response body: ${response.body}");
      print("Parsed JSON response: $jsonResponse");

      if (jsonResponse is Map<String, dynamic>) {
        return jsonResponse;
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }
}
