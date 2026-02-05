import 'package:culcul/data/api/subscription_api.dart';
import 'package:culcul/domain/entities/subscription.dart';

class SubscriptionRepository {
  final SubscriptionApi _api;

  SubscriptionRepository(this._api);

  Future<Subscription> getCurrentSubscription() async {
    final response = await _api.getCurrentSubscription();
    final model = response.data!;
    return model.toEntity();
  }

  Future<List<Subscription>> getSubscriptionHistory() async {
    final response = await _api.getSubscriptionHistory();
    final models = response.data ?? [];
    return models.map((model) => model.toEntity()).toList();
  }

  Future<Subscription> subscribe(String planId) async {
    final response = await _api.subscribe({'plan_id': planId});
    final model = response.data!;
    return model.toEntity();
  }

  Future<void> cancelSubscription(String subscriptionId) async {
    await _api.cancelSubscription(subscriptionId);
  }

  Future<Subscription> renewSubscription(String subscriptionId) async {
    final response = await _api.renewSubscription(subscriptionId);
    final model = response.data!;
    return model.toEntity();
  }
}
