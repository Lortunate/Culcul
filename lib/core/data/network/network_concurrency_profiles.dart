enum NetworkConcurrencyProfile {
  upload,
  enrich,
  backgroundSync;

  int get maxConcurrency => switch (this) {
    NetworkConcurrencyProfile.upload => 3,
    NetworkConcurrencyProfile.enrich => 4,
    NetworkConcurrencyProfile.backgroundSync => 2,
  };
}
