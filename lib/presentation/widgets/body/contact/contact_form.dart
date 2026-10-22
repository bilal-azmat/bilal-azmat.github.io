import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _messageController;
  late TextEditingController _nameController;
  late TextEditingController _subjectController;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
    _nameController = TextEditingController();
    _subjectController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    _nameController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              style: AppStyles.s14,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              style: AppStyles.s14,
              decoration: const InputDecoration(labelText: 'E-mail'),
              validator: _validateEmail,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _subjectController,
              style: AppStyles.s14,
              decoration: const InputDecoration(labelText: 'Subject'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a subject';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              style: AppStyles.s14,
              decoration: const InputDecoration(
                labelText: 'Type a message here...',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a message';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomButton(
              label: _sending ? 'Sending…' : 'Send message',
              icon: _sending ? Icons.hourglass_top_rounded : Icons.send_rounded,
              onPressed: _sending ? null : sendEmail,
              backgroundColor: AppColors.primaryColor,
              width: double.infinity,
              height: 52,
            ),
          ],
        ),
      ),
    );
  }

  /// Sends the message through Web3Forms, which emails it to the address the
  /// access key belongs to. Replying to that email answers the visitor.
  Future<void> sendEmail() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final subject = _subjectController.text.trim();
    setState(() => _sending = true);

    var sent = false;
    try {
      final response = await html.HttpRequest.request(
        'https://api.web3forms.com/submit',
        method: 'POST',
        requestHeaders: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        sendData: jsonEncode({
          'access_key': AppConstants.web3FormsAccessKey,
          'subject': 'Portfolio: $subject',
          'from_name': name,
          'name': name,
          'email': email,
          'replyto': email,
          'message': _messageController.text.trim(),
        }),
      );
      sent = (jsonDecode(response.responseText ?? '{}') as Map)['success'] == true;
    } catch (_) {
      // Network error or a non-2xx status (bad key, rate limit).
    }

    if (!mounted) return;
    setState(() => _sending = false);
    if (sent) {
      _formKey.currentState?.reset();
      for (final c in [_nameController, _emailController, _subjectController, _messageController]) {
        c.clear();
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(sent
          ? 'Thanks, $name! Your message has been sent. I will get back to you soon.'
          : 'Sorry, your message could not be sent. Please try again or email bilalazmat021@gmail.com.'),
    ));
  }

  // Email validation function
  String? _validateEmail(String? value) {
    // Basic email regex pattern
    final emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

}
