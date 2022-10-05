class Movie {
  int id;
  String name;
  String? permalink;
  String? startDate;
  Null? endDate;
  String? country;
  String? network;
  String? status;
  String image_thumbnail_path;

  Movie({
     required this.id,
     required this.image_thumbnail_path,
     required this.name,
  });
  factory Movie.fromJson(Map<String,dynamic> json){
    return Movie(
      id:json['id'],
      image_thumbnail_path: json['image_thumbnail_path'],
      name:json['name'] ,
    );
  }
}
class Imagee {
  String medium;
  String original;

  Imagee({
    required this.medium,
    required this.original});

  factory Imagee.fromJson(Map<String, dynamic> json) {
    return Imagee(
    medium : json['medium'],
    original : json['original']
    );
  }}