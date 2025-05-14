import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UrlLauncherFacade {
  static Future<bool> launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await url_launcher.canLaunchUrl(uri)) {
      await url_launcher.launchUrl(
        uri,
        mode: url_launcher.LaunchMode.externalApplication,
      );
      return true;
    }
    return false;
  }
}
