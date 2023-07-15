// ignore_for_file: file_names

part of 'UtilityLibrary.dart';

class CustomeLauncher{

  static launchPhoneURL(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchPhoneSMS(String phoneNumber) async {
    String url = 'sms:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static shareApp(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      '👋🏻Hey! I discovered an amazing to-do list app that has revolutionized how I stay organized and productive.\n\n'
      '🎯If you\'re tired of forgetting important tasks or feeling overwhelmed by your busy schedule, This app is a game-changer. It\'s super user-friendly and helps me prioritize tasks, set reminders, and track my progress effortlessly.\n\n'
      '📲So, if you\'re ready to boost your productivity and take control of your to-do list, I highly recommend downloading it. Trust me, you won\'t regret it! Play Store:- https://play.google.com/store/apps/details?id=$appStoreIdValue',
        subject: "To Do Alerts",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
    );
  }
  static shareAppMsg(BuildContext context, String msg) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
        msg,
        subject: "To Do Alerts",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
    );
  }
}