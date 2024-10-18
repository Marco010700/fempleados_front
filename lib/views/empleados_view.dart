import 'package:empleados_front/controllers/empleado_controller.dart';
import 'package:empleados_front/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class EmpleadosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EmpleadoController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('App de Empleados Servimsa'),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.green),
            onPressed: () {
              Get.toNamed(Routes.ALTA_EMPLEADO);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                controller.filterEmpleados(value);
              },
              decoration: InputDecoration(
                labelText: 'Buscar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.empleados.isEmpty) {
                  return const Center(
                      child: Text('No hay empleados disponibles'));
                } else {
                  return ListView.builder(
                    itemCount: controller.empleados.length,
                    itemBuilder: (context, index) {
                      final empleado = controller.empleados[index];
                      return GFListTile(
                        titleText: empleado.nombre,
                        subTitleText: empleado.correo,
                        icon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Get.toNamed(
                                  Routes.EDITAR_EMPLEADO,
                                  arguments: {
                                    'empleadoId': empleado.id,
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                controller.eliminarEmpleado(empleado.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
