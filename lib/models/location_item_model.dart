class LocationItemModel {
  final String id;
  final String city;
  final String country;
  final String imgurl;
  final bool isChosen;

  LocationItemModel({
    required this.id,
    required this.city,
    required this.country,
    this.isChosen = false,
    this.imgurl =
        'https://previews.123rf.com/images/emojoez/emojoez1903/emojoez190300018/119684277-illustrations-design-concept-location-maps-with-road-follow-route-for-destination-drive-by-gps.jpg',
  });

  LocationItemModel copyWith({
    String? id,
    String? city,
    String? country,
    String? imgurl,
    bool? isChosen,
  }) {
    return LocationItemModel(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      imgurl: imgurl ?? this.imgurl,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<LocationItemModel> dummyLocations = [
  LocationItemModel(
    id: '1',
    city: 'New York',
    country: 'USA',
  ),
  LocationItemModel(
    id: '2',
    city: 'London',
    country: 'UK',
  ),
  LocationItemModel(
    id: '3',
    city: 'Tokyo',
    country: 'Japan',
  ),
];
