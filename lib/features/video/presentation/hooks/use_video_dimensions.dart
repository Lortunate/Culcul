import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_kit/media_kit.dart';

({double width, double height}) useVideoDimensions(Player player) {
  final videoWidth = useState(player.state.width ?? 0);
  final videoHeight = useState(player.state.height ?? 0);

  useEffect(() {
    final sub = player.stream.videoParams.listen((_) {
      videoWidth.value = player.state.width ?? 0;
      videoHeight.value = player.state.height ?? 0;
    });
    return sub.cancel;
  }, []);

  return (width: videoWidth.value.toDouble(), height: videoHeight.value.toDouble());
}

