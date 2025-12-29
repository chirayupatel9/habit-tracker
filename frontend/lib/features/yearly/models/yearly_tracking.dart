import 'package:freezed_annotation/freezed_annotation.dart';

part 'yearly_tracking.freezed.dart';
part 'yearly_tracking.g.dart';

@freezed
class YearlyTrackingItem with _$YearlyTrackingItem {
  const factory YearlyTrackingItem({
    required String date, // Format: YYYY-MM-DD
    required bool tracked,
  }) = _YearlyTrackingItem;

  factory YearlyTrackingItem.fromJson(Map<String, dynamic> json) =>
      _$YearlyTrackingItemFromJson(json);
}

// Keep YearlyTracking for backward compatibility
typedef YearlyTracking = List<YearlyTrackingItem>;

