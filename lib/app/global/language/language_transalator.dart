
import 'package:get/get.dart';
import 'package:tidybayte/app/global/language/english.dart';
import 'package:tidybayte/app/global/language/german.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "en_US": english,
    "de_DE": german,
  };
}
