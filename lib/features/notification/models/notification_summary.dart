final class NotificationSummary {
  const NotificationSummary({
    this.at = 0,
    this.chat = 0,
    this.coin = 0,
    this.danmu = 0,
    this.favorite = 0,
    this.like = 0,
    this.recvLike = 0,
    this.recvReply = 0,
    this.reply = 0,
    this.system = 0,
    this.up = 0,
  });

  final int at;
  final int chat;
  final int coin;
  final int danmu;
  final int favorite;
  final int like;
  final int recvLike;
  final int recvReply;
  final int reply;
  final int system;
  final int up;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is NotificationSummary &&
            other.at == at &&
            other.chat == chat &&
            other.coin == coin &&
            other.danmu == danmu &&
            other.favorite == favorite &&
            other.like == like &&
            other.recvLike == recvLike &&
            other.recvReply == recvReply &&
            other.reply == reply &&
            other.system == system &&
            other.up == up;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    at,
    chat,
    coin,
    danmu,
    favorite,
    like,
    recvLike,
    recvReply,
    reply,
    system,
    up,
  );

  @override
  String toString() {
    return 'NotificationSummary(at: $at, chat: $chat, coin: $coin, '
        'danmu: $danmu, favorite: $favorite, like: $like, '
        'recvLike: $recvLike, recvReply: $recvReply, reply: $reply, '
        'system: $system, up: $up)';
  }
}
