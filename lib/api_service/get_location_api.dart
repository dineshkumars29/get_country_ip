import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// This function performs a lookup to fetch geolocation info from an IP address.
/// It uses [compute] to run in an isolate for performance.
/// Tries `ip-api.com` first, and falls back to `iplocation.net` if needed.
Future<Map<String, dynamic>?> locationLookupWorker(String ip) async {
  try {
    // Attempt 1: Using ip-api.com to get location details for the IP
    final response = await http
        .get(Uri.parse('http://ip-api.com/json/$ip'))
        .timeout(const Duration(seconds: 5));

    // If the response is OK and the API says "success", return the data
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return data; // Primary API success
      }
    }
  } catch (e) {
    // If any error occurs (e.g., timeout, no internet), log it in debug mode
    if (kDebugMode) {
      print('[Location] ip-api.com failed: $e');
    }
  }

  // Fallback: Try iplocation.net if ip-api.com fails
  try {
    final response = await http
        .get(Uri.parse('https://api.iplocation.net/?ip=$ip'))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Normalize the fallback data to match the expected structure
      return {
        "status": data['response_code'] == "200" ? "success" : "fail",
        "country": data['country_name'] ?? "NA",
        "countryCode": data['country_code2'] ?? "NA",
        "region": data['country_code2'] ?? "NA", // Same as countryCode
        "regionName": "NA", // Not provided by this API
        "city": "NA", // Not provided by this API
        "zip": "NA", // Not provided by this API
        "lat": "NA", // Not provided by this API
        "lon": "NA", // Not provided by this API
        "timezone": "NA", // Not provided by this API
        "isp": data['isp'] ?? "NA",
        "org": data['isp'] ?? "NA", // org same as ISP
        "as": "NA", // Not available
        "query": data['ip'] ?? ip, // Use provided IP or fallback to input IP
      };
    }
  } catch (e) {
    // If fallback also fails, log the error
    if (kDebugMode) {
      print('[Location] iplocation.net failed: $e');
    }
  }

  // If both APIs fail, return null
  return null;
}
