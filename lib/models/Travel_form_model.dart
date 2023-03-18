 
 class Trip {
  final int id;
   final int destinationId;
  final int userId;
  final String destinationName;
  final String name;
  final String lastName;
  final String startingTrip;
  final String endingTrip;
  final int adultNumber;
  final int childrenNumber;
  final int confirmed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TravelPlace travelPlaces;

  Trip({
    required this.id,
    required this.destinationId,
    required this.userId,
    required this.destinationName,
    required this.name,
    required this.lastName,
    required this.startingTrip,
    required this.endingTrip,
    required this.adultNumber,
    required this.childrenNumber,
    required this.confirmed,
    required this.createdAt,
    required this.updatedAt,
    required this.travelPlaces,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
      print('inside the from json');
    return Trip(
      id: json['id'],
      destinationId: json['destination_id'],
      userId: json['user_id'],
      destinationName: json['destination_name'],
      name: json['name'],
      lastName: json['last_name'],
      startingTrip: json['starting_trip'],
      endingTrip: json['ending_trip'],
      adultNumber: json['adult_number'],
      childrenNumber: json['children_number'],
      confirmed: json['confirmed'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      travelPlaces: TravelPlace.fromJson(json['travel_places']),
    );
  }
}

class TravelPlace {
  final int id;
  final String name;
  final int stars;
  final int travelTime;
  final String image;
  final String description;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String tag;
  final String latitude;
  final String longitude;

  TravelPlace({
    required this.id,
    required this.name,
    required this.stars,
    required this.travelTime,
    required this.image,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.tag,
    required this.latitude,
    required this.longitude,
  });

  factory TravelPlace.fromJson(Map<String, dynamic> json) {
  print('inside the second from json');
    return TravelPlace(
      id: json['id'],
      name: json['name'],
      stars: json['stars'],
      travelTime: json['travelTime'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      tag: json['tag'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
