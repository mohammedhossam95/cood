  // ignore_for_file: use_build_context_synchronously

  import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> onLaunche(String url, context) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
  
 



