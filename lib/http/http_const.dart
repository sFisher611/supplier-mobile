class HttpConst {
  // ignore: non_constant_identifier_names
  static String main_url = '192.168.13.36:8000';
  // ignore: non_constant_identifier_names
  static String main_url_other = 'mobilapp.ru/android';

  // ignore: non_constant_identifier_names
  static String finisher_other = 'delivery.php';
  // static String main_url_other = 'mobilapp.ru/android/';
  // ignore: non_constant_identifier_names
  static String additional = 'api/';
  static String regLogin = '${additional}users/registered';
  static String login = '${additional}login';

  static String getProduct = '${additional}work/status';
  static String getFinishedProducts = '${additional}work/info';
  static String productStatusUpdate = '${additional}work/status/update';
  static String productStatusUpdateReturn = '${additional}work/status_brought';
  static String productStatusUpdateNull = '${additional}work/status_null';
  static String evalution = '${additional}evaluation';
  static String personal = '${additional}work/amount_count';

  // ignore: non_constant_identifier_names
  static String finisherd_send_image = '${additional}work/finished';
  static String version = '${additional}version_last';
}
