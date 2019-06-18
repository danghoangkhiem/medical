import 'package:medical/src/models/medrep_of_medsup_model.dart';
import 'package:medical/src/resources/api/med_rep_provider.dart';

class MedRepRepository {

  final MedRepApiProvider _medRepApiProvider = MedRepApiProvider();

  Future<MedRepModel> getMedRep({int id,int offset, int limit}) async {
    return await _medRepApiProvider.getMedRep(offset: offset, limit: limit, id: id);
  }

}