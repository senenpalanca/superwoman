import 'dart:io';

class FileUtils {
  static String getNameFile(File f) {
    return f.path.split("/").last;
  }

  static String getExtension(File f) {
    return f.path.split(".").last;
  }

  static String getNameFileFromPath(String path) {
    return path.split("/").last;
  }

  static Future<File> writeFile(String text) async {
    File file = File('${new DateTime.now().millisecondsSinceEpoch}.csv');
    return file.writeAsString(text);
  }
}
