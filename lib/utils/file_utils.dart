// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:path_provider/path_provider.dart';

// class FileUtils {
//   static Future<String> getAppLocalPath() async {
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }

//   static Future<void> encryptAndSaveFile(
//       Uint8List data, String fileName, String key) async {
//     final path = await getAppLocalPath();
//     final file = File('$path/$fileName');
//     final encryptedData = _encryptData(data, key);
//     await file.writeAsBytes(encryptedData);
//   }

//   static Uint8List _encryptData(Uint8List data, String key) {
//     final keyBytes = utf8.encode(key);
//     final hmacSha256 = Hmac(sha256, keyBytes);
//     final digest = hmacSha256.convert(data);
//     final encryptedData = digest.bytes + data;
//     return Uint8List.fromList(encryptedData);
//   }

//   static Future<Uint8List> decryptFile(String filePath, String key) async {
//     final file = File(filePath);
//     final encryptedData = await file.readAsBytes();
//     final keyBytes = utf8.encode(key);
//     final hmacSha256 = Hmac(sha256, keyBytes);
//     final digestSize = hmacSha256.convert([]).bytes.length;
//     final digest = encryptedData.sublist(0, digestSize);
//     final data = encryptedData.sublist(digestSize);
//     final expectedDigest = hmacSha256.convert(data);
//     if (expectedDigest.bytes.toString() != digest.toString()) {
//       throw Exception('Invalid key or corrupted file');
//     }
//     return Uint8List.fromList(data);
//   }
// }
