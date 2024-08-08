import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prodigy_ad_05/pages/scan_buttons.dart';
import 'package:prodigy_ad_05/pages/scan_error.dart';
import 'package:prodigy_ad_05/pages/scan_result_displays.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
    cameraResolution: const Size(640, 480),
  );
  Barcode? _barcode;

  StreamSubscription<Object?>? _subscription;

  void _handleBarcode(BarcodeCapture event) {
    if (mounted) {
      setState(() {
        _barcode = event.barcodes.firstOrNull;
      });

      if (_barcode != null) {
        unawaited(controller.stop());
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            children: [
              switch (_barcode!.type) {
                BarcodeType.geo => ResGeoPoint(geoPoint: _barcode?.geoPoint),
                BarcodeType.contactInfo =>
                  ResContactInfo(contactInfo: _barcode?.contactInfo),
                BarcodeType.email => ResEmail(email: _barcode?.email),
                BarcodeType.isbn => ResText(
                    icon: Icons.text_fields_rounded,
                    label: "ISBN",
                    value: _barcode!.displayValue),
                BarcodeType.phone => ResText(
                    icon: Icons.phone_rounded,
                    label: "Phone",
                    value: _barcode!.phone?.number),
                BarcodeType.text => ResText(
                    icon: Icons.text_fields_rounded,
                    label: "Text",
                    value: _barcode?.displayValue,
                  ),
                BarcodeType.url => ResText(
                    icon: Icons.link_rounded,
                    label: "URL",
                    value: _barcode!.url?.url,
                  ),
                // Not supported yet
                BarcodeType.wifi => const ResError(),
                BarcodeType.calendarEvent => const ResError(),
                BarcodeType.product => const ResError(),
                BarcodeType.driverLicense => const ResError(),
                BarcodeType.sms => const ResError(),
                BarcodeType.unknown => const ResError(),
              },
            ],
          ),
        ).then((_) => unawaited(controller.start()));
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscription = controller.barcodes.listen(_handleBarcode);

    unawaited(controller.start());
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: ToggleFlashlightButton(controller: controller),
        ),
        Align(
          alignment: Alignment.center,
          child: MobileScanner(
            controller: controller,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
