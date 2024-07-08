 
class Endpoints {
  //final StorageService _storage = StorageService();

  Endpoints._();

  // User Management Endpoints
  static const String login = '/User/LoginUser';
  static const String checkin = '/User/Checkin';
  static const String checkout = '/Attendance/Checkout';
  static const String history = '/Attendance/AttendanceByID';
}
