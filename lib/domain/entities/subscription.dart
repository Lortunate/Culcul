class Subscription {
  final String id;
  final String userId;
  final String planId;
  final String planName;
  final double price;
  final String currency;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final String status;
  final int durationDays;

  Subscription({
    required this.id,
    required this.userId,
    required this.planId,
    required this.planName,
    required this.price,
    required this.currency,
    required this.startDate,
    this.endDate,
    required this.isActive,
    required this.status,
    required this.durationDays,
  });

  Subscription copyWith({
    String? id,
    String? userId,
    String? planId,
    String? planName,
    double? price,
    String? currency,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    String? status,
    int? durationDays,
  }) {
    return Subscription(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      planId: planId ?? this.planId,
      planName: planName ?? this.planName,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      status: status ?? this.status,
      durationDays: durationDays ?? this.durationDays,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Subscription &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          planId == other.planId &&
          planName == other.planName &&
          price == other.price &&
          currency == other.currency &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          isActive == other.isActive &&
          status == other.status &&
          durationDays == other.durationDays;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      planId.hashCode ^
      planName.hashCode ^
      price.hashCode ^
      currency.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      isActive.hashCode ^
      status.hashCode ^
      durationDays.hashCode;
}
