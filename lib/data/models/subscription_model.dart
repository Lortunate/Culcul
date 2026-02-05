import 'package:culcul/domain/entities/subscription.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_model.g.dart';

@JsonSerializable()
class SubscriptionModel extends Subscription {
  SubscriptionModel({
    required super.id,
    required super.userId,
    required super.planId,
    required super.planName,
    required super.price,
    required super.currency,
    required super.startDate,
    super.endDate,
    required super.isActive,
    required super.status,
    required super.durationDays,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);

  factory SubscriptionModel.fromEntity(Subscription subscription) {
    return SubscriptionModel(
      id: subscription.id,
      userId: subscription.userId,
      planId: subscription.planId,
      planName: subscription.planName,
      price: subscription.price,
      currency: subscription.currency,
      startDate: subscription.startDate,
      endDate: subscription.endDate,
      isActive: subscription.isActive,
      status: subscription.status,
      durationDays: subscription.durationDays,
    );
  }

  Subscription toEntity() {
    return Subscription(
      id: id,
      userId: userId,
      planId: planId,
      planName: planName,
      price: price,
      currency: currency,
      startDate: startDate,
      endDate: endDate,
      isActive: isActive,
      status: status,
      durationDays: durationDays,
    );
  }
}
