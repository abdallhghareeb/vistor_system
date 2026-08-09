import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/version_entity.dart';

class VersionModel extends VersionEntity {
  const VersionModel({
    required super.opreatorMobileAndriodVersion,
    required super.opreatorMobileIosVersion,
  });
  factory VersionModel.fromJson(Map<String, dynamic> data) {
    return VersionModel(
      opreatorMobileAndriodVersion: data['opreatorMobileAndriodVersion'],
      opreatorMobileIosVersion: data['opreatorMobileIosVersion'],
    );
  }
}
