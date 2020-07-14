import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  void call(String number) => launch("tel:$number");
  void sendEmail(String email) => launch("mailto:$email");
  void openUrl(String url) => launch("http:$url");
}