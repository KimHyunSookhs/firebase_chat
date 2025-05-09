import 'dart:async';

import 'package:flutter/material.dart';

import 'guest_book_message.dart';
import 'src/widgets.dart';

class GuestBook extends StatefulWidget {
  final FutureOr<void> Function(String message) addMessage;
  final List<GuestBookMessage> messages;

  const GuestBook({
    super.key,
    required this.addMessage,
    required this.messages,
  });

  @override
  State<GuestBook> createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Leave a message',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your message to continue';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    StyledButton(
                      child: Row(
                        children: const [
                          Icon(Icons.send),
                          SizedBox(width: 4),
                          Text('Send'),
                        ],
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await widget.addMessage(_controller.text);
                          _controller.clear();
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var message in widget.messages)
                      Paragraph('${message.name}: ${message.message}'),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
