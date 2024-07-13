import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:starter/core/constants/app_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

appPrint(dynamic object) => debugPrint("[${DateTime.now()}] - ${object.toString()}");
// appPrint(dynamic object){}
appPrintBeacon(dynamic object) => debugPrint("[${DateTime.now()}] - ${object.toString()}");

class AppUtils {
  AppUtils._();


  static bool isDateWithFormat({required String input, String? format}) {
    try {
      if (format.itHasValue) {
        final DateTime d = DateFormat(format).parseStrict(input);
        //print(d);
        return d.isBefore(DateTime.now());
      } else {
        if (input.isDate) {
          final DateTime d = DateTime.parse(input);
          return d.isBefore(DateTime.now());
        } else {
          return false;
        }
      }
    } catch (e) {
      //print(e);
      return false;
    }
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static DateTime? getDateTime(
      {required String input, String format = "dd/MM/yyyy"}) {
    try {
      final DateTime d = DateFormat(format).parse(input);
      //print(d);
      return d;
    } catch (e) {
      //print(e);
      return null;
    }
  }

  static DateTime? getDateTimeFromStr({required String input}) {
    try {
      List<String> list = input.trim().split("-");
      if (list.isNotEmpty && list.length == 3) {
        return DateTime(
            int.parse(list.first), int.parse(list[1]), int.parse(list[2]));
      }

      return null;
    } catch (e) {
      //print(e);
      return null;
    }
  }

  static void mockPrintAnalytics(
      {required String eventName, Map<String, dynamic>? parameters}) {
    debugPrint("* Analytics\n-Event Name:$eventName\n-Parameters :$parameters");
  }

  static int getExtendedVersionNumber(String version) {
    try{
      final _version = version.replaceAll(".", "").replaceAll("+", "");
      return int.tryParse(_version)??0;
    }catch(e){
      appPrint("getExtendedVersionNumber error $e");
      return 0;
    }
  }


  static String  getCaughtAtDateFormat(String caughtAt) {
    final DateFormat formatter = DateFormat('h:mm a');
    final DateFormat formatter2 = DateFormat('dd/MM/yyyy');

    final DateTime caughtAtDate = DateTime.parse(caughtAt).toLocal();
    final DateTime caughtAtDate2 = DateTime.parse(caughtAt).toLocal();
    final String formatted = formatter.format(caughtAtDate);
    final String formatted2 = formatter2.format(caughtAtDate2);

    return "$formatted on $formatted2";
  }

  String? toUtc(DateTime? date) => date?.toUtc().toIso8601String();

  DateTime? fromUtc(String? dateString) =>
      DateTime.tryParse(dateString ?? '')?.toLocal();

  static Function listEq = const ListEquality().equals;
  static Function deepListEq = const DeepCollectionEquality().equals;
  static Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;



 static Future<dynamic> getJsonFromAsset(
      {required String fileName, required Function converter}) async {
    final String response = await rootBundle.loadString(fileName);
    final data = await json.decode(response);
    return converter(data);
  }

  static void addValueToMap<K, V>(Map<K, List<V>> map, K key, V value) =>
      map.update(key, (list) => list..add(value), ifAbsent: () => [value]);

  static void addListValueToMap<K, V>(Map<K, List<V>> map, K key, List<V> value) =>
      map.update(key, (list) => list..addAll(value), ifAbsent: () => value);


  static void openWhatsapp(
      {required BuildContext context,
        required String text,
        required String number}) async {
    // var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid = "whatsapp://send?phone=" + number + "&text= $text";
    var whatsappURLIos = "https://wa.me/$number?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(
            Uri.parse(
              whatsappURLIos,
            ),
            mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp Not Installed!")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp Not Installed!")));
      }
    }
  }

  static Future<bool> launchEmail({
    required BuildContext context,
    required String email,
    required String subjectBody,
    required String body,
  }) async {
    try {
      if (Platform.isAndroid) {
        Uri url = Uri.parse(
          'mailto:$email?subject=$subjectBody&body=$body',
        );
        return await launchUrl(url);
      } else {
        final Uri url = Uri(
          scheme: 'mailto',
          path: email,
          query: 'subject=$subjectBody&body=$body', //add subject and body here
        );

        if (await canLaunchUrl(url)) {
          return await launchUrl(url);
        } else {
          appPrint('/***************************'
              'Could not launch $url'
              '***************************/');

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: new Text("Email is not configured!")));
          return Future.value(false);
        }
      }
    } catch (b) {
      appPrint(b.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("Email is not configured!")));
      return Future.value(false);
    }
  }
}
