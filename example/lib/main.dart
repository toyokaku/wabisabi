import 'package:flutter/material.dart';
import 'package:wabisabi/wabisabi.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: WabTheme.materialTheme(lightTheme: !isDark),
      home: Dashboard(
        isDark: isDark,
        onToggleTheme: () => setState(() => isDark = !isDark),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.isDark, required this.onToggleTheme});
  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _nav = '學習進度';
  bool _share = false;

  static const _gap = SizedBox(width: 16, height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WabTheme.backgroundColor,
      body: Column(
        children: [
          _banner(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _sidebar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 20, 20),
                    child: _content(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---- Banner -------------------------------------------------------------

  Widget _banner() => WabBanner(
        title: '茶道研習室 ・ 日誌',
        subtitle: '古遺',
        seal: _seal(),
        trailing: [
          SizedBox(
            width: 260,
            child: WabSearchField(hintText: '搜尋課程與樂筆記'),
          ),
          const SizedBox(width: 12),
          IconButton(
            tooltip: '切換主題',
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
              color: WabTheme.textColor,
            ),
            onPressed: widget.onToggleTheme,
          ),
        ],
      );

  Widget _seal() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFF9A3729),
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Text(
          '古遺',
          style: TextStyle(color: Colors.white, fontSize: 10, height: 1.1),
        ),
      );

  // ---- Sidebar ------------------------------------------------------------

  Widget _sidebar() => WabSidebar(
        children: [
          const WabProfileHeader(name: '墨竹居士', subtitle: '古遺'),
          const SizedBox(height: 20),
          for (final item in const ['主頁', '課程目錄', '學習進度', '作品集'])
            WabNavItem(
              label: item,
              selected: _nav == item,
              onTap: () => setState(() => _nav = item),
            ),
          const SizedBox(height: 20),
          WabPanel(
            title: '意見反饋',
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WabTextFormField(hintText: '請輸入您的意見...'),
                const SizedBox(height: 10),
                _LabeledDropdown(label: '反饋類型', value: '功能建議'),
                const SizedBox(height: 10),
                WabElevatedButton(text: const Text('提交'), callback: () {}),
              ],
            ),
          ),
        ],
      );

  // ---- Content grid -------------------------------------------------------

  Widget _content() => Column(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 2, child: _recentStudy()),
                _gap,
                Expanded(flex: 1, child: _courseTools()),
              ],
            ),
          ),
          _gap,
          Expanded(
            flex: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 2, child: _collection()),
                _gap,
                Expanded(flex: 1, child: _community()),
                _gap,
                Expanded(flex: 1, child: _notes()),
              ],
            ),
          ),
        ],
      );

  Widget _recentStudy() => WabPanel(
        title: '近日學習',
        expand: true,
        child: Column(
          children: [
            _studyRow('蕪茶法概論・第一章', '進行中', const WabStarRating(rating: 4)),
            WabDivider(),
            _studyRow('宋代文化史', '半歷史',
                const WabStatusBadge('完成', kind: WabBadgeKind.done)),
            WabDivider(),
            _studyRow('茶具賞析・波皮', '進行中',
                const WabStatusBadge('進行中', kind: WabBadgeKind.progress)),
          ],
        ),
      );

  Widget _studyRow(String name, String mid, Widget trailing) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(child: Text(name)),
            Expanded(
              child: Text(
                mid,
                style: TextStyle(color: WabTheme.textColor.withOpacity(0.7)),
              ),
            ),
            trailing,
          ],
        ),
      );

  Widget _courseTools() => WabPanel(
        title: '課程工具',
        expand: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                WabStatusBadge('進行中', kind: WabBadgeKind.progress),
                SizedBox(width: 10),
                WabStatusBadge('完成', kind: WabBadgeKind.done),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _payChip(Icons.account_balance_wallet, '支付寶'),
                _payChip(Icons.chat, '微信送信'),
                _payChip(Icons.credit_card, 'VISA'),
              ],
            ),
            const Spacer(),
            Text(
              '支付付元元: US\$ 15,000',
              style: TextStyle(color: WabTheme.textColor.withOpacity(0.8)),
            ),
          ],
        ),
      );

  Widget _payChip(IconData icon, String label) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: WabTheme.accentColor, size: 26),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      );

  Widget _collection() => WabPanel(
        title: '我的茶具收藏',
        expand: true,
        trailing: Row(
          children: [
            const WabStatusBadge('篩選', kind: WabBadgeKind.neutral),
            const SizedBox(width: 8),
            Icon(Icons.filter_list, color: WabTheme.textColor, size: 18),
            const SizedBox(width: 6),
            Icon(Icons.sort, color: WabTheme.textColor, size: 18),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: WabCollectionCard(
                icon: Icon(Icons.emoji_food_beverage,
                    size: 40, color: WabTheme.textColor),
                title: '建金',
                description: '曜覺鮮鮮，是任奇具有的小松短。',
                buttonLabel: '查看詳細',
                onPressed: () {},
              ),
            ),
            _gap,
            Expanded(
              child: WabCollectionCard(
                icon: Icon(Icons.coffee_maker,
                    size: 40, color: WabTheme.textColor),
                title: '次烹熟壼',
                description: '次金乳乳，茶品質漬・現現的色。',
                buttonLabel: '查看詳細',
                onPressed: () {},
              ),
            ),
            _gap,
            Expanded(
              child: WabCollectionCard(
                icon: Icon(Icons.local_cafe,
                    size: 40, color: WabTheme.textColor),
                title: '紫砂室',
                description: '紫沙臺宇宙，沙沙感的一拼充滿享。',
                buttonLabel: '提交詳細',
                highlighted: true,
                onPressed: () {},
              ),
            ),
          ],
        ),
      );

  Widget _community() => WabPanel(
        title: '社群動態',
        expand: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _communityRow('李運', '上了作品的文章・行書風步。'),
            const SizedBox(height: 16),
            _communityRow('彈彈', '評價價的筆記，在泰上生的生情。'),
          ],
        ),
      );

  Widget _communityRow(String name, String text) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: WabTheme.primaryColor,
            child: Icon(Icons.person, size: 18, color: WabTheme.accentColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: WabTheme.textColor,
                  fontSize: 13,
                  height: 1.4,
                  fontFamilyFallback: kWabSerifFallback,
                ),
                children: [
                  TextSpan(
                      text: '$name ',
                      style: TextStyle(
                          color: WabTheme.accentColor,
                          fontWeight: FontWeight.w600)),
                  TextSpan(text: text),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _notes() => WabPanel(
        title: '我的茶道心得',
        expand: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WabTextFormField(hintText: '心停標題...'),
            const SizedBox(height: 12),
            _LabeledDropdown(label: '開課程', value: '令代式'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('公開分享',
                    style: TextStyle(color: WabTheme.textColor)),
                Switch(
                  value: _share,
                  activeColor: WabTheme.accentColor,
                  onChanged: (v) => setState(() => _share = v),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: WabTextFormField(hintText: '感感分享...'),
            ),
            const SizedBox(height: 12),
            WabElevatedButton(text: const Text('提交心得'), callback: () {}),
          ],
        ),
      );
}

/// Inline labelled pseudo-dropdown used in the demo forms.
class _LabeledDropdown extends StatelessWidget {
  const _LabeledDropdown({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$label：', style: TextStyle(color: WabTheme.textColor)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: WabTheme.woodyColor.withOpacity(0.35),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: TextStyle(color: WabTheme.textColor)),
              const SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, color: WabTheme.textColor, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}
