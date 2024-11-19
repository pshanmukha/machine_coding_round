class Agenda {
  final List<Datum> data;
  final int status;
  final String message;

  Agenda({
    required this.data,
    required this.status,
    required this.message,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Datum> dataList = list.map((i) => Datum.fromJson(i)).toList();

    return Agenda(
      data: dataList,
      status: json['status'],
      message: json['message'],
    );
  }
}

class Datum {
  bool selected = false;
  final int eventId;
  final int topicId;
  final int conferenceId;
  final String title;
  final int sessionId;
  final DateTime startDate;
  final DateTime endDate;
  final int locationId;
  final int isShowOnagenda;
  final int isShowStarttime;
  final int isShowEndtime;
  final int isAcademic;
  final int isActive;
  final int isShowRoleOnAgenda;
  final int isStream;
  final int isQa;
  final int isCe;
  final int isCme;
  final int isRpvi;
  final String? speakerName;
  final String? speakerId;
  final String? roleName;
  final String? sortName;
  final String topicTitle;
  final String? locationName;
  final String? description;
  final String? occurs;
  final String? mainVideoUrl;
  final int mainVideoStartAt;
  final int mainVideoEndAt;
  final dynamic hospital1VideoUrl;
  final int hospital1VideoStartAt;
  final int hospital1VideoEndAt;
  final dynamic hospital2VideoUrl;
  final int hospital2VideoStartAt;
  final int hospital2VideoEndAt;
  final dynamic hospital3VideoUrl;
  final int hospital3VideoStartAt;
  final int hospital3VideoEndAt;
  final String? presentationUrl;
  final String? eventClassification;
  final int isAgenda;
  final AgendaType agendaType;
  final String? sessionTitle;
  final String imageUrl;

  Datum({
    this.selected = false,
    required this.eventId,
    required this.topicId,
    required this.conferenceId,
    required this.title,
    required this.sessionId,
    required this.startDate,
    required this.endDate,
    required this.locationId,
    required this.isShowOnagenda,
    required this.isShowStarttime,
    required this.isShowEndtime,
    required this.isAcademic,
    required this.isActive,
    required this.isShowRoleOnAgenda,
    required this.isStream,
    required this.isQa,
    required this.isCe,
    required this.isCme,
    required this.isRpvi,
    required this.speakerName,
    required this.speakerId,
    required this.roleName,
    required this.sortName,
    required this.topicTitle,
    required this.locationName,
    required this.description,
    required this.occurs,
    required this.mainVideoUrl,
    required this.mainVideoStartAt,
    required this.mainVideoEndAt,
    required this.hospital1VideoUrl,
    required this.hospital1VideoStartAt,
    required this.hospital1VideoEndAt,
    required this.hospital2VideoUrl,
    required this.hospital2VideoStartAt,
    required this.hospital2VideoEndAt,
    required this.hospital3VideoUrl,
    required this.hospital3VideoStartAt,
    required this.hospital3VideoEndAt,
    required this.presentationUrl,
    required this.eventClassification,
    required this.isAgenda,
    required this.agendaType,
    required this.sessionTitle,
    required this.imageUrl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      selected: json['selected'] ?? false,
      eventId: json['event_id'] ?? 0,
      topicId: json['topic_id'] ?? 0,
      conferenceId: json['conference_id'] ?? 0,
      title: json['title'] ?? '',
      sessionId: json['session_id'] ?? 0,
      startDate: DateTime.parse(json['start_date'] ?? DateTime.now().toString()),
      endDate: DateTime.parse(json['end_date'] ?? DateTime.now().toString()),
      locationId: json['location_id'] ?? 0,
      isShowOnagenda: json['is_show_onagenda'] ?? 0,
      isShowStarttime: json['is_show_starttime'] ?? 0,
      isShowEndtime: json['is_show_endtime'] ?? 0,
      isAcademic: json['is_academic'] ?? 0,
      isActive: json['is_active'] ?? 0,
      isShowRoleOnAgenda: json['is_show_role_on_agenda'] ?? 0,
      isStream: json['is_stream'] ?? 0,
      isQa: json['is_qa'] ?? 0,
      isCe: json['is_ce'] ?? 0,
      isCme: json['is_cme'] ?? 0,
      isRpvi: json['is_rpvi'] ?? 0,
      speakerName: json['speakerName'],
      speakerId: json['speaker_id'],
      roleName: json['role_name'],
      sortName: json['sort_name'],
      topicTitle: json['topic_title'] ?? '',
      locationName: json['locationName'] ?? '',
      description: json['description'],
      occurs: json['occurs'] ?? "Upcoming",
      mainVideoUrl: json['main_video_url'],
      mainVideoStartAt: json['main_video_start_at'] ?? 0,
      mainVideoEndAt: json['main_video_end_at'] ?? 0,
      hospital1VideoUrl: json['hospital1_video_url'],
      hospital1VideoStartAt: json['hospital1_video_start_at'] ?? 0,
      hospital1VideoEndAt: json['hospital1_video_end_at'] ?? 0,
      hospital2VideoUrl: json['hospital2_video_url'],
      hospital2VideoStartAt: json['hospital2_video_start_at'] ?? 0,
      hospital2VideoEndAt: json['hospital2_video_end_at'] ?? 0,
      hospital3VideoUrl: json['hospital3_video_url'],
      hospital3VideoStartAt: json['hospital3_video_start_at'] ?? 0,
      hospital3VideoEndAt: json['hospital3_video_end_at'] ?? 0,
      presentationUrl: json['presentation_url'],
      eventClassification: json['eventClassification'],
      isAgenda: json['is_agenda'] ?? 0,
      agendaType: AgendaType.values.firstWhere((e) => e.toString() == 'AgendaType.${json['agenda_type']}', orElse: () => AgendaType.GENERAL),
      sessionTitle: json['sessionTitle'] ?? "",
      imageUrl: json['image_url'] ?? '',
    );
  }
}

enum AgendaType {
  EVENT,
  TOPIC,
  GENERAL
}
