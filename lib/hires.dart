class Hires {

  final int id;
  final int freelancerid;
  final int userid;

  Hires ({
    this.id, this.freelancerid, this.userid,
  });

  factory Hires.fromJson(Map<String, dynamic> json) {
    return Hires(

        id: json['id'],
        freelancerid: json['freelancerid'],
        userid: json['userid'],
    );
  }

}