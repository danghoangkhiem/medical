import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'event_type.dart';
import 'additional_field_model.dart';

class AdditionalDataModel extends Equatable {
  AdditionalFieldListModel samples;
  AdditionalFieldListModel gifts;
  AdditionalFieldListModel purchases;
  AdditionalFieldListModel pointOfSaleMaterials;

  AdditionalDataModel({
    @required this.samples,
    @required this.gifts,
    @required this.purchases,
    @required this.pointOfSaleMaterials,
  }) : super([samples, gifts, purchases, pointOfSaleMaterials]);

  AdditionalDataModel.fromJson(Map<String, dynamic> json)
      : assert(json != null),
        gifts = AdditionalFieldListModel.fromJson(json[EventType.gifts.value]),
        samples =
            AdditionalFieldListModel.fromJson(json[EventType.samples.value]),
        purchases =
            AdditionalFieldListModel.fromJson(json[EventType.purchases.value]),
        pointOfSaleMaterials = AdditionalFieldListModel.fromJson(
            json[EventType.pointOfSaleMaterials.value]);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      EventType.samples.value: samples.toJson(),
      EventType.gifts.value: gifts.toJson(),
      EventType.purchases.value: purchases.toJson(),
      EventType.pointOfSaleMaterials.value: pointOfSaleMaterials.toJson(),
    };
  }
}
