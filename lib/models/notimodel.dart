List<NotificationModel> notiFromJson(dynamic str) => List<NotificationModel>.from(
    (str).map(
          (x)=>NotificationModel.fromJson(x),
    ));



class NotificationModel {

  final String id;
  final String title;
  final String body;
  final String uid;
  final String date;



  NotificationModel({required this.id, required this.title, required this.body, required this.uid,required this.date, });

  factory NotificationModel.fromJson(Map<String,dynamic> json){


    return NotificationModel(
      id: json['noti_id'],
      title: json['title'],
      body: json['body'],
      uid: json['user_id'],
      date: json['date'],
    );
  }

}





