import 'package:empleados_front/controllers/empleado_controller.dart';
import 'package:empleados_front/models/departamento.dart';
import 'package:empleados_front/services/departamento_service.dart';
import 'package:empleados_front/services/empleado_service.dart';
import 'package:get/get.dart';

class AltaEmpleadoController extends GetxController {
  var nombre = ''.obs;
  var fechanac = ''.obs;
  var correo = ''.obs;
  var estatus = false.obs;
  var selectedDepartamento = Rxn<Departamento>();
  var departamentos = <Departamento>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDepartamentos();
  }

  void fetchDepartamentos() async {
    isLoading(true);
    var result = await DepartamentoService.fetchDepartamentos();
    if (result != null) {
      departamentos.assignAll(result);
    }
    isLoading(false);
  }

  void registrarEmpleado() async {
    int estatusInt = estatus.value ? 1 : 0;

    Map<String, dynamic> nuevoEmpleado = {
      'nombre': nombre.value,
      'fechanac': fechanac.value,
      'correo': correo.value,
      'activo': estatusInt,
      'id_departamento': selectedDepartamento.value?.id,
    };

    isLoading(true);

    var response = await EmpleadoService.registrarEmpleado(nuevoEmpleado);

    isLoading(false);

    if (response != null) {
      final empleadoController = Get.find<EmpleadoController>();
      empleadoController.fetchEmpleados();
      Get.back();
    } else {
      Get.snackbar('Error', 'No se pudo registrar el empleado');
    }
  }
}
