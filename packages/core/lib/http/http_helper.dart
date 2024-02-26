import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

/// Get `http.Client` with ssl.
Future<http.Client> getSSLPinningClient() async {
  final client = HttpClient(context: await _globalContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  final ioClient = IOClient(client);
  return ioClient;
}

Future<SecurityContext> get _globalContext async {
  final sslCert = await rootBundle.load('certificates/certificates.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}
