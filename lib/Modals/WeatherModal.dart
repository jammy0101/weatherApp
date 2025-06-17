
class WeatherModal {
  final Location location;
  final Current current;

  WeatherModal({required this.location, required this.current});

  factory WeatherModal.fromJson(Map<String, dynamic> json) {
    return WeatherModal(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }
}

class Location {
  final String name;
  final String country;

  Location({required this.name, required this.country});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      country: json['country'],
    );
  }
}

class Current {
  final double tempC;
  final double feelslikeC;
  final double windKph;
  final int humidity;
  final double pressureMb;
  final double uv;
  final double visKm;
  final Condition condition;
  final AirQuality airQuality;

  Current({
    required this.tempC,
    required this.feelslikeC,
    required this.windKph,
    required this.humidity,
    required this.pressureMb,
    required this.uv,
    required this.visKm,
    required this.condition,
    required this.airQuality,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json['temp_c'].toDouble(),
      feelslikeC: json['feelslike_c'].toDouble(),
      windKph: json['wind_kph'].toDouble(),
      humidity: json['humidity'],
      pressureMb: json['pressure_mb'].toDouble(),
      uv: json['uv'].toDouble(),
      visKm: json['vis_km'].toDouble(),
      condition: Condition.fromJson(json['condition']),
      airQuality: AirQuality.fromJson(json['air_quality']),
    );
  }
}

class Condition {
  final String text;
  final String icon;

  Condition({required this.text, required this.icon});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
    );
  }
}

class AirQuality {
  final double pm2_5;
  final double pm10;
  final double o3;
  final double no2;
  final double co;
  final double so2;

  AirQuality({
    required this.pm2_5,
    required this.pm10,
    required this.o3,
    required this.no2,
    required this.co,
    required this.so2,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      pm2_5: (json['pm2_5'] ?? 0).toDouble(),
      pm10: (json['pm10'] ?? 0).toDouble(),
      o3: (json['o3'] ?? 0).toDouble(),
      no2: (json['no2'] ?? 0).toDouble(),
      co: (json['co'] ?? 0).toDouble(),
      so2: (json['so2'] ?? 0).toDouble(),
    );
  }
}
