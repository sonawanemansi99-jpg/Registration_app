import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DownloadQRPage extends StatelessWidget {
  const DownloadQRPage({super.key});

  @override
  Widget build(BuildContext context) {

    String name = "UserName";
    String mobile = "9876543210";
    String location = "Nashik road";

    String qrData = "Name: $name\nMobile: $mobile\nLocation: $location";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F5272),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Download QR",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: QrImageView(
                data: qrData,
                size: 250,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F5272),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Download feature only works on Android/iOS"),
                  ),
                );
              },
              child: const Text(
                "Download QR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}