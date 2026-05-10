class PlayerSessionChange {
  const PlayerSessionChange({
    required this.previousActiveSessionId,
    required this.activeSessionId,
    required this.activationVersion,
    required this.changed,
  });

  final String? previousActiveSessionId;
  final String? activeSessionId;
  final int activationVersion;
  final bool changed;
}

class PlayerSessionCoordinator {
  final List<String> _sessionStack = <String>[];
  int _activationVersion = 0;
  int _requestGeneration = 0;

  String? get activeSessionId => _sessionStack.isEmpty ? null : _sessionStack.last;
  int get activationVersion => _activationVersion;
  int get sessionCount => _sessionStack.length;

  bool isSessionActive(String sessionId) => activeSessionId == sessionId;

  PlayerSessionChange enterSession(String sessionId) {
    final previous = activeSessionId;
    _sessionStack.remove(sessionId);
    _sessionStack.add(sessionId);
    final current = activeSessionId;

    if (current != previous) {
      _activationVersion++;
      _requestGeneration++;
      return PlayerSessionChange(
        previousActiveSessionId: previous,
        activeSessionId: current,
        activationVersion: _activationVersion,
        changed: true,
      );
    }

    return PlayerSessionChange(
      previousActiveSessionId: previous,
      activeSessionId: current,
      activationVersion: _activationVersion,
      changed: false,
    );
  }

  PlayerSessionChange leaveSession(String sessionId) {
    final previous = activeSessionId;
    _sessionStack.remove(sessionId);
    final current = activeSessionId;

    if (current != previous) {
      _activationVersion++;
      _requestGeneration++;
      return PlayerSessionChange(
        previousActiveSessionId: previous,
        activeSessionId: current,
        activationVersion: _activationVersion,
        changed: true,
      );
    }

    return PlayerSessionChange(
      previousActiveSessionId: previous,
      activeSessionId: current,
      activationVersion: _activationVersion,
      changed: false,
    );
  }

  int beginLoadRequest() {
    _requestGeneration++;
    return _requestGeneration;
  }

  bool isLoadRequestCurrent({required int requestToken, required String sessionId}) {
    return _requestGeneration == requestToken && isSessionActive(sessionId);
  }
}
