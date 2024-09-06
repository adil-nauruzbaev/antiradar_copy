class SandboxModel {
  final String country;
  final double lat;
  final double long;
  final double speed;
  final String type;

  SandboxModel({
    required this.country,
    required this.lat,
    required this.long,
    required this.speed,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'lat': lat,
      'long': long,
      'speed': speed,
      'type': type,
    };
  }
}
