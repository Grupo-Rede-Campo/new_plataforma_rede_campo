import 'package:url_launcher/url_launcher.dart';

class Utils {
  static void launchUrlMethod({required String url}) async {
    final Uri _url = Uri.parse(url);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }
}
