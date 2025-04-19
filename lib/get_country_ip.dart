import 'package:flutter/foundation.dart';
import 'package:get_country_ip/api_service/get_ip_api.dart'; // Handles fetching the user's public IP
import 'package:get_country_ip/api_service/get_location_api.dart'; // Handles looking up location based on IP

// This class provides functionality to get the user's public IP address
// and corresponding location information.
class GetCountryIp {
  // Returns a map containing IP and location info such as country, region, city, etc.
  Future<Map<String, dynamic>?> getIPLocation() async {
    final ip = await getPublicIP(); // Fetches the public IP address
    if (ip == null) return null; // Returns null if IP couldn't be retrieved

    // Uses compute to perform the location lookup in a background isolate
    final result = await compute(locationLookupWorker, ip);
    return result; // Returns the location data as a Map
  }
}
