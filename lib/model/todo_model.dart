class TodoData {
  TodoData({required this.task, required this.date, required this.time,required this.id});
  String task = '';
  String date = '';
  String time = '';
  String id ='';
  static fromJson(Map<String, dynamic> json) {
    return TodoData(task: json["task"]!, time: json["time"]!, date: json["date"]!
    , id: json["id"]);
  }

  Map<String, dynamic> toJson() {
    return {"task": task, "date": date, "time": time,"id":id};
  }
}
