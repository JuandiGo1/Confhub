import 'package:get/get.dart';

class FeedbackPageController extends GetxController {
  final RxString _filtroSelected = "".obs;
  final RxString _filtro1 = "Recientes".obs;
  final RxString _filtro2 = "MejorVal".obs;
  final RxInt _actualScore = 0.obs;
  final RxBool _isSent = false.obs;
  final RxList<String> _feedbackids = <String>[].obs;

  String get filtroSelected => _filtroSelected.value;
  String get filtro1 => _filtro1.value;
  String get filtro2 => _filtro2.value;
  int get actualScore => _actualScore.value;
  bool get isSent => _isSent.value;
  bool  isinFeedbackids(String id) => _feedbackids.contains(id);
  List<String> get feedbackids => _feedbackids.value;

  void changeFiltro1(String newFiltro) => _filtro1.value = newFiltro;
  void changeFiltro2(String newFiltro) => _filtro2.value = newFiltro;

  void changeFiltro(String filtro) => _filtroSelected.value = filtro;
  void setFeedbacksid(String feedback) {
    _feedbackids.add(feedback);
  }

  void updateActualScore(int score) => _actualScore.value = score;
  void wasSent() => _isSent.value = true;

  FeedbackPageController();
}
