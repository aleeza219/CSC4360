class message{
  String messageText;
  String postby;
  String postdate;
  message({required this.messageText,
  required this.postby,required this.postdate});

  factory message.fromMap(String id, Map<String, dynamic> data) {
    return message(
      messageText: data['message'],
      postby: data['postby'],
      postdate: data['postdate']
    );
  }
}