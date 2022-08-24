// import 'package:http/http.dart' as http;

class Endpoints {
  Endpoints._();

  static String baseUrl = 'https://dev-api-insurance.aicycle.ai';
  static String login = baseUrl + '/assessors/login';
  static String checkExisted = baseUrl + '/assessors/check-existed';
}
