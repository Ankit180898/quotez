import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import '../Controllers/home_page_controller.dart';
import '../Controllers/theme_controller.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

class QuoteDisplayScreen extends StatefulWidget {
  const QuoteDisplayScreen({super.key});

  @override
  State<QuoteDisplayScreen> createState() => _QuoteDisplayScreenState();
}

class _QuoteDisplayScreenState extends State<QuoteDisplayScreen> {
  final HomePageController controller = Get.find<HomePageController>();
  final ThemeController themeController = Get.find<ThemeController>();

  late String author;
  late String quote;
  late String category;
  final RxBool playing = false.obs;
  final GlobalKey previewDisplayContainer = GlobalKey();

  final FlutterTts ftts = FlutterTts();

  @override
  void initState() {
    super.initState();
    List<Map<String, String?>> data =
        Get.arguments as List<Map<String, String?>>;
    author = data[0]['first'] ?? '';
    quote = data[1]['second'] ?? '';
    category = data[2]['third'] ?? '';
  }

  @override
  void dispose() {
    ftts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: themeController.isDarkMode.isFalse
                ? const Color(0xFF4051A9)
                : Colors.black12,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: themeController.isDarkMode.isFalse
              ? const LinearGradient(
                  colors: [Color(0xFF4051A9), Color(0xFF9354B9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.9])
              : null,
          color: themeController.isDarkMode.isTrue ? Colors.black12 : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: RepaintBoundary(
                  key: previewDisplayContainer,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.format_quote,
                              size: 40,
                              color: Colors.amberAccent,
                            ),
                            Text(
                              quote,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.spaceMono(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                '- $author',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.amberAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(
                        Icons.share, () => _captureSocialPng('')),
                    _buildActionButton(Icons.copy, _copyToClipboard),
                    // _buildActionButton(Icons.volume_up_rounded, Colors.orange, _toggleSpeech),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // backgroundColor: color,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
      ),
      child: Icon(icon),
    );
  }

  Future<void> _captureSocialPng(String name) async {
    List<String> imagePaths = [];
    final RenderBox box = context.findRenderObject() as RenderBox;
    return Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary? boundary = previewDisplayContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      final directory = (await getApplicationDocumentsDirectory());
      final String path = directory.path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File('$path/$name.png');
      imagePaths.add(imgFile.path);
      imgFile.writeAsBytes(pngBytes).then((value) async {
        await Share.shareFiles(imagePaths,
            subject: 'Share',
            text: 'Check this Out!',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }).catchError((onError) {});
    });
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: quote)).then((_) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Copied to your clipboard!')));
    });
  }

  Future<void> _toggleSpeech() async {
    if (playing.value == false) {
      await ftts.speak(quote);
      playing.value = true;
    } else {
      await ftts.stop();
      playing.value = false;
    }
  }
}
