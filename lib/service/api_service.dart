import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const loginUrl = 'https://acvmx.coderzbot.com/admin/api/login.php';
  static const jobListBaseUrl = 'http://168.231.103.18:8080/api/get_tickets_by_employee.php?user_id=';
  static const jobDetailBaseUrl = 'http://168.231.103.18:8080/api/get_ticket_by_id.php?ticket_id=';


Future<Map<String, dynamic>> login(String username, String password) async {
  try {
    final res = await http.post(
      Uri.parse(loginUrl),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );
    print('my response${res.body}');
    return json.decode(res.body);
  } catch (e) {
    return {"status": 500, "message": "Error: $e"};
  }
}


Future<List<dynamic>> getJobs(String userId, String token) async {
  final res = await http.get(
    Uri.parse('$jobListBaseUrl$userId'),
    headers: {"Authorization": "Bearer $token"},
  );

  if (res.statusCode == 200) {
    final Map<String, dynamic> decoded = json.decode(res.body);
    return decoded["data"] as List<dynamic>;
  } else {
    return [];
  }
}



Future<Map<String, dynamic>> getJobDetail(String ticketId, String token) async {
  final res = await http.get(
    Uri.parse('$jobDetailBaseUrl$ticketId'),
    headers: {"Authorization": "Bearer $token"},
  );

  if (res.statusCode == 200) {
    return json.decode(res.body)['data']; // return only "data"
  } else {
    throw Exception("Failed to fetch job details");
  }
}

}
