// Generated Dart models for the country / states / cities JSON
// Usage: final countries = (jsonDecode(jsonString) as List)
//    .map((e) => Country.fromJson(e as Map<String, dynamic>)).toList();

import 'dart:convert';

class Country {
  final int id;
  final String name;
  final String iso3;
  final String iso2;
  final String numericCode;
  final String phoneCode;
  final String capital;
  final String currency;
  final String currencyName;
  final String currencySymbol;
  final String tld;
  final String nativeName;
  final String region;
  final String regionId;
  final String subregion;
  final String subregionId;
  final String nationality;
  final List<Timezone> timezones;
  final Translations translations;
  final double latitude;
  final double longitude;
  final String emoji;
  final String emojiU;
  final List<StateModel> states;

  Country({
    required this.id,
    required this.name,
    required this.iso3,
    required this.iso2,
    required this.numericCode,
    required this.phoneCode,
    required this.capital,
    required this.currency,
    required this.currencyName,
    required this.currencySymbol,
    required this.tld,
    required this.nativeName,
    required this.region,
    required this.regionId,
    required this.subregion,
    required this.subregionId,
    required this.nationality,
    required this.timezones,
    required this.translations,
    required this.latitude,
    required this.longitude,
    required this.emoji,
    required this.emojiU,
    required this.states,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json['id'] as int,
    name: json['name'] as String,
    iso3: json['iso3'] as String? ?? '',
    iso2: json['iso2'] as String? ?? '',
    numericCode: json['numeric_code'] as String? ?? '',
    phoneCode: json['phone_code'] as String? ?? '',
    capital: json['capital'] as String? ?? '',
    currency: json['currency'] as String? ?? '',
    currencyName: json['currency_name'] as String? ?? '',
    currencySymbol: json['currency_symbol'] as String? ?? '',
    tld: json['tld'] as String? ?? '',
    nativeName: json['native'] as String? ?? '',
    region: json['region'] as String? ?? '',
    regionId: json['region_id']?.toString() ?? '',
    subregion: json['subregion'] as String? ?? '',
    subregionId: json['subregion_id']?.toString() ?? '',
    nationality: json['nationality'] as String? ?? '',
    timezones: (json['timezones'] as List<dynamic>?)
        ?.map((e) => Timezone.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [],
    translations: json['translations'] != null
        ? Translations.fromJson(json['translations'] as Map<String, dynamic>)
        : Translations.empty(),
    latitude: _toDouble(json['latitude']),
    longitude: _toDouble(json['longitude']),
    emoji: json['emoji'] as String? ?? '',
    emojiU: json['emojiU'] as String? ?? '',
    states: (json['states'] as List<dynamic>?)
        ?.map((e) => StateModel.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'iso3': iso3,
    'iso2': iso2,
    'numeric_code': numericCode,
    'phone_code': phoneCode,
    'capital': capital,
    'currency': currency,
    'currency_name': currencyName,
    'currency_symbol': currencySymbol,
    'tld': tld,
    'native': nativeName,
    'region': region,
    'region_id': regionId,
    'subregion': subregion,
    'subregion_id': subregionId,
    'nationality': nationality,
    'timezones': timezones.map((t) => t.toJson()).toList(),
    'translations': translations.toJson(),
    'latitude': latitude.toString(),
    'longitude': longitude.toString(),
    'emoji': emoji,
    'emojiU': emojiU,
    'states': states.map((s) => s.toJson()).toList(),
  };
}

class Timezone {
  final String zoneName;
  final int gmtOffset;
  final String gmtOffsetName;
  final String abbreviation;
  final String tzName;

  Timezone({
    required this.zoneName,
    required this.gmtOffset,
    required this.gmtOffsetName,
    required this.abbreviation,
    required this.tzName,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
    zoneName: json['zoneName'] as String? ?? '',
    gmtOffset: json['gmtOffset'] is int
        ? json['gmtOffset'] as int
        : int.tryParse(json['gmtOffset']?.toString() ?? '0') ?? 0,
    gmtOffsetName: json['gmtOffsetName'] as String? ?? '',
    abbreviation: json['abbreviation'] as String? ?? '',
    tzName: json['tzName'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'zoneName': zoneName,
    'gmtOffset': gmtOffset,
    'gmtOffsetName': gmtOffsetName,
    'abbreviation': abbreviation,
    'tzName': tzName,
  };
}

class Translations {
  final Map<String, String> values;

  Translations(this.values);

  factory Translations.fromJson(Map<String, dynamic> json) => Translations(
      json.map((key, value) => MapEntry(key, value?.toString() ?? '')));

  Map<String, dynamic> toJson() => values;

  factory Translations.empty() => Translations({});
}

class StateModel {
  final int id;
  final String name;
  final String stateCode;
  final double latitude;
  final double longitude;
  final String? type;
  final List<City> cities;

  StateModel({
    required this.id,
    required this.name,
    required this.stateCode,
    required this.latitude,
    required this.longitude,
    this.type,
    required this.cities,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    id: json['id'] as int,
    name: json['name'] as String? ?? '',
    stateCode: json['state_code'] as String? ?? '',
    latitude: _toDouble(json['latitude']),
    longitude: _toDouble(json['longitude']),
    type: json['type'] as String?,
    cities: (json['cities'] as List<dynamic>?)
        ?.map((e) => City.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'state_code': stateCode,
    'latitude': latitude.toString(),
    'longitude': longitude.toString(),
    'type': type,
    'cities': cities.map((c) => c.toJson()).toList(),
  };
}

class City {
  final int id;
  final String name;
  final double latitude;
  final double longitude;

  City({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json['id'] as int,
    name: json['name'] as String? ?? '',
    latitude: _toDouble(json['latitude']),
    longitude: _toDouble(json['longitude']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'latitude': latitude.toString(),
    'longitude': longitude.toString(),
  };
}

double _toDouble(dynamic val) {
  if (val == null) return 0.0;
  if (val is double) return val;
  if (val is int) return val.toDouble();
  if (val is String) {
    return double.tryParse(val) ?? 0.0;
  }
  return 0.0;
}

// Example helper for parsing the provided JSON string
List<Country> parseCountries(String jsonString) {
  final data = jsonDecode(jsonString) as List<dynamic>;
  return data.map((e) => Country.fromJson(e as Map<String, dynamic>)).toList();
}

// Example: encode back to JSON
String countriesToJson(List<Country> countries) =>
    jsonEncode(countries.map((c) => c.toJson()).toList());


class CountryModel {
  String country;
  List<String> states;

  CountryModel({required this.country, required this.states});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      country: json['country'],
      states: List<String>.from(json['states']),
    );
  }
}
