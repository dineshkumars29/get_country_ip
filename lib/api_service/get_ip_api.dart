import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Retrieves the user's public IP address using two online services.
/// First tries [ipify.org], then falls back to [icanhazip.com] if needed.
/// The request will timeout after [timeout] duration (default is 5 seconds).
Future<String?> getPublicIP({
  Duration timeout = const Duration(seconds: 5),
}) async {
  String? ip;

  // Attempt 1: Use ipify API to get public IP in JSON format
  try {
    final response = await http
        .get(Uri.parse('https://api.ipify.org?format=json'))
        .timeout(timeout); // Set timeout for the request

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Parse JSON response
      ip = data['ip']; // Extract IP from the response

      // If IP is valid and not empty, return it
      if (ip != null && ip.isNotEmpty) {
        return ip;
      }
    }
  } catch (e) {
    // Log error if ipify fails, only in debug mode
    if (kDebugMode) {
      print('[IP] ipify failed: $e');
    }
  }

  // Fallback: Use icanhazip.com (returns plain text IP)
  try {
    final response = await http
        .get(Uri.parse('https://icanhazip.com'))
        .timeout(timeout);

    if (response.statusCode == 200) {
      ip = response.body.trim(); // Trim newline or extra spaces
      return ip;
    }
  } catch (e) {
    // Log error if icanhazip fails, only in debug mode
    if (kDebugMode) {
      print('[IP] icanhazip failed: $e');
    }
  }

  // If both services fail, return null
  return null;
}
