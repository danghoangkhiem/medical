import 'package:medical/src/models/day_schedule_med_rep_model.dart';
import 'package:medical/src/resources/api/day_schedule_med_rep_provider.dart';

class DayScheduleMedRepRepository {

  final DayScheduleMedRepProvider _dayScheduleMedRepProvider = DayScheduleMedRepProvider();

  Future<DayScheduleMedRepModel> getDayScheduleMedRep({DateTime date, int offset, int limit, int userId}) async {
    return await _dayScheduleMedRepProvider.getDayScheduleMedRep(offset: offset, limit: limit, date: date, userId: userId);
  }

}