import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:share_plus/share_plus.dart';

class ResBaseWidget extends StatelessWidget {
  const ResBaseWidget({
    super.key,
    required this.icon,
    required this.content,
    required this.onCopy,
    required this.onShare,
  });

  final IconData icon;
  final Widget content;
  final VoidCallback onCopy;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          child: CircleAvatar(child: Icon(icon)),
        ),
        const SizedBox(height: 24.0),
        content,
        const SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onCopy,
              icon: const Icon(Icons.copy_rounded),
            ),
            IconButton(
              onPressed: onShare,
              icon: const Icon(Icons.share_rounded),
            ),
          ],
        )
      ],
    );
  }
}

class ResGeoPoint extends StatelessWidget {
  const ResGeoPoint({super.key, required this.geoPoint});

  final GeoPoint? geoPoint;

  @override
  Widget build(BuildContext context) {
    final String data = 'lat:${geoPoint?.latitude},long:${geoPoint?.longitude}';

    return ResBaseWidget(
      icon: Icons.location_on_rounded,
      content: geoPoint != null
          ? _buildLocationInfo()
          : const Text('No location found'),
      onCopy: () {
        Clipboard.setData(ClipboardData(text: data));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to clipboard!')),
        );
      },
      onShare: () {
        Share.share(data);
      },
    );
  }

  Row _buildLocationInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Latitude:', style: TextStyle(color: Colors.grey)),
              Text('Longitude:', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${geoPoint?.latitude}'),
              Text('${geoPoint?.longitude}'),
            ],
          ),
        ),
      ],
    );
  }
}

class ResContactInfo extends StatelessWidget {
  const ResContactInfo({super.key, required this.contactInfo});

  final ContactInfo? contactInfo;

  @override
  Widget build(BuildContext context) {
    final String data = _parseContactInfo(contactInfo!);
    return ResBaseWidget(
      icon: Icons.person_rounded,
      content: contactInfo != null
          ? _buildContactInfo()
          : const Text('No contact found'),
      onCopy: () {
        Clipboard.setData(ClipboardData(text: data));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to clipboard!')),
        );
      },
      onShare: () {
        Share.share(data);
      },
    );
  }

  String _parseContactInfo(ContactInfo contactInfo) {
    final StringBuffer buffer = StringBuffer();

    if (contactInfo.title != null) {
      buffer.writeln('title:${contactInfo.title}');
    }
    if (contactInfo.name != null) {
      buffer
          .writeln('name:${contactInfo.name?.first} ${contactInfo.name?.last}');
    }
    if (contactInfo.organization != null) {
      buffer.writeln('organization:${contactInfo.organization}');
    }
    if (contactInfo.addresses.isNotEmpty) {
      buffer.write('address:');
      for (var address in contactInfo.addresses) {
        buffer.write(address.addressLines.join(', '));
      }
      buffer.writeln();
    }
    if (contactInfo.phones.isNotEmpty) {
      buffer.write('phone:');
      buffer
          .writeln(contactInfo.phones.map((phone) => phone.number).join(', '));
      buffer.writeln();
    }
    if (contactInfo.urls.isNotEmpty) {
      buffer.write('URL:');
      buffer.writeln(contactInfo.urls.join(', '));
      buffer.writeln();
    }

    return buffer.toString();
  }

  Widget _buildContactInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Title:', style: TextStyle(color: Colors.grey)),
              Text('Name:', style: TextStyle(color: Colors.grey)),
              Text('organization:', style: TextStyle(color: Colors.grey)),
              Text('Address:', style: TextStyle(color: Colors.grey)),
              Text('Phone:', style: TextStyle(color: Colors.grey)),
              Text('URLs:', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${contactInfo?.title}'),
              Text('${contactInfo?.name?.first} ${contactInfo!.name?.last}'),
              Text('${contactInfo?.organization}'),
              if (contactInfo!.addresses.isNotEmpty)
                ...contactInfo!.addresses.expand(
                  (address) => address.addressLines.map((line) => Text(line)),
                ),
              if (contactInfo!.phones.isNotEmpty)
                ...contactInfo!.phones.map((phone) => Text('${phone.number}')),
              if (contactInfo!.urls.isNotEmpty)
                ...contactInfo!.urls.map((url) => Text(url)),
            ],
          ),
        ),
      ],
    );
  }
}

class ResEmail extends StatelessWidget {
  const ResEmail({super.key, required this.email});

  final Email? email;

  @override
  Widget build(BuildContext context) {
    final String data = _parseEmailInfo(email!);
    return ResBaseWidget(
      icon: Icons.email_rounded,
      content: email != null ? _buildEmail() : const Text('No email found'),
      onCopy: () {
        Clipboard.setData(ClipboardData(text: data));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to clipboard!')),
        );
      },
      onShare: () {
        Share.share(data);
      },
    );
  }

  Widget _buildEmail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Address:', style: TextStyle(color: Colors.grey)),
              Text('Subject:', style: TextStyle(color: Colors.grey)),
              Text('Body:', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${email?.address}'),
              Text('${email?.subject}'),
              Text('${email?.body}'),
            ],
          ),
        ),
      ],
    );
  }

  String _parseEmailInfo(Email email) {
    final StringBuffer buffer = StringBuffer();

    if (email.address != null) {
      buffer.writeln('address:${email.address}');
    }
    if (email.subject != null) {
      buffer.writeln('subject:${email.subject}');
    }
    if (email.body != null) {
      buffer.writeln('body:${email.body}');
    }

    return buffer.toString();
  }
}

class ResText extends StatelessWidget {
  const ResText({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String? label;
  final String? value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ResBaseWidget(
      icon: icon,
      content: label != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${label!}:',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(value!)],
                ),
              ],
            )
          : const Text('No text found'),
      onCopy: () {
        Clipboard.setData(ClipboardData(text: value!));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to clipboard!')),
        );
      },
      onShare: () {
        Share.share(value!);
      },
    );
  }
}

class ResError extends StatelessWidget {
  const ResError({super.key});

  @override
  Widget build(BuildContext context) {
    return ResBaseWidget(
      icon: Icons.error_rounded,
      content: const Center(
        child: Text('This type of QR code is not supported'),
      ),
      onCopy: () {},
      onShare: () {},
    );
  }
}
