import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Retrieves the user's public IP address using online services.
///
/// Attempts to fetch the public IP address first from [ipify.org] (JSON response),
/// and if that fails, falls back to [icanhazip.com] (plain text response).
///
/// The [timeout] parameter controls how long each request waits before failing.
/// Returns the IP address as a [String], or `null` if both services fail.

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
    final response =
        await http.get(Uri.parse('https://icanhazip.com')).timeout(timeout);

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
