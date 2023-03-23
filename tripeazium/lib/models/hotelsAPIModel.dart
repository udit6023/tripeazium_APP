

class HotelApiModel {
  final String type;
  final String name;

  HotelApiModel({required this.name,required this.type});

  factory HotelApiModel.fromJson(dynamic json){
    return HotelApiModel(
        type: json['type'] as String,
        name: json['name'] as String
    );
  }

  static List<HotelApiModel> apiFromSnapshot(List snapshot){
    return snapshot.map((data){
        return HotelApiModel.fromJson(data);
    }).toList();
  }

  @override
  String toString(){
    return 'HotelApiModel {name: $name,type: $type}';
  }
}