import 'package:empleados_front/models/departamento.dart';
import 'package:empleados_front/services/departamento_service.dart';
import 'package:empleados_front/services/empleado_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditEmpleadoController extends GetxController {
  TextEditingController nombreController = TextEditingController();
  TextEditingController fechanacController = TextEditingController();
  TextEditingController correoController = TextEditingController();

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

  void cargarEmpleado(int id) async {
    isLoading(true);

    var empleado = await EmpleadoService.obtenerEmpleadoPorId(id);
    if (empleado != null) {
      nombreController.text = empleado.nombre;
      fechanacController.text = empleado.fechanac;
      correoController.text = empleado.correo;
      estatus.value = empleado.activo;

      var departamento = await DepartamentoService.obtenerDepartamentoPorId(empleado.idDepartamento);
      if (departamento != null) {
        selectedDepartamento.value = departamento;
      } else {
        selectedDepartamento.value = null;
      }
    }

    isLoading(false);
  }

  void actualizarEstatusEmpleado(int id) async {
    int estatusInt = estatus.value ? 1 : 0;
    var response = await EmpleadoService.actualizarEstatusEmpleado(id, estatusInt);

    if (response != null) {
      Get.back();
    } else {
      Get.snackbar('Error', 'No se pudo actualizar el estatus');
    }
  }
}
