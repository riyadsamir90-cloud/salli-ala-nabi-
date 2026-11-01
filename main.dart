import 'package:flutter/material.dart';

void main() => runApp(const SalLiApp());

const emerald = Color(0xFF075B46);
const emeraldLight = Color(0xFF14785D);
const gold = Color(0xFFD5AE55);
const cream = Color(0xFFF7F5EE);
const ink = Color(0xFF17352C);

class SalLiApp extends StatelessWidget {
  const SalLiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'صلّي على النبي ﷺ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: emerald,
          primary: emerald,
          secondary: gold,
          surface: cream,
        ),
        scaffoldBackgroundColor: cream,
        appBarTheme: const AppBarTheme(
          backgroundColor: cream,
          foregroundColor: ink,
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFECE7D9)),
          ),
        ),
        fontFamily: 'Arial',
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MainShell(),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selected = 0;
  int salawat = 0;
  int dailyBonusClaimed = 0;
  String nickname = 'ضيف الذكر';
  bool showOnLeaderboard = false;
  final prayers = List<bool>.filled(5, false);
  final prayerNames = ['الفجر', 'الظهر', 'العصر', 'المغرب', 'العشاء'];

  // نقاط تشجيعية محدودة، ولا تقيس الإخلاص أو قيمة العبادة.
  int get points => salawat.clamp(0, 100) + prayers.where((p) => p).length * 2 + dailyBonusClaimed;

  final titles = ['الرئيسية', 'صلواتي', 'الأذكار', 'لوحة الشرف', 'حسابي'];

  @override
  Widget build(BuildContext context) {
    final pages = [
      homePage(),
      prayersPage(),
      azkarPage(),
      honorPage(),
      profilePage(),
    ];

    return LayoutBuilder(builder: (context, constraints) {
      final wide = constraints.maxWidth >= 760;
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.auto_awesome, color: gold),
              SizedBox(width: 8),
              Text('صلّي على النبي ﷺ', style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'الإشعارات',
              onPressed: () => showMessage('الإشعارات والتذكيرات ستُفعّل في النسخة المتصلة.'),
              icon: const Icon(Icons.notifications_none_rounded),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Row(
          children: [
            if (wide)
              NavigationRail(
                selectedIndex: selected,
                onDestinationSelected: (v) => setState(() => selected = v),
                labelType: NavigationRailLabelType.all,
                backgroundColor: Colors.white,
                destinations: const [
                  NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('الرئيسية')),
                  NavigationRailDestination(icon: Icon(Icons.mosque_outlined), selectedIcon: Icon(Icons.mosque), label: Text('صلواتي')),
                  NavigationRailDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: Text('الأذكار')),
                  NavigationRailDestination(icon: Icon(Icons.emoji_events_outlined), selectedIcon: Icon(Icons.emoji_events), label: Text('لوحة الشرف')),
                  NavigationRailDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: Text('حسابي')),
                ],
              ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 920),
                  child: IndexedStack(index: selected, children: pages),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: wide
            ? null
            : NavigationBar(
                selectedIndex: selected,
                onDestinationSelected: (v) => setState(() => selected = v),
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
                  NavigationDestination(icon: Icon(Icons.mosque_outlined), selectedIcon: Icon(Icons.mosque), label: 'صلواتي'),
                  NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'الأذكار'),
                  NavigationDestination(icon: Icon(Icons.emoji_events_outlined), selectedIcon: Icon(Icons.emoji_events), label: 'الشرف'),
                  NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'حسابي'),
                ],
              ),
      );
    });
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget page(List<Widget> children) => ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: children,
      );

  Widget homePage() => page([
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [emerald, Color(0xFF0D7658), Color(0xFF164D3E)],
            ),
            boxShadow: const [BoxShadow(color: Color(0x22075B46), blurRadius: 18, offset: Offset(0, 8))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(children: [
                Icon(Icons.nightlight_round, color: gold),
                SizedBox(width: 8),
                Text('وردك اليومي', style: TextStyle(color: Color(0xFFE8D7A9))),
              ]),
              const SizedBox(height: 18),
              const Text('اللهم صلِّ وسلم\nعلى نبينا محمد ﷺ',
                  style: TextStyle(color: Colors.white, fontSize: 26, height: 1.5, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('ابدأ يومك بذكرٍ يطمئن قلبك', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: gold),
                ),
                onPressed: () => setState(() => selected = 1),
                icon: const Icon(Icons.favorite_border),
                label: const Text('ابدأ الصلاة على النبي'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(children: [
          Expanded(child: statCard('صلوات اليوم', '$salawat', Icons.favorite)),
          const SizedBox(width: 12),
          Expanded(child: statCard('نقاطك التجريبية', '$points', Icons.stars_rounded)),
        ]),
        const SizedBox(height: 22),
        sectionTitle('عداد الصلاة على النبي ﷺ', 'سجّل وردك الشخصي؛ النقاط اليومية محدودة للتشجيع فقط'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Icon(Icons.spa_outlined, color: gold, size: 34),
              Text('$salawat', style: const TextStyle(fontSize: 52, fontWeight: FontWeight.bold, color: emerald)),
              const Text('صلاة مسجلة على هذا الجهاز', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: emerald, padding: const EdgeInsets.all(16)),
                  onPressed: () => setState(() => salawat++),
                  icon: const Icon(Icons.add),
                  label: const Text('صلِّ على النبي ﷺ'),
                ),
              ),
              TextButton(
                onPressed: () => setState(() => salawat = 0),
                child: const Text('إعادة ضبط العداد'),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 18),
        sectionTitle('مكافأة الدخول اليومية', 'افتح التطبيق وابدأ يومك بذكر الله'),
        Card(
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: Color(0xFFFFF3D6), child: Icon(Icons.card_giftcard, color: gold)),
            title: const Text('هدية اليوم: 5 نقاط', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('5 نقاط تجريبية مرة واحدة في هذه الجلسة؛ يلزم خادم لضبطها يوميًا.'),
            trailing: FilledButton(
              onPressed: dailyBonusClaimed == 0
                  ? () => setState(() => dailyBonusClaimed = 5)
                  : null,
              child: Text(dailyBonusClaimed == 0 ? 'استلم' : 'تم'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        sectionTitle('مساحتك اليومية'),
        Wrap(spacing: 10, runSpacing: 10, children: [
          quickAction('متابعة الصلاة', Icons.mosque, () => setState(() => selected = 1)),
          quickAction('الأذكار', Icons.menu_book, () => setState(() => selected = 2)),
          quickAction('لوحة الشرف', Icons.emoji_events, () => setState(() => selected = 3)),
        ]),
        const SizedBox(height: 16),
        const Text('تنبيه: نموذج تجريبي؛ البيانات مؤقتة على الجهاز. النقاط محدودة للتشجيع ولا تقيس العبادة أو الإخلاص، ولا يوجد ترتيب حقيقي أو تحقق صوتي بعد.',
            style: TextStyle(fontSize: 12, color: Colors.black54)),
      ]);

  Widget prayersPage() => page([
        sectionTitle('متابعة الصلوات الخمس', 'علّم على الصلاة بعد أدائها'),
        const Text('المتابعة تذكير شخصي لك، وليست وسيلة للتحقق من العبادة أو تقييمها.'),
        const SizedBox(height: 14),
        ...List.generate(5, (i) => Card(
              child: CheckboxListTile(
                value: prayers[i],
                activeColor: emerald,
                title: Text(prayerNames[i], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(prayers[i] ? 'تم تسجيلها في متابعتك' : 'لم تُسجّل بعد'),
                secondary: Icon(Icons.mosque_outlined, color: prayers[i] ? emerald : gold),
                onChanged: (v) => setState(() => prayers[i] = v ?? false),
              ),
            )),
        Card(
          child: ListTile(
            leading: const Icon(Icons.stars, color: gold),
            title: const Text('نقاط المتابعة'),
            subtitle: Text('${prayers.where((p) => p).length} من 5 صلوات مسجلة'),
          ),
        ),
      ]);

  Widget azkarPage() => page([
        sectionTitle('الأذكار', 'اختر الورد الذي تريد متابعته'),
        azkarTile('أذكار الصباح', 'ابدأ يومك بالذكر', Icons.wb_sunny_outlined),
        azkarTile('أذكار المساء', 'اختم يومك بالذكر', Icons.nights_stay_outlined),
        azkarTile('أذكار بعد الصلاة', 'أذكار مأثورة بعد الصلوات', Icons.auto_awesome_outlined),
        azkarTile('الصلاة على النبي ﷺ', 'وردك الخاص خلال اليوم', Icons.favorite_border),
        const SizedBox(height: 12),
        const Text('هذه أقسام تمهيدية؛ ستُضاف النصوص والأعداد بعد مراجعتها من مصادر إسلامية موثوقة.',
            style: TextStyle(color: Colors.black54, fontSize: 12)),
      ]);

  Widget honorPage() => page([
        sectionTitle('لوحة الشرف الشهرية', 'مسابقة تشجيعية تتجدد كل شهر'),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: emerald, borderRadius: BorderRadius.circular(20)),
          child: const Column(children: [
            Icon(Icons.emoji_events, color: gold, size: 42),
            SizedBox(height: 8),
            Text('أهل الذكر', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)),
            Text('شهادات تقدير وألقاب شرفية للمشاركين', style: TextStyle(color: Colors.white70)),
          ]),
        ),
        const SizedBox(height: 16),
        if (showOnLeaderboard)
          rankTile('•', nickname, 'مشاركتك ظاهرة على هذا الجهاز فقط في النموذج', gold)
        else
          const Card(
            child: ListTile(
              leading: Icon(Icons.visibility_off_outlined, color: emerald),
              title: Text('مشاركتك مخفية'),
              subtitle: Text('يمكنك تفعيل الظهور باسم مستعار من صفحة حسابي.'),
            ),
          ),
        rankTile('١', 'نور الذكر', 'مثال توضيحي — وسام نجم الشهر', gold),
        rankTile('٢', 'صاحب الورد', 'مثال توضيحي — وسام صاحب الورد', const Color(0xFFB7C1C5)),
        rankTile('٣', 'محب الخير', 'مثال توضيحي — وسام محب الذكر', const Color(0xFFC78B5C)),
        const SizedBox(height: 12),
        const Text(
          'هذه أسماء ونماذج تجريبية وليست ترتيبًا حقيقيًا. النقاط تقيس المشاركة داخل التطبيق فقط، ولا تقيس التقوى أو الإخلاص أو مكانة أي شخص. لوحة مصر والعالم والشهادات الفعلية تحتاج خادمًا وحسابات ومراجعة عادلة.',
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ]);

  Widget profilePage() => page([
        sectionTitle('حسابي', 'استخدم اسمًا مستعارًا ولا تكتب اسمك الحقيقي'),
        const CircleAvatar(radius: 38, backgroundColor: emerald, child: Icon(Icons.person, color: gold, size: 42)),
        const SizedBox(height: 12),
        TextField(
          controller: TextEditingController(text: nickname)
            ..selection = TextSelection.collapsed(offset: nickname.length),
          textDirection: TextDirection.rtl,
          maxLength: 20,
          decoration: const InputDecoration(
            labelText: 'الاسم المستعار',
            hintText: 'مثال: نور الذكر',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person_outline),
          ),
          onChanged: (value) => setState(() => nickname = value.trim().isEmpty ? 'ضيف الذكر' : value.trim()),
        ),
        const SizedBox(height: 8),
        Card(
          child: SwitchListTile(
            value: showOnLeaderboard,
            activeColor: emerald,
            title: const Text('إظهار اسمي المستعار في لوحة الشرف'),
            subtitle: const Text('مغلق افتراضيًا. عند إغلاقه تظل نقاطك خاصة ولا يظهر حسابك للعامة.'),
            secondary: const Icon(Icons.visibility_outlined, color: emerald),
            onChanged: (value) => setState(() => showOnLeaderboard = value),
          ),
        ),
        const SizedBox(height: 12),
        statCard('نقاط المشاركة التجريبية', '$points', Icons.stars),
        const SizedBox(height: 12),
        const Card(
          child: ListTile(
            leading: Icon(Icons.privacy_tip_outlined, color: emerald),
            title: Text('خصوصيتك أولًا'),
            subtitle: Text('لا نعرض اسمك الحقيقي أو تسجيلاتك الصوتية. لا توجد ميزة تسجيل صوتي مفعّلة في هذا النموذج.'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.workspace_premium_outlined, color: emerald),
            title: Text('الشهادات والألقاب'),
            subtitle: Text('شهادات وألقاب شرفية غير مالية — ستُفعّل بعد إنشاء الخادم ونظام الحسابات.'),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'مهم: النقاط للمتابعة والتشجيع فقط، وليست مقياسًا للإيمان أو الإخلاص. يمكنك إخفاء حسابك في أي وقت.',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ]);

  Widget sectionTitle(String title, [String subtitle = '']) => Padding(
        padding: const EdgeInsets.only(bottom: 12, top: 6),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ink)),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: Colors.black54)),
          ],
        ]),
      );

  Widget statCard(String title, String value, IconData icon) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icon, color: gold),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: emerald)),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ]),
        ),
      );

  Widget quickAction(String label, IconData icon, VoidCallback action) => ActionChip(
        avatar: Icon(icon, color: emerald),
        label: Text(label),
        onPressed: action,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFECE7D9)),
      );

  Widget azkarTile(String title, String subtitle, IconData icon) => Card(
        child: ListTile(
          leading: CircleAvatar(backgroundColor: const Color(0xFFEAF2ED), child: Icon(icon, color: emerald)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_left),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title: ستُضاف تفاصيل الورد في المرحلة التالية.')),
          ),
        ),
      );

  Widget rankTile(String rank, String title, String badge, Color color) => Card(
        child: ListTile(
          leading: CircleAvatar(backgroundColor: color, child: Text(rank, style: const TextStyle(color: ink, fontWeight: FontWeight.bold))),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(badge),
          trailing: const Icon(Icons.workspace_premium, color: gold),
        ),
      );
}
