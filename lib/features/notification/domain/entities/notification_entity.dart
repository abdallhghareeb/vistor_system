class NotificationEntity {
  String title;
  String id;
  String description;
  String createdAt;
  bool isRead;
  int eventType;

  NotificationEntity({
    required this.title,
    required this.id,
    required this.description,
    required this.createdAt,
    required this.isRead,
    required this.eventType,
  });
}
