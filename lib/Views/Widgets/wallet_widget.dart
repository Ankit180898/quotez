import 'package:flutter/material.dart';

class WalletHome extends StatelessWidget {
  const WalletHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        title: const Text('Stacked Cards'),
      ),
      body: const CardWidget(),
    );
  }
}

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.teal,
        border: Border.all(color: Colors.black.withOpacity(0.3), width: 0.5),
      ),
      child: GestureDetector(
        child: Column(
          children: [
            const AboveCardQr(
              color: Colors.teal,
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              color: Colors.teal,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 6,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          
                          Text('')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboveCardQr extends StatefulWidget {
  final double zoom;
  final Color color;
  const AboveCardQr({
    super.key,
    required this.color,
    this.zoom = 1,
  });

  @override
  State<AboveCardQr> createState() => _AboveCardQrState();
}

class _AboveCardQrState extends State<AboveCardQr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: (260 * widget.zoom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://cdn-icons-png.freepik.com/256/8176/8176383.png?semt=ais_hybrid',
                height: 30 * widget.zoom,
                width: 30 * widget.zoom,
                color: Colors.white,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Balance USD',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text('100',
                      style: TextStyle(fontSize: 20, color: Colors.white))
                ],
              ),
            ],
          ),
          SizedBox(
            height: (20 * widget.zoom),
          ),
          SizedBox(
              height: (90 * widget.zoom),
              width: double.infinity * widget.zoom,
              child: Image.network(
                'https://static-00.iconduck.com/assets.00/visa-icon-2048x628-6yzgq2vq.png',
                fit: BoxFit.fill,
              )),
          SizedBox(height: (20 * widget.zoom)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Member Name',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text('Lorem Ipsum',
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CashBack',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text('5%',
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
