class PlaceModel {
  final int placesCount;
  final List<Place> places;

  PlaceModel({
    required this.placesCount,
    required this.places,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> placesJson = json['places'];
    List<Place> places = placesJson.map((placeJson) => Place.fromJson(placeJson)).toList();

    return PlaceModel(
      placesCount: json['places_count'],
      places: places,
    );
  }
}

class Place {
  final int id;
  final String name;
  final int stars;
  final int travelTime;
  final String image;
  final String description;
  final int price;
  final double latitude ;
  final double longitude ;
  final List<Gallery> galleries;

  Place({
    required this.id,
    required this.name,
    required this.stars,
    required this.travelTime,
    required this.image,
    required this.description,
    required this.price,
    required this.galleries,
   required this.latitude,
   required this.longitude

  });

  factory Place.fromJson(Map<String, dynamic> json) {
    List<dynamic> galleriesJson = json['galeries'];
    List<Gallery> galleries =
        galleriesJson.map((galleryJson) => Gallery.fromJson(galleryJson)).toList();

    return Place(
      id: json['id'],
      name: json['name'],
      stars: json['stars'],
      travelTime: json['travelTime'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      latitude:double.parse(json['latitude']),
      longitude:double.parse(json['longitude']),
      galleries: galleries,
    );
  }
}

class Gallery {
  final int id;
  final int travelPlaceId;
  final String imageUrl;

  Gallery({
    required this.id,
    required this.travelPlaceId,
    required this.imageUrl,
 
  });

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'],
      travelPlaceId: json['travel_place_id'],
      imageUrl: json['image_url'],
    );
  }
}
