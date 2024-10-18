import 'package:empleados_front/models/empleado.dart';
import 'package:empleados_front/services/empleado_service.dart';
import 'package:get/get.dart';

class EmpleadoController extends GetxController {
  var empleados = <Empleado>[].obs;
  var isLoading = true.obs;
  var empleadosFiltrados = <Empleado>[].obs;

  @override
  void onInit() {
    fetchEmpleados();
    super.onInit();
  }

  void fetchEmpleados() async {
    isLoading(true);
    try {
      var result = await EmpleadoService.fetchEmpleados();
      if (result != null) {
        empleados.assignAll(result);
      }
    } finally {
      isLoading(false);
    }
  }

  void filterEmpleados(String query) {
    if (query.isEmpty) {
      empleadosFiltrados.assignAll(empleados);
    } else {
      empleadosFiltrados.assignAll(
        empleados
            .where((empleado) =>
                empleado.nombre.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void eliminarEmpleado(int id) async {
    isLoading(true);
    var response = await EmpleadoService.eliminarEmpleado(id);
    isLoading(false);

    if (response != null) {
      fetchEmpleados();
      Get.snackbar('Eliminado', 'Empleado eliminado con éxito');
    } else {
      Get.snackbar('Error', 'No se pudo eliminar el empleado');
    }
  }
}
