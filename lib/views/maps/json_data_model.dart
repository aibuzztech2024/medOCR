class JsonDataModel {
  String? type;
  List<Features>? features;

  JsonDataModel({this.type, this.features});

  JsonDataModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? type;
  Properties? properties;
  Geometry? geometry;

  Features({this.type, this.properties, this.geometry});

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties =
        json['properties'] != null
            ? new Properties.fromJson(json['properties'])
            : null;
    geometry =
        json['geometry'] != null
            ? new Geometry.fromJson(json['geometry'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    return data;
  }
}

class Properties {
  String? osmType;
  int? osmId;
  String? osmKey;
  String? osmValue;
  String? type;
  String? countrycode;
  String? name;
  String? country;
  String? state;
  String? county;
  List<double>? extent;
  String? postcode;
  String? city;

  Properties({
    this.osmType,
    this.osmId,
    this.osmKey,
    this.osmValue,
    this.type,
    this.countrycode,
    this.name,
    this.country,
    this.state,
    this.county,
    this.extent,
    this.postcode,
    this.city,
  });

  Properties.fromJson(Map<String, dynamic> json) {
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    osmKey = json['osm_key'];
    osmValue = json['osm_value'];
    type = json['type'];
    countrycode = json['countrycode'];
    name = json['name'];
    country = json['country'];
    state = json['state'];
    county = json['county'];
    extent = json['extent'].cast<double>();
    postcode = json['postcode'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['osm_type'] = this.osmType;
    data['osm_id'] = this.osmId;
    data['osm_key'] = this.osmKey;
    data['osm_value'] = this.osmValue;
    data['type'] = this.type;
    data['countrycode'] = this.countrycode;
    data['name'] = this.name;
    data['country'] = this.country;
    data['state'] = this.state;
    data['county'] = this.county;
    data['extent'] = this.extent;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    return data;
  }
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
