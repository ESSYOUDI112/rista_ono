import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const RistaOnoApp());
}

class RistaOnoApp extends StatelessWidget {
  const RistaOnoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RISTA ONO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF121212),
          primary: const Color(0xFFD4AF37),
        ),
      ),
      home: const RistaSplashScreen(),
    );
  }
}

// ---------------------------------------------------------
// 1. شاشة الترحيب الفاخرة
// ---------------------------------------------------------
class RistaSplashScreen extends StatefulWidget {
  const RistaSplashScreen({super.key});

  @override
  State<RistaSplashScreen> createState() => _RistaSplashScreenState();
}

class _RistaSplashScreenState extends State<RistaSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        String userID = "R-${1000 + Random().nextInt(8999)}";
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RistaDashboard(myID: userID)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.all_inclusive, size: 100, color: Color(0xFFD4AF37)),
            const SizedBox(height: 20),
            const Text("RISTA ONO", style: TextStyle(fontSize: 35, color: Colors.white, letterSpacing: 10, fontWeight: FontWeight.w200)),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Color(0xFFD4AF37)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 2. لوحة التحكم الرئيسية (Dashboard)
// ---------------------------------------------------------
class RistaDashboard extends StatelessWidget {
  final String myID;
  const RistaDashboard({super.key, required this.myID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: const Text("RISTA ONO", style: TextStyle(color: Color(0xFFD4AF37))),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.admin_panel_settings, color: Color(0xFFD4AF37)),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminPanel())),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            _buildProfileHeader(),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  _menuItem(context, Icons.mic_rounded, "غرف الدردشة", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RoomsListScreen()))),
                  _menuItem(context, Icons.emoji_events_rounded, "لوحة الشرف", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LeaderboardScreen()))),
                  _menuItem(context, Icons.account_balance_wallet_rounded, "شحن النقاط", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RechargeScreen()))),
                  _menuItem(context, Icons.music_note_rounded, "الموسيقى", () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(color: Color(0xFF121212), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
      child: Column(
        children: [
          Row(children: [
            const CircleAvatar(radius: 35, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 40, color: Colors.white)),
            const SizedBox(width: 15),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("ID: $myID", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Text("المستوى الذهبي: 22 🎖️", style: TextStyle(color: Color(0xFFD4AF37))),
            ])
          ]),
          const SizedBox(height: 15),
          const LinearProgressIndicator(value: 0.85, backgroundColor: Colors.white10, color: Color(0xFFD4AF37)),
          const Align(alignment: Alignment.centerLeft, child: Text("85% خبرة", style: TextStyle(color: Colors.white38, fontSize: 10))),
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String title, VoidCallback action) {
    return InkWell(onTap: action, child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 45, color: const Color(0xFFD4AF37)), const SizedBox(height: 10), Text(title, style: const TextStyle(fontWeight: FontWeight.bold))])));
  }
}

// ---------------------------------------------------------
// 3. واجهة الغرفة (مع نظام الصوت والهدايا)
// ---------------------------------------------------------
class ChatRoomView extends StatefulWidget {
  const ChatRoomView({super.key});
  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  String? activeGift;
  bool isMusicPlaying = true;

  void _sendGift(String emoji) {
    setState(() => activeGift = emoji);
    Future.delayed(const Duration(seconds: 2), () { if (mounted) setState(() => activeGift = null); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text("غرفة الطرب الأصيل"), 
        backgroundColor: Colors.transparent, 
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(isMusicPlaying ? Icons.music_note : Icons.music_off, color: const Color(0xFFD4AF37)),
            onPressed: () => setState(() => isMusicPlaying = !isMusicPlaying),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(children: [
            if (isMusicPlaying) const LinearProgressIndicator(minHeight: 2, color: Color(0xFFD4AF37), backgroundColor: Colors.transparent),
            Expanded(child: GridView.builder(padding: const EdgeInsets.all(30), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 25), itemCount: 8, itemBuilder: (context, index) => _buildSeat(index))),
            _roomBottomBar()
          ]),
          if (activeGift != null) Center(child: Text(activeGift!, style: const TextStyle(fontSize: 120))),
        ],
      ),
    );
  }

  Widget _buildSeat(int index) {
    return Column(children: [
      CircleAvatar(radius: 28, backgroundColor: Colors.white.withOpacity(0.05), child: const Icon(Icons.mic_off, color: Colors.white24, size: 20)),
      const SizedBox(height: 5),
      Text("مقعد ${index + 1}", style: const TextStyle(color: Colors.white38, fontSize: 10)),
    ]);
  }

  Widget _roomBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20), 
      decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Row(children: [
        const Icon(Icons.message_outlined, color: Colors.white54),
        const SizedBox(width: 15),
        const Expanded(child: Text("دردشة حية...", style: TextStyle(color: Colors.white24))),
        IconButton(icon: const Icon(Icons.card_giftcard, color: Color(0xFFD4AF37), size: 30), onPressed: () => _showGifts()),
      ]),
    );
  }

  void _showGifts() {
    showModalBottomSheet(context: context, backgroundColor: const Color(0xFF1A1A1A), builder: (context) => GridView.count(crossAxisCount: 4, children: ["🌹", "🦁", "👑", "🚀", "💎", "🎸"].map((e) => IconButton(onPressed: () { Navigator.pop(context); _sendGift(e); }, icon: Text(e, style: const TextStyle(fontSize: 35)))).toList()));
  }
}

// ---------------------------------------------------------
// 4. لوحة الإدارة (Admin Panel)
// ---------------------------------------------------------
class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تحكم الإدارة"), backgroundColor: Colors.red[900], foregroundColor: Colors.white),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text("أدوات النظام", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            ListTile(leading: const Icon(Icons.person_add, color: Colors.green), title: const Text("توزيع هدايا مجانية")),
            ListTile(leading: const Icon(Icons.volume_off, color: Colors.red), title: const Text("كتم الغرفة بالكامل")),
            ListTile(leading: const Icon(Icons.update, color: Colors.blue), title: const Text("إرسال تحديث إجباري")),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// شاشات مكملة (لوحة الشرف والقوائم)
// ---------------------------------------------------------
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF121212), appBar: AppBar(title: const Text("الأساطير"), backgroundColor: Colors.transparent, foregroundColor: const Color(0xFFD4AF37)), body: const Center(child: Text("قائمة الشرف في انتظار الأبطال", style: TextStyle(color: Colors.white))));
  }
}

class RoomsListScreen extends StatelessWidget {
  const RoomsListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("قائمة الغرف")), body: ListView.builder(itemCount: 4, itemBuilder: (context, index) => ListTile(leading: const Icon(Icons.headset_mic, color: Color(0xFFD4AF37)), title: Text("غرفة ريستا للطرب #${index+1}"), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatRoomView())))));
  }
}

class RechargeScreen extends StatelessWidget {
  const RechargeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("شحن الرصيد")), body: const Center(child: Text("بوابات الدفع قيد التجهيز")));
  }
}
