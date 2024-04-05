import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_app/model/qr_ui_response.dart';
import 'package:url_launcher/url_launcher.dart';

class QRListTile extends StatelessWidget {
  final ResponseQR responseQR;

  const QRListTile({super.key, required this.responseQR});

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final history = responseQR.message;
    final canTap = responseQR is LinkResponseQR;
    final dateFormat = localizations.formatMediumDate(history.date);
    final time = TimeOfDay.fromDateTime(history.date);
    return ListTile(
      visualDensity: const VisualDensity(vertical: -1.0),
      title: Text(history.message, maxLines: 1),
      subtitle: Text('$dateFormat ${localizations.formatTimeOfDay(time)}'),
      trailing: canTap ? const Icon(Icons.link) : null,
      onTap: canTap
          ? () async {
              await launchUrl(
                Uri.parse(history.message),
                mode: LaunchMode.externalApplication,
              );
            }
          : null,
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: history.message));
      },
      dense: true,
    );
  }
}
