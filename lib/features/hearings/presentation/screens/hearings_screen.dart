import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../cases/presentation/providers/cases_provider.dart';
import '../../data/repositories/hearings_repository.dart';
import '../providers/hearings_provider.dart';

class HearingsScreen extends ConsumerStatefulWidget {
  const HearingsScreen({super.key});

  @override
  ConsumerState<HearingsScreen> createState() => _HearingsScreenState();
}

class _HearingsScreenState extends ConsumerState<HearingsScreen> {
  String _searchQuery = '';
  String? _statusFilter; // null = الكل, 'UPCOMING', 'POSTPONED', 'COMPLETED'

  int _getHearingPriority(HearingWithCase h, int now) {
    final status = h.hearing.status.toUpperCase();
    final nextDate = h.hearing.nextHearingDate;
    final isPostponed = status == 'POSTPONED' || status == 'مؤجلة';
    final isDone = status == 'HELD' ||
        status == 'ATTENDED' ||
        status == 'COMPLETED' ||
        status == 'منجزة';

    if (!isPostponed && !isDone) {
      // 1. الجلسات القادمة
      return 0;
    } else if (isPostponed && nextDate != null && nextDate >= now) {
      // 2. الجلسات التي أجلت وكان موعد التأجيل في المستقبل
      return 1;
    } else if (isDone) {
      // 3. الجلسات التي تمت
      return 2;
    } else {
      // 4. الجلسات المؤجلة وتمت في الماضي
      return 3;
    }
  }

  void _showAddHearingDialog() {
    final casesAsync = ref.read(allCasesStreamProvider);
    final typeCtrl = TextEditingController(text: 'جلسة مرافعة');
    DateTime hearingDate = DateTime.now().add(const Duration(days: 7));
    String? selectedCaseId;

    casesAsync.whenData((cases) {
      final activeCases =
          cases.where((c) => c.status != 'CLOSED').toList();
      if (activeCases.isNotEmpty) selectedCaseId = activeCases.first.id;

      showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
          builder: (dialogCtx, setDialogState) => AlertDialog(
            title: const Text('تسجيل جلسة محاكمة جديدة'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (activeCases.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text('لا توجد قضايا جارية لإضافة جلسة لها'),
                    )
                  else
                    DropdownButtonFormField<String>(
                      initialValue: selectedCaseId,
                      decoration: const InputDecoration(labelText: 'القضية *'),
                      items: activeCases
                          .map((c) => DropdownMenuItem(
                                value: c.id,
                                child: Text(
                                  c.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      onChanged: (v) =>
                          setDialogState(() => selectedCaseId = v),
                    ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: typeCtrl,
                    decoration: const InputDecoration(
                      labelText: 'نوع الجلسة أو المطلوب',
                      hintText: 'مرافعة / استجواب / تقديم دفوع...',
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('موعد الجلسة'),
                    subtitle: Text(AppDateFormatter.formatDate(hearingDate)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final d = await showDatePicker(
                        context: dialogCtx,
                        initialDate: hearingDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2035),
                      );
                      if (d != null) {
                        setDialogState(() => hearingDate = d);
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (selectedCaseId == null) return;
                  await ref.read(hearingsRepositoryProvider).addHearing(
                        caseId: selectedCaseId!,
                        hearingDate: hearingDate.millisecondsSinceEpoch,
                        hearingType: typeCtrl.text.trim(),
                      );
                  if (ctx.mounted) Navigator.of(ctx).pop();
                },
                child: const Text('حفظ الجلسة'),
              ),
            ],
          ),
        ),
      );
    });
  }

  int _getPostponementCount(Hearing h) {
    if (h.postponementReason == null || h.postponementReason!.trim().isEmpty) {
      return (h.status == 'POSTPONED' || h.status == 'مؤجلة') ? 1 : 0;
    }
    return h.postponementReason!.split(' • ').length;
  }

  List<String> _getPostponementReasons(Hearing h) {
    if (h.postponementReason == null || h.postponementReason!.trim().isEmpty) {
      return [];
    }
    return h.postponementReason!.split(' • ');
  }

  String _getPostponementLabel(int count) {
    if (count <= 0) return '';
    if (count == 1) return 'أُجّلت (مرة واحدة)';
    if (count == 2) return 'أُجّلت (مرتين)';
    return 'أُجّلت ($count مرات)';
  }

  void _showHearingHistoryDialog(Hearing h, String caseTitle) {
    final reasons = _getPostponementReasons(h);
    final count = _getPostponementCount(h);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'سجل تأجيلات: ${h.hearingType}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        caseTitle,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              children: [
                const Icon(Icons.history, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                Text(
                  'عدد مرات التأجيل: ${_getPostponementLabel(count)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (reasons.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('لا توجد أسباب تفصيلية مسجلة'),
              )
            else
              ...List.generate(reasons.length, (idx) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.amber.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.withAlpha(60)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.amber.shade800,
                          child: Text(
                            '${idx + 1}',
                            style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'التأجيل رقم ${idx + 1}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                reasons[idx],
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                _showPostponeHearingDialog(h);
              },
              icon: const Icon(Icons.schedule, size: 18),
              label: const Text('تأجيل الجلسة'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPostponeHearingDialog(Hearing h) {
    final reasonCtrl = TextEditingController(text: 'إمهال لتقديم المذكرات');
    DateTime newDate = DateTime.now().add(const Duration(days: 14));

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.update, color: Colors.orange),
              SizedBox(width: 8),
              Text('تأجيل الجلسة'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'جلسة: ${h.hearingType}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.calendar_month, size: 18),
                  label: Text(
                      'تاريخ الجلسة القادمة: ${AppDateFormatter.formatDate(newDate)}'),
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: ctx,
                      initialDate: newDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2035),
                    );
                    if (d != null) {
                      setDlgState(() => newDate = d);
                    }
                  },
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: reasonCtrl,
                  label: 'سبب التأجيل *',
                  hint: 'إمهال لتقديم دفوع / تبليغ الخصم',
                  enableSpeech: true,
                  autofocus: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newReason = reasonCtrl.text.trim();
                if (newReason.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('يرجى كتابة سبب التأجيل'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                await ref.read(hearingsRepositoryProvider).postponeHearing(
                      hearingId: h.id,
                      caseId: h.caseId,
                      courtId: h.courtId,
                      hearingType: h.hearingType,
                      newHearingDate: newDate.millisecondsSinceEpoch,
                      reason: newReason,
                    );

                ref.invalidate(allHearingsStreamProvider);
                ref.invalidate(caseListItemsStreamProvider);

                if (ctx.mounted) {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('تم تأجيل الجلسة وجدولة الجلسة القادمة بنجاح'),
                      backgroundColor: Colors.teal,
                    ),
                  );
                }
              },
              child: const Text('تأكيد التأجيل'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRecordDecisionDialog(String hearingId) {
    final decisionCtrl = TextEditingController();
    final reasonCtrl = TextEditingController();
    String status = 'ATTENDED';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) => AlertDialog(
          title: const Text('تسجيل قرار الجلسة'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: status,
                  decoration: const InputDecoration(labelText: 'نتيجة الجلسة'),
                  items: const [
                    DropdownMenuItem(value: 'ATTENDED', child: Text('تم الحضور وإصدار القرار')),
                    DropdownMenuItem(value: 'POSTPONED', child: Text('تأجيل الجلسة')),
                    DropdownMenuItem(value: 'CANCELLED', child: Text('ملغاة')),
                  ],
                  onChanged: (v) => setDialogState(() => status = v!),
                ),
                const SizedBox(height: 12),
                if (status == 'POSTPONED')
                  AppTextField(
                    controller: reasonCtrl,
                    label: 'سبب التأجيل *',
                    hint: 'مثال: لتبليغ الخصم / لتقديم دفوع',
                  )
                else
                  AppTextField(
                    controller: decisionCtrl,
                    maxLines: 2,
                    label: 'النتيجة / العمل المنجز',
                    hint: 'منطوق القرار أو مجريات المرافعة...',
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(hearingsRepositoryProvider)
                    .updateHearingDecision(
                      id: hearingId,
                      status: status,
                      decision: status == 'POSTPONED'
                          ? 'أُجّلت الجلسة: ${reasonCtrl.text.trim()}'
                          : decisionCtrl.text.trim(),
                      postponementReason: status == 'POSTPONED'
                          ? reasonCtrl.text.trim()
                          : null,
                    );
                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: const Text('حفظ النتيجة'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hearingsAsync = ref.watch(allHearingsStreamProvider);
    final now = DateTime.now().millisecondsSinceEpoch;

    final filterOptions = [
      (label: 'الكل', value: null),
      (label: 'الجلسات القادمة', value: 'UPCOMING'),
      (label: 'المؤجلة', value: 'POSTPONED'),
      (label: 'المنجزة', value: 'COMPLETED'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('جلسات المحاكمة'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddHearingDialog,
        icon: const Icon(Icons.add),
        label: const Text('تسجيل جلسة'),
      ),
      body: Column(
        children: [
          // شريط البحث الذكي
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val.trim()),
              decoration: InputDecoration(
                hintText: 'بحث باسم القضية، الموكل، المحكمة، أو نوع الجلسة...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
              ),
            ),
          ),

          // شرائح التصفية (الكل، القادمة، المؤجلة، المنجزة)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: filterOptions.map((opt) {
                final isSelected = _statusFilter == opt.value;
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterChip(
                    label: Text(opt.label),
                    selected: isSelected,
                    onSelected: (_) =>
                        setState(() => _statusFilter = opt.value),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 6),

          // قائمة الجلسات المرتبة هرمياً
          Expanded(
            child: hearingsAsync.when(
              data: (allHearings) {
                // 1. تصفية بالبحث
                var filtered = allHearings.where((h) {
                  if (_searchQuery.isEmpty) return true;
                  final query = _searchQuery.toLowerCase();
                  final titleMatch =
                      h.caseItem.title.toLowerCase().contains(query);
                  final courtMatch =
                      (h.court?.name ?? '').toLowerCase().contains(query);
                  final typeMatch =
                      h.hearing.hearingType.toLowerCase().contains(query);
                  final decisionMatch =
                      (h.hearing.decision ?? '').toLowerCase().contains(query);
                  final reasonMatch =
                      (h.hearing.postponementReason ?? '')
                          .toLowerCase()
                          .contains(query);
                  return titleMatch ||
                      courtMatch ||
                      typeMatch ||
                      decisionMatch ||
                      reasonMatch;
                }).toList();

                // 2. تصفية بالحالة
                if (_statusFilter != null) {
                  filtered = filtered.where((h) {
                    final status = h.hearing.status.toUpperCase();
                    final isPostponed =
                        status == 'POSTPONED' || status == 'مؤجلة';
                    final isDone = status == 'HELD' ||
                        status == 'ATTENDED' ||
                        status == 'COMPLETED';
                    if (_statusFilter == 'UPCOMING') {
                      return !isPostponed && !isDone;
                    } else if (_statusFilter == 'POSTPONED') {
                      return isPostponed;
                    } else if (_statusFilter == 'COMPLETED') {
                      return isDone;
                    }
                    return true;
                  }).toList();
                }

                if (filtered.isEmpty) {
                  return AppEmptyState(
                    icon: Icons.event_seat_outlined,
                    title: 'لا توجد جلسات مطابقة',
                    subtitle: 'اضغط على زر تسجيل جلسة لجدولة جلسة محاكمة جديدة',
                    actionLabel: 'تسجيل جلسة جديدة',
                    onAction: _showAddHearingDialog,
                  );
                }

                // 3. الترتيب الدقيق وفق طلب المستخدم:
                // 1) الجلسات القادمة
                // 2) الجلسات التي أجلت وكان موعد التأجيل في المستقبل
                // 3) الجلسات التي تمت
                // 4) الجلسات المؤجلة وتمت في الماضي
                filtered.sort((a, b) {
                  final pa = _getHearingPriority(a, now);
                  final pb = _getHearingPriority(b, now);
                  if (pa != pb) return pa.compareTo(pb);
                  return b.hearing.hearingDate.compareTo(a.hearing.hearingDate);
                });

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final h = filtered[index];
                    final isPostponed = h.hearing.status == 'POSTPONED' ||
                        h.hearing.status == 'مؤجلة';
                    final isDone = h.hearing.status == 'HELD' ||
                        h.hearing.status == 'ATTENDED' ||
                        h.hearing.status == 'COMPLETED';
                    final postCount = _getPostponementCount(h.hearing);
                    final postReasons = _getPostponementReasons(h.hearing);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AppCard(
                        onTap: () => context.push('/cases/${h.caseItem.id}'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isPostponed
                                            ? Colors.amber.withAlpha(25)
                                            : isDone
                                                ? Colors.green.withAlpha(25)
                                                : Colors.teal.withAlpha(25),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.event_seat,
                                        color: isPostponed
                                            ? Colors.amber.shade800
                                            : isDone
                                                ? Colors.green
                                                : Colors.teal,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      h.hearing.hearingType,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                AppStatusBadge(
                                  label: isPostponed
                                      ? 'مؤجلة'
                                      : isDone
                                          ? 'منجزة'
                                          : 'قيد النظر',
                                  color: isPostponed
                                      ? Colors.amber.shade800
                                      : isDone
                                          ? Colors.green
                                          : Colors.blue,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              h.caseItem.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            if (h.court?.name != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                'المحكمة: ${h.court!.name}',
                                style: TextStyle(
                                    fontSize: 12, color: theme.hintColor),
                              ),
                            ],
                            const SizedBox(height: 4),
                            // موعد الجلسة بدون توقيت الساعات إطلاقاً
                            Text(
                              'موعد الجلسة: ${AppDateFormatter.formatDate(DateTime.fromMillisecondsSinceEpoch(h.hearing.hearingDate))}',
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isPostponed &&
                                h.hearing.postponementReason != null &&
                                h.hearing.postponementReason!.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withAlpha(25),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.amber.shade700
                                          .withAlpha(80)),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.history,
                                                size: 16,
                                                color: Colors.amber.shade900),
                                            const SizedBox(width: 6),
                                            Text(
                                              _getPostponementLabel(postCount),
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber.shade900,
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              _showHearingHistoryDialog(
                                                  h.hearing, h.caseItem.title),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 2),
                                            child: Text(
                                              'عرض سجل هذه الجلسة',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'آخر سبب: ${postReasons.isNotEmpty ? postReasons.last : h.hearing.postponementReason!}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.amber.shade900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            if (h.hearing.decision != null &&
                                h.hearing.decision!.isNotEmpty &&
                                !isPostponed) ...[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: theme.brightness == Brightness.dark
                                      ? const Color(0xFF1E293B)
                                      : const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'النتيجة: ${h.hearing.decision!}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                            const Divider(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () =>
                                        _showPostponeHearingDialog(h.hearing),
                                    icon: const Icon(Icons.schedule, size: 16),
                                    label: const Text('تأجيل الجلسة'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        _showRecordDecisionDialog(h.hearing.id),
                                    icon: const Icon(Icons.check_circle_outline,
                                        size: 16),
                                    label: const Text('تسجيل القرار'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('خطأ: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
