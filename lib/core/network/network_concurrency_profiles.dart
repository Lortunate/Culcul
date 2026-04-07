enum NetworkConcurrencyProfile { upload, enrich, backgroundSync }

extension NetworkConcurrencyProfileX on NetworkConcurrencyProfile {
  int get maxConcurrency => switch (this) {
    NetworkConcurrencyProfile.upload => 3,
    NetworkConcurrencyProfile.enrich => 4,
    NetworkConcurrencyProfile.backgroundSync => 2,
  };
}
