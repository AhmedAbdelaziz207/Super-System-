class ProfileData {
  final String studentName;
  final String subtitle;
  final String studentCode;
  final String generalAverage;
  final String guardianName;
  final String guardianRelation;
  final String parentPhone;

  const ProfileData({
    required this.studentName,
    required this.subtitle,
    required this.studentCode,
    required this.generalAverage,
    required this.guardianName,
    required this.guardianRelation,
    required this.parentPhone,
  });

  static const ProfileData empty = ProfileData(
    studentName: '',
    subtitle: '',
    studentCode: '',
    generalAverage: '',
    guardianName: '',
    guardianRelation: '',
    parentPhone: '',
  );
}
