import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/speech/speech_service.dart';

class AppTextField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool isPassword;
  final bool enableSpeech;
  final TextInputType keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool autofocus;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffix,
    this.isPassword = false,
    this.enableSpeech = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  ConsumerState<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends ConsumerState<AppTextField> {
  bool _obscure = true;
  bool _isDictating = false;

  @override
  Widget build(BuildContext context) {
    final speechState = ref.watch(speechProvider);
    final theme = Theme.of(context);

    Widget? suffixWidget = widget.suffix;

    if (widget.isPassword) {
      suffixWidget = IconButton(
        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => _obscure = !_obscure),
      );
    } else if (widget.enableSpeech) {
      final isListeningThis = _isDictating && speechState.isListening;
      suffixWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.suffix != null) widget.suffix!,
          IconButton(
            icon: Icon(
              isListeningThis ? Icons.mic : Icons.mic_none,
              color: isListeningThis
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
            ),
            tooltip: 'إملاء صوتي باللغة العربية',
            onPressed: () async {
              final notifier = ref.read(speechProvider.notifier);
              if (isListeningThis) {
                await notifier.stopListening();
                setState(() => _isDictating = false);
              } else {
                setState(() => _isDictating = true);
                final initialText = widget.controller.text;
                await notifier.startListening(
                  onResult: (text) {
                    final separator =
                        initialText.isEmpty || initialText.endsWith(' ')
                            ? ''
                            : ' ';
                    widget.controller.text = '$initialText$separator$text';
                    widget.controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: widget.controller.text.length),
                    );
                    if (widget.onChanged != null) {
                      widget.onChanged!(widget.controller.text);
                    }
                  },
                );
              }
            },
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          obscureText: widget.isPassword && _obscure,
          keyboardType: widget.keyboardType,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          textAlignVertical:
              widget.maxLines > 1 ? TextAlignVertical.top : null,
          validator: widget.validator,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          decoration: InputDecoration(
            hintText: widget.hint,
            alignLabelWithHint: widget.maxLines > 1,
            prefixIcon: widget.prefixIcon != null
                ? (widget.maxLines > 1
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12, right: 10, left: 8),
                        child: Icon(widget.prefixIcon),
                      )
                    : Icon(widget.prefixIcon))
                : null,
            prefixIconConstraints: widget.maxLines > 1
                ? const BoxConstraints(minWidth: 40, minHeight: 40)
                : null,
            suffixIcon: suffixWidget != null
                ? (widget.maxLines > 1
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: suffixWidget,
                      )
                    : suffixWidget)
                : null,
            suffixIconConstraints: widget.maxLines > 1
                ? const BoxConstraints(minWidth: 40, minHeight: 40)
                : null,
          ),
        ),
      ],
    );
  }
}

