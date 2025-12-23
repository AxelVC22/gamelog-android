class WeekRange {
  final DateTime start;
  final DateTime end;

  WeekRange(this.start, this.end);
}

WeekRange getCurrentWeekRange() {
  final now = DateTime.now();


  final startOfWeek = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(Duration(days: now.weekday - 1));

  final endOfWeek = startOfWeek.add(
    const Duration(days: 6, hours: 23, minutes: 59, seconds: 59),
  );

  return WeekRange(startOfWeek, endOfWeek);
}
