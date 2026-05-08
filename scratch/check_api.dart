
import 'dart:convert';
import 'dart:io';

void main() async {
  var client = HttpClient();
  try {
    var request = await client.getUrl(Uri.parse('https://thewada.com/wada-backend/public/api/customer/getCountryCodes'));
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    print('Status code: ${response.statusCode}');
    var data = json.decode(responseBody);
    print('Status in body: ${data['status']}');
    print('Status type: ${data['status'].runtimeType}');
  } finally {
    client.close();
  }
}
