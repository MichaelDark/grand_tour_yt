import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../l10n/youtube_strings.dart';

class ErrorView extends StatelessWidget {
  final dynamic error;
  final VoidCallback? retry;

  const ErrorView(this.error, {super.key, this.retry});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                YoutubeStrings.of(context).errorViewHint,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              child: Text(
                error.toString(),
                textAlign: TextAlign.center,
                maxLines: 4,
                style: GoogleFonts.ubuntuMono().copyWith(
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
            if (retry != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ElevatedButton(
                  onPressed: retry,
                  child: Text(YoutubeStrings.of(context).errorViewRetryLabel),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
