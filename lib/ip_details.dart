// This class represents the details of an IP address, including location and ISP info.
class IPDetails {
  final String status; // API response status (e.g., "success", "fail")
  final String country; // Country name
  final String countryCode; // Country code (e.g., "IN")
  final String region; // Region code
  final String regionName; // Full region name (e.g., "Tamil Nadu")
  final String city; // City name
  final String zip; // Postal/ZIP code
  final String lat; // Latitude (as string)
  final String lon; // Longitude (as string)
  final String timezone; // Timezone of the location
  final String isp; // Internet service provider
  final String org; // Organization name (could be same as ISP)
  final String asInfo; // AS (Autonomous System) info
  final String query; // The queried IP address

  // Constructor for initializing all fields
  IPDetails({
    required this.status,
    required this.country,
    required this.countryCode,
    required this.region,
    required this.regionName,
    required this.city,
    required this.zip,
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.isp,
    required this.org,
    required this.asInfo,
    required this.query,
  });

  /// Factory constructor to parse JSON from ip-api.com
  factory IPDetails.fromIpApiJson(Map<String, dynamic> json) {
    return IPDetails(
      status: json['status'] as String? ?? 'fail',
      country: json['country'] as String? ?? 'NA',
      countryCode: json['countryCode'] as String? ?? 'NA',
      region: json['region'] as String? ?? 'NA',
      regionName: json['regionName'] as String? ?? 'NA',
      city: json['city'] as String? ?? 'NA',
      zip: json['zip'] as String? ?? 'NA',
      lat: json['lat']?.toString() ?? 'NA',
      lon: json['lon']?.toString() ?? 'NA',
      timezone: json['timezone'] as String? ?? 'NA',
      isp: json['isp'] as String? ?? 'NA',
      org: json['org'] as String? ?? 'NA',
      asInfo: json['as'] as String? ?? 'NA',
      query: json['query'] as String? ?? 'NA',
    );
  }

  /// Factory constructor to parse fallback JSON from iplocation.net
  factory IPDetails.fromIplocationFallback(Map<String, dynamic> json) {
    return IPDetails(
      status: (json['response_code'] as String?) == '200' ? 'success' : 'fail',
      country: json['country_name'] as String? ?? 'NA',
      countryCode: json['country_code2'] as String? ?? 'NA',
      region:
          json['country_code2'] as String? ??
          'NA', // Fallback uses country code as region
      regionName: json['regionName'] as String? ?? 'NA',
      city: json['city'] as String? ?? 'NA',
      zip: json['zip'] as String? ?? 'NA',
      lat: json['lat']?.toString() ?? 'NA',
      lon: json['lon']?.toString() ?? 'NA',
      timezone: json['timezone'] as String? ?? 'NA',
      isp: json['isp'] as String? ?? 'NA',
      org: json['isp'] as String? ?? 'NA', // Some APIs return org as ISP
      asInfo: json['as'] as String? ?? 'NA',
      query: json['ip'] as String? ?? 'NA',
    );
  }

  // Nicely formatted string output for debugging or logging
  @override
  String toString() {
    return '''
IPDetails:
  Status: $status
  Country: $country
  Country Code: $countryCode
  Region: $region
  Region Name: $regionName
  City: $city
  Zip: $zip
  Latitude: $lat
  Longitude: $lon
  Timezone: $timezone
  ISP: $isp
  Org: $org
  AS: $asInfo
  Query: $query
''';
  }
}
