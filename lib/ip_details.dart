/// Represents detailed information about an IP address, including location and ISP.
///
/// The [IPDetails] class is used to parse and hold information retrieved from
/// geolocation APIs such as [ip-api.com] and [iplocation.net]. It includes
/// details like country, city, ISP, latitude, longitude, and more.
class IPDetails {
  /// API response status (e.g., "success" or "fail").
  final String status;

  /// Country name (e.g., "India").
  final String country;

  /// ISO country code (e.g., "IN").
  final String countryCode;

  /// Region code (e.g., "TN" for Tamil Nadu).
  final String region;

  /// Full region/state name (e.g., "Tamil Nadu").
  final String regionName;

  /// City name.
  final String city;

  /// Postal or ZIP code.
  final String zip;

  /// Latitude coordinate (as a string).
  final String lat;

  /// Longitude coordinate (as a string).
  final String lon;

  /// Timezone identifier (e.g., "Asia/Kolkata").
  final String timezone;

  /// Internet Service Provider name.
  final String isp;

  /// Organization name (could be the same as ISP).
  final String org;

  /// Autonomous System (AS) information.
  final String asInfo;

  /// The queried IP address.
  final String query;

  /// Creates a new [IPDetails] instance with all required fields.
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

  /// Creates an [IPDetails] instance from a JSON response from [ip-api.com].
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

  /// Creates an [IPDetails] instance from a fallback JSON response from [iplocation.net].
  factory IPDetails.fromIplocationFallback(Map<String, dynamic> json) {
    return IPDetails(
      status: (json['response_code'] as String?) == '200' ? 'success' : 'fail',
      country: json['country_name'] as String? ?? 'NA',
      countryCode: json['country_code2'] as String? ?? 'NA',
      region: json['country_code2'] as String? ??
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

  /// Returns a formatted string representation of the [IPDetails] instance.
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
