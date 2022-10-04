import 'package:flutter/material.dart';

import '../l10n/youtube_strings.dart';

/// Navigator returns true if confirmed
class ClearHistoryConfirmationDialog extends StatelessWidget {
  const ClearHistoryConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        YoutubeStrings.of(context).clearSearchHistoryDialogTitle,
      ),
      content: Text(
        YoutubeStrings.of(context).clearSearchHistoryDialogPrompt,
      ),
      actions: [
        TextButton(
          child: Text(
            YoutubeStrings.of(context).clearSearchHistoryDialogPositiveButton,
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        TextButton(
          child: Text(
            YoutubeStrings.of(context).clearSearchHistoryDialogNegativeButton,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
