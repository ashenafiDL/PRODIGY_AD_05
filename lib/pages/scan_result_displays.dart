import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ResBaseWidget extends StatelessWidget {
  const ResBaseWidget({super.key, required this.icon, required this.content});

  final IconData icon;
  final Widget content;

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
        content
      ],
    );
  }
}

class ResGeoPoint extends StatelessWidget {
  const ResGeoPoint({super.key, required this.geoPoint});

  final GeoPoint? geoPoint;

  @override
  Widget build(BuildContext context) {
    return ResBaseWidget(
      icon: Icons.location_on_rounded,
      content: geoPoint != null
          ? _buildLocationInfo()
          : const Text('No location found'),
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
    return ResBaseWidget(
      icon: Icons.person_rounded,
      content: contactInfo != null
          ? _buildContactInfo()
          : const Text('No contact found'),
    );
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
    return ResBaseWidget(
      icon: Icons.email_rounded,
      content: email != null ? _buildEmail() : const Text('No email found'),
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
    );
  }
}

class ResError extends StatelessWidget {
  const ResError({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResBaseWidget(
      icon: Icons.error_rounded,
      content: Center(
        child: Text('This type of QR code is not supported'),
      ),
    );
  }
}
