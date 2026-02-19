import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';

abstract class CmuPlaceRepo {
  Future<List<CmuPlaceEntity>> getCmuPlaces();
}
