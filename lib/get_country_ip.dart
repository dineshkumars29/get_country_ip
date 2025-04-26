import 'package:flutter/foundation.dart';
import 'package:get_country_ip/api_service/get_ip_api.dart'; // Handles fetching the user's public IP
import 'package:get_country_ip/api_service/get_location_api.dart'; // Handles looking up location based on IP

/// A service class to retrieve the user's public IP address and associated location information.
///
/// [GetCountryIp] fetches the public IP address using external services like [ipify.org] or [icanhazip.com],
/// and then looks up location details such as country, region, city, and ISP by querying IP geolocation APIs.
///
/// Example:
/// ```dart
/// final getCountryIp = GetCountryIp();
/// final locationData = await getCountryIp.getIPLocation();
/// print(locationData);
/// ```

class GetCountryIp {
  /// Retrieves the user's current public IP address and corresponding geolocation information.
  ///
  /// Returns a [Map<String, dynamic>] containing location details such as:
  /// - Country
  /// - Region
  /// - City
  /// - Latitude and Longitude
  /// - ISP and Organization
  ///
  /// Returns `null` if the IP address could not be retrieved or if the location lookup fails.
  Future<Map<String, dynamic>?> getIPLocation() async {
    final ip = await getPublicIP(); // Fetches the public IP address
    if (ip == null) return null; // Returns null if IP couldn't be retrieved

    // Uses compute to perform the location lookup in a background isolate
    final result = await compute(locationLookupWorker, ip);
    return result; // Returns the location data as a Map
  }
}
