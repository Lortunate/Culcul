import 'package:culcul/features/video/video.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('session stack restores previous active session after pop', () {
    final coordinator = PlayerSessionCoordinator();

    final enterA = coordinator.enterSession('A');
    final enterB = coordinator.enterSession('B');
    final leaveB = coordinator.leaveSession('B');

    expect(enterA.changed, isTrue);
    expect(enterA.activeSessionId, 'A');
    expect(enterB.changed, isTrue);
    expect(enterB.activeSessionId, 'B');
    expect(leaveB.changed, isTrue);
    expect(leaveB.activeSessionId, 'A');
    expect(coordinator.isSessionActive('A'), isTrue);
  });

  test('leaving the last session clears active session', () {
    final coordinator = PlayerSessionCoordinator();

    coordinator.enterSession('A');
    final leaveA = coordinator.leaveSession('A');

    expect(leaveA.changed, isTrue);
    expect(leaveA.activeSessionId, isNull);
    expect(coordinator.sessionCount, 0);
  });

  test('new load request invalidates previous request token', () {
    final coordinator = PlayerSessionCoordinator();
    coordinator.enterSession('A');

    final token1 = coordinator.beginLoadRequest();
    final token2 = coordinator.beginLoadRequest();

    expect(
      coordinator.isLoadRequestCurrent(requestToken: token1, sessionId: 'A'),
      isFalse,
    );
    expect(
      coordinator.isLoadRequestCurrent(requestToken: token2, sessionId: 'A'),
      isTrue,
    );
  });
}

