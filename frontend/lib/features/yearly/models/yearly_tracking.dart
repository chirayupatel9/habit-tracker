import 'package:freezed_annotation/freezed_annotation.dart';

part 'yearly_tracking.freezed.dart';
part 'yearly_tracking.g.dart';

@freezed
class YearlyTracking with _$YearlyTracking {
  const factory YearlyTracking({
    required int year,
    @JsonKey(name: 'tracked_dates') required List<String> trackedDates,
  }) = _YearlyTracking;

  factory YearlyTracking.fromJson(Map<String, dynamic> json) =>
      _$YearlyTrackingFromJson(json);
}

