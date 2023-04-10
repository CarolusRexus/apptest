import '../blocs/navigation/navigation_cubit.dart';

extension ToText on Choice{
  String get toText{
    var text = toString().split('.').last;
    return text[0].toUpperCase() + text.substring(1);
  }
}