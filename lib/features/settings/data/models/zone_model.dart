import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/zone_entity.dart';

class ZoneModel extends ZoneEntity {
  const ZoneModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.radius,
  });
  factory ZoneModel.fromJson(Map<String, dynamic> data) {
    return ZoneModel(
      id: data['id'],
      name: data['name'],
      latitude: convertDataToNum(data['latitude']),
      longitude: convertDataToNum(data['longitude']),
      radius: convertDataToNum(data['radius']),
    );
  }
}
