import 'dart:io';



Future<bool> checkInternetConnection() async {
  bool internetStatus = false;

  try {
    final result = await (InternetAddress.lookup('google.com')
        .timeout(Duration(seconds: 4)));

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      internetStatus = true;
    }
  } on SocketException catch (_) {
    internetStatus = false;
  } catch (e) {
    if (e.toString().contains(
        'TimeoutException after 0:00:05.000000: Future not completed')) {
      internetStatus = false;
    }
  }

  return internetStatus;
}
