import 'package:empleados_front/controllers/edit_empleados_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEmpleadoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EditEmpleadoController controller = Get.put(EditEmpleadoController());
    final int empleadoId =
        Get.arguments != null ? Get.arguments['empleadoId'] : null;

    if (empleadoId != null) {
      controller.cargarEmpleado(empleadoId);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Empleado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre Completo',
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 16),

              TextField(
                controller: controller.fechanacController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'Fecha de Nacimiento (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 16),

              TextField(
                controller: controller.correoController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Obx(() => Checkbox(
                        value: controller.estatus.value,
                        onChanged: (bool? value) {
                          controller.estatus.value = value ?? false;
                        },
                      )),
                  const Text('Activo'),
                ],
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  if (empleadoId != null) {
                    controller.actualizarEstatusEmpleado(empleadoId);
                  }
                },
                child: Text('Actualizar Empleado'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
