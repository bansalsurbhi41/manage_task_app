

class Task {
  int? id;
  String? title;
  String? description;
  String? date;
  String? time;
  int? categoryId;
  int? priority;
  int? userId;

  Task({this.id, this.title, this.description, this.date, this.time, this.categoryId, this.priority, this.userId});

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? date,
    String? time,
    int? categoryId,
    int? priority,
    int? userId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      categoryId: categoryId ?? this.categoryId,
      priority: priority ?? this.priority,
      userId: userId ?? this.userId,
    );
  }


  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    categoryId = json['categoryId'];
    priority = json['priority'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(this.id != null){
      data['id'] = id;
    }
    if(this.title != null){
      data['title'] = title;
    }
    if(this.description != null){
      data['description'] = description;
    }
    if(this.date != null){
      data['date'] = date;
    }
    if(this.time != null){
      data['time'] = time;
    }
    if(this.categoryId != null){
      data['categoryId'] = categoryId;
    }
    if(this.priority != null){
      data['priority'] = priority;
    }
    if(this.userId != null){
      data['user_id'] = userId;
    }
    return data;
  }
}