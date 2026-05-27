// Copyright 2021 MongoDB, Inc.
// SPDX-License-Identifier: Apache-2.0

import 'package:source_span/source_span.dart';

String formatSpans(
  String message, {
  required Object? element,
  required String todo,
  SourceSpan? primarySpan,
  String? primaryLabel,
  Map<SourceSpan, String> secondarySpans = const {},
  bool color = false,
}) {
  final buffer = StringBuffer(message);
  try {
    final span = primarySpan;
    if (span != null) {
      final formatted = secondarySpans.isEmpty && primaryLabel == null
          ? span.highlight(color: color)
          : span.highlightMultiple(
              primaryLabel ?? '!',
              secondarySpans,
              color: color,
            );
      buffer
        ..write('${'\n' * 2}in: ')
        ..writeln(span.start.toolString)
        ..write(formatted);
    }
  } catch (e) {
    // Source for `element` wasn't found, it must be in a summary with no
    // associated source. We can still give the name.
    buffer.writeln('\nCause: $element $e');
  }
  if (todo.isNotEmpty) {
    buffer
      ..writeln()
      ..writeln(todo);
  }
  return buffer.toString();
}
