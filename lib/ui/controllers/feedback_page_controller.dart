import 'package:get/get.dart';

class FeedbackPageController extends GetxController {
  final RxString _filtroSelected = "".obs;
  final RxString _filtro1 = "Recientes".obs;
  final RxString _filtro2 = "MejorVal".obs;

  String get filtroSelected => _filtroSelected.value;
  String get filtro1 => _filtro1.value;
  String get filtro2 => _filtro2.value;

  void changeFiltro1(String newFiltro) => _filtro1.value = newFiltro;
  void changeFiltro2(String newFiltro) => _filtro2.value = newFiltro;

  void changeFiltro(String filtro) => _filtroSelected.value = filtro;

  FeedbackPageController();
}
