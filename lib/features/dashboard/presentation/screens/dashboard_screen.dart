import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../cases/presentation/providers/cases_provider.dart';
import '../../../clients/presentation/providers/clients_provider.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  DateTime _visibleMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  bool _isWeeklyView = false;
  late DateTime _currentWeekStart;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final satOffset = (now.weekday + 1) % 7;
    _currentWeekStart = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: satOffset));
  }

  static const List<String> _weekDays = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];

  static const List<String> _arabicMonths = [
    '',
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ];

  int _firstDayOffset(DateTime monthDate) {
    // Saturday = 0, Sunday = 1, ..., Friday = 6
    return (monthDate.weekday + 1) % 7;
  }

  int _daysInMonth(DateTime monthDate) {
    return DateTime(monthDate.year, monthDate.month + 1, 0).day;
  }

  void _previousPeriod() {
    setState(() {
      if (_isWeeklyView) {
        _currentWeekStart = _currentWeekStart.subtract(const Duration(days: 7));
        _visibleMonth =
            DateTime(_currentWeekStart.year, _currentWeekStart.month, 1);
      } else {
        _visibleMonth =
            DateTime(_visibleMonth.year, _visibleMonth.month - 1, 1);
      }
    });
  }

  void _nextPeriod() {
    setState(() {
      if (_isWeeklyView) {
        _currentWeekStart = _currentWeekStart.add(const Duration(days: 7));
        _visibleMonth =
            DateTime(_currentWeekStart.year, _currentWeekStart.month, 1);
      } else {
        _visibleMonth =
            DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1);
      }
    });
  }

  void _toggleCalendarView(bool isWeekly) {
    setState(() {
      _isWeeklyView = isWeekly;
      if (_isWeeklyView) {
        final selectedDate = ref.read(selectedCalendarDateProvider);
        final satOffset = (selectedDate.weekday + 1) % 7;
        _currentWeekStart =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
                .subtract(Duration(days: satOffset));
        _visibleMonth =
            DateTime(_currentWeekStart.year, _currentWeekStart.month, 1);
      }
    });
  }

  Future<void> _showAddQuickEventDialog(DateTime selectedDate) async {
    final titleCtrl = TextEditingController();
    bool isHearing = false;
    String? selectedCaseId;
    String? selectedClientId;

    final casesList = await ref.read(casesRepositoryProvider).getAllCases();
    final clientsList = await ref.read(clientsRepositoryProvider).getAllClients();

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'إضافة موعد ليوم: ${AppDateFormatter.formatDate(selectedDate)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // نوع الموعد (مهمة قضائية أو جلسة محاكمة)
                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(
                        value: false,
                        label: Text('مهمة / عمل قضائي'),
                        icon: Icon(Icons.assignment_outlined),
                      ),
                      ButtonSegment(
                        value: true,
                        label: Text('جلسة محاكمة'),
                        icon: Icon(Icons.event_seat),
                      ),
                    ],
                    selected: {isHearing},
                    onSelectionChanged: (val) {
                      setSheetState(() => isHearing = val.first);
                    },
                  ),
                  const SizedBox(height: 14),

                  AppTextField(
                    controller: titleCtrl,
                    label: isHearing
                        ? 'العمل المطلوب في الجلسة *'
                        : 'بيان المهمة أو العمل القضائي *',
                    hint: isHearing
                        ? 'مثال: تقديم دفوع / استجواب شهود / مرافعة'
                        : 'مثال: مراجعة ديوان المحكمة / استخراج قيد عقاري',
                    autofocus: true,
                  ),
                  const SizedBox(height: 12),

                  if (isHearing) ...[
                    if (casesList.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'تنبيه: لا توجد قضايا مسجلة بعد لقيد الجلسة عليها. يرجى قيد قضية أولاً.',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      )
                    else ...[
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'الموكل والقضية * (إلزامي للجلسة)',
                          prefixIcon: Icon(Icons.gavel, color: Colors.blue),
                        ),
                        items: casesList
                            .map((c) => DropdownMenuItem(
                                  value: c.id,
                                  child: Text(
                                    'أساس ${c.caseNumber} / ${c.caseYear} - ${c.title}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        onChanged: (v) => setSheetState(() => selectedCaseId = v),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ],

                  if (!isHearing && clientsList.isNotEmpty) ...[
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'ربط بموكل محدد (اختياري)',
                        prefixIcon: Icon(Icons.person),
                      ),
                      items: clientsList
                          .map((cl) => DropdownMenuItem(
                                value: cl.id,
                                child: Text(cl.fullName,
                                    overflow: TextOverflow.ellipsis),
                              ))
                          .toList(),
                      onChanged: (v) =>
                          setSheetState(() => selectedClientId = v),
                    ),
                    const SizedBox(height: 12),
                  ],

                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (titleCtrl.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isHearing
                                ? 'يرجى كتابة العمل المطلوب في الجلسة أولاً'
                                : 'يرجى كتابة بيان المهمة أولاً'),
                          ),
                        );
                        return;
                      }

                      if (isHearing && (selectedCaseId == null || selectedCaseId!.isEmpty)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تحديد الموكل والقضية إلزامي لتسجيل جلسة محاكمة'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      await ref.read(dashboardRepositoryProvider).addQuickEvent(
                            date: selectedDate,
                            title: titleCtrl.text.trim(),
                            isHearing: isHearing,
                            caseId: selectedCaseId,
                            clientId: selectedClientId,
                          );
                      if (context.mounted) {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isHearing
                                ? 'تمت إضافة الجلسة القضائية للتقويم بنجاح'
                                : 'تمت إضافة المهمة للتقويم بنجاح'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('حفظ الموعد في التقويم'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDate = ref.watch(selectedCalendarDateProvider);
    final daysWithEventsAsync =
        ref.watch(dashboardDaysWithEventsStreamProvider(_visibleMonth));
    final agendaAsync =
        ref.watch(dashboardAgendaStreamProvider(selectedDate));
    final caseListItemsAsync = ref.watch(caseListItemsStreamProvider);

    final daysWithEvents = daysWithEventsAsync.value ?? {};
    final daysInMonth = _daysInMonth(_visibleMonth);
    final firstDayOffset = _firstDayOffset(_visibleMonth);
    final today = DateTime.now().day;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 14,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: theme.colorScheme.primary.withAlpha(70),
                  width: 1.2,
                ),
              ),
              child: Icon(
                Icons.balance,
                size: 22,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    AppStrings.appSubtitle,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      color: theme.brightness == Brightness.dark
                          ? Colors.grey.shade300
                          : Colors.grey.shade700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'الإعدادات',
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          // 1. التقويم القضائي التفاعلي في أعلى الصفحة
          AppCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // رأس التقويم: الشهر والسنة والتنقل وزر التبديل شهري / أسبوعي
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      tooltip: _isWeeklyView ? 'الأسبوع السابق' : 'الشهر السابق',
                      onPressed: _previousPeriod,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          _isWeeklyView
                              ? 'أسبوع ${_currentWeekStart.day} ${_arabicMonths[_currentWeekStart.month]} ${_currentWeekStart.year}'
                              : '${_arabicMonths[_visibleMonth.month]} ${_visibleMonth.year}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      tooltip: _isWeeklyView ? 'الأسبوع القادم' : 'الشهر القادم',
                      onPressed: _nextPeriod,
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: 145,
                      child: SegmentedButton<bool>(
                        showSelectedIcon: false,
                        style: ButtonStyle(
                          visualDensity: VisualDensity.compact,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 4)),
                        ),
                        segments: const [
                          ButtonSegment(
                            value: false,
                            label: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('شهري',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          ButtonSegment(
                            value: true,
                            label: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('أسبوعي',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                        selected: {_isWeeklyView},
                        onSelectionChanged: (set) =>
                            _toggleCalendarView(set.first),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // زر إضافة مهمة/جلسة لهذا اليوم
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () => _showAddQuickEventDialog(selectedDate),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withAlpha(20),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: theme.colorScheme.primary.withAlpha(60)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_task,
                              size: 18, color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'إضافة مهمة / جلسة لهذا اليوم +',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // العرض الأسبوعي أو الشهري
                if (_isWeeklyView) ...[
                  // عرض أسبوعي رحب وواضح
                  Row(
                    children: List.generate(7, (index) {
                      final cellDate =
                          _currentWeekStart.add(Duration(days: index));
                      final dayNumber = cellDate.day;
                      final dayName = _weekDays[index];
                      final isWeekend = dayName == 'الجمعة';
                      final isSelected = cellDate.year == selectedDate.year &&
                          cellDate.month == selectedDate.month &&
                          cellDate.day == selectedDate.day;
                      final isCellToday =
                          cellDate.year == DateTime.now().year &&
                              cellDate.month == DateTime.now().month &&
                              cellDate.day == today;
                      final hasEvents = daysWithEvents.contains(dayNumber) &&
                          cellDate.month == _visibleMonth.month;

                      Color bgColor;
                      Color borderColor;
                      Color textColor;
                      Color dayNameColor;

                      if (isSelected) {
                        bgColor = theme.colorScheme.primary;
                        borderColor = theme.colorScheme.primary;
                        textColor = Colors.white;
                        dayNameColor = Colors.white.withAlpha(220);
                      } else if (hasEvents) {
                        bgColor = theme.brightness == Brightness.dark
                            ? Colors.amber.shade900.withAlpha(75)
                            : Colors.amber.shade100;
                        borderColor = Colors.amber.shade700;
                        textColor = theme.brightness == Brightness.dark
                            ? Colors.amber.shade200
                            : Colors.amber.shade900;
                        dayNameColor = textColor;
                      } else if (isCellToday) {
                        bgColor = theme.colorScheme.primary.withAlpha(25);
                        borderColor = theme.colorScheme.primary;
                        textColor = theme.colorScheme.primary;
                        dayNameColor = theme.colorScheme.primary;
                      } else {
                        bgColor = theme.brightness == Brightness.dark
                            ? theme.colorScheme.surfaceContainerHigh
                            : Colors.grey.shade50;
                        borderColor = theme.dividerColor.withAlpha(40);
                        textColor = theme.textTheme.bodyLarge?.color ??
                            Colors.black87;
                        dayNameColor =
                            isWeekend ? Colors.red.shade400 : theme.hintColor;
                      }

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(selectedCalendarDateProvider.notifier)
                                  .state = cellDate;
                              if (hasEvents) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'يوم ${cellDate.day}/${cellDate.month}: يوجد مواعيد مسجلة (معروضة بالأسفل)'),
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 86),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 1),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: borderColor,
                                  width: isSelected || isCellToday ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      dayName,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: dayNameColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '$dayNumber',
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  if (hasEvents)
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.white
                                              : (theme.brightness ==
                                                      Brightness.dark
                                                  ? Colors.amber.shade700
                                                  : Colors.amber.shade800),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'موعد',
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? theme.colorScheme.primary
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    const SizedBox(height: 14),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ] else ...[
                  // أسماء أيام الأسبوع في العرض الشهري
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _weekDays.map((dayName) {
                      final isWeekend = dayName == 'الجمعة';
                      return Expanded(
                        child: Center(
                          child: Text(
                            dayName,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isWeekend
                                  ? Colors.red.shade400
                                  : theme.hintColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Divider(height: 16),

                  // شبكة أيام التقويم الشهري
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: firstDayOffset + daysInMonth,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 1.15,
                    ),
                    itemBuilder: (context, index) {
                      if (index < firstDayOffset) {
                        return const SizedBox.shrink();
                      }

                      final cellDate = DateTime(_visibleMonth.year,
                          _visibleMonth.month, index - firstDayOffset + 1);

                      final dayNumber = cellDate.day;
                      final isSelected = cellDate.year == selectedDate.year &&
                          cellDate.month == selectedDate.month &&
                          cellDate.day == selectedDate.day;
                      final isCellToday =
                          cellDate.year == DateTime.now().year &&
                              cellDate.month == DateTime.now().month &&
                              cellDate.day == today;
                      final hasEvents = cellDate.month == _visibleMonth.month &&
                          daysWithEvents.contains(dayNumber);

                      Color bgColor;
                      Color borderColor;
                      Color textColor;

                      if (isSelected) {
                        bgColor = theme.colorScheme.primary;
                        borderColor = theme.colorScheme.primary;
                        textColor = Colors.white;
                      } else if (hasEvents) {
                        bgColor = theme.brightness == Brightness.dark
                            ? Colors.amber.shade900.withAlpha(75)
                            : Colors.amber.shade100;
                        borderColor = Colors.amber.shade700;
                        textColor = theme.brightness == Brightness.dark
                            ? Colors.amber.shade200
                            : Colors.amber.shade900;
                      } else if (isCellToday) {
                        bgColor = theme.colorScheme.primary.withAlpha(25);
                        borderColor = theme.colorScheme.primary;
                        textColor = theme.colorScheme.primary;
                      } else {
                        bgColor = Colors.transparent;
                        borderColor = Colors.transparent;
                        textColor = theme.textTheme.bodyMedium?.color ??
                            Colors.black87;
                      }

                      return InkWell(
                        onTap: () {
                          ref
                              .read(selectedCalendarDateProvider.notifier)
                              .state = cellDate;
                          if (hasEvents) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'يوم ${cellDate.day}/${cellDate.month}: يوجد مواعيد مسجلة (معروضة بالأسفل)'),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: borderColor,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$dayNumber',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      isSelected || isCellToday || hasEvents
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                  color: textColor,
                                ),
                              ),
                              if (hasEvents)
                                Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.amber.shade700,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 2. إشعارات وجدول أعمال اليوم المحدد (اسم الموكل ونوع القضية - ينقر ليفتح ملف الموكل)
          Row(
            children: [
              const Icon(Icons.notifications_active,
                  color: Colors.deepOrange, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'جدول أعمال يوم: ${AppDateFormatter.formatDate(selectedDate)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          agendaAsync.when(
            data: (agendaItems) {
              if (agendaItems.isEmpty) {
                return AppCard(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.event_available,
                            size: 32, color: theme.hintColor),
                        const SizedBox(height: 6),
                        Text(
                          'لا توجد جلسات أو أعمال مسجلة لهذا اليوم',
                          style: TextStyle(color: theme.hintColor, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'اضغط على زر الإضافة أعلاه لإضافة مهمة أو جلسة لهذا اليوم',
                          style: TextStyle(
                              color: theme.hintColor.withAlpha(160),
                              fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: agendaItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AppCard(
                      onTap: () {
                        // "عندما يضغط على الاشعار الذي يحوي على اسم الموكل ونوع القضية يفتح ملف الموكل"
                        if (item.clientId != null) {
                          context.push('/clients/${item.clientId}');
                        } else if (item.caseId != null) {
                          context.push('/cases/${item.caseId}');
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: item.isHearing
                                  ? Colors.teal.withAlpha(30)
                                  : Colors.amber.withAlpha(30),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              item.isHearing
                                  ? Icons.event_seat
                                  : Icons.assignment_outlined,
                              color: item.isHearing
                                  ? Colors.teal
                                  : Colors.amber.shade800,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // اسم الموكل فقط (بدون كلمة "الموكل:")
                                Row(
                                  children: [
                                    const Icon(Icons.person,
                                        size: 16, color: Colors.blue),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        item.clientName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),

                                // نوع القضية فقط (بدون رقم الأساس)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary
                                        .withAlpha(25),
                                    borderRadius:
                                        BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    item.caseType,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),

                                // بيان العمل المطلوب
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                if (item.courtName != null) ...[
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.account_balance,
                                          size: 13, color: theme.hintColor),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          item.courtName!,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: theme.hintColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Column(
                            children: [
                              AppStatusBadge(label: item.status),
                              const SizedBox(height: 8),
                              const Icon(Icons.arrow_forward_ios,
                                  size: 14, color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e, _) => Text('تعذر تحميل جدول اليوم: $e'),
          ),
          const SizedBox(height: 20),

          // 3. القضايا الحالية (خانة تظهر 5 قضايا مع إمكانية التمرير لرؤية البقية)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'القضايا الحالية قيد النظر',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () => context.go('/cases'),
                icon: const Icon(Icons.gavel, size: 16),
                label: const Text('عرض كافة القضايا'),
              ),
            ],
          ),
          const SizedBox(height: 8),

          caseListItemsAsync.when(
            data: (allCases) {
              final activeCases = allCases
                  .where((c) =>
                      c.caseItem.status == 'OPEN' ||
                      c.caseItem.status == 'PENDING' ||
                      c.caseItem.status == 'APPEALED')
                  .toList();

              if (activeCases.isEmpty) {
                return AppCard(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Icon(Icons.folder_open,
                              size: 36, color: theme.hintColor),
                          const SizedBox(height: 8),
                          const Text('لا توجد قضايا حالية مفتوحة'),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () => context.push('/cases/new'),
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('قيد أول قضية الآن'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              final displayedCases = activeCases.take(5).toList();

              return Column(
                children: [
                  ...displayedCases.map((item) {
                    final isPlaintiff = item.clientRole == 'مدعي';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppCard(
                        onTap: () =>
                            context.push('/cases/${item.caseItem.id}'),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isPlaintiff
                                    ? Colors.blue.withAlpha(25)
                                    : Colors.red.withAlpha(25),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.balance,
                                color: isPlaintiff
                                    ? Colors.blue
                                    : Colors.red.shade700,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // اسم الموكل فقط
                                  Row(
                                    children: [
                                      const Icon(Icons.person,
                                          size: 16, color: Colors.blue),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          item.clientName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),

                                  // نوع القضية فقط (بدون رقم الأساس)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary
                                          .withAlpha(25),
                                      borderRadius:
                                          BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      item.caseItem.caseType,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),

                                  // المحكمة والخصم
                                  if (item.courtName != null) ...[
                                    Row(
                                      children: [
                                        Icon(Icons.account_balance,
                                            size: 13,
                                            color: theme.hintColor),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            item.courtName!,
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: theme.hintColor),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  if (item.opponentName != null &&
                                      item.opponentName!.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.shield_outlined,
                                            size: 13,
                                            color: theme.hintColor),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            'الخصم: ${item.opponentName}',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: theme.hintColor),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Column(
                              children: [
                                AppStatusBadge(
                                  label: item.clientRole,
                                  color:
                                      isPlaintiff ? Colors.blue : Colors.red,
                                ),
                                const SizedBox(height: 8),
                                const Icon(Icons.arrow_forward_ios,
                                    size: 14, color: Colors.grey),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  if (activeCases.length > 5) ...[
                    const SizedBox(height: 4),
                    Center(
                      child: TextButton.icon(
                        onPressed: () => context.go('/cases'),
                        icon: const Icon(Icons.arrow_back, size: 16),
                        label: Text(
                            'عرض باقي القضايا (${activeCases.length - 5} قضايا إضافية)'),
                      ),
                    ),
                  ],
                ],
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e, _) => Text('تعذر تحميل القضايا: $e'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
