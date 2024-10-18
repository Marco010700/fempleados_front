import 'package:empleados_front/controllers/alta_empleado_controller.dart';
import 'package:empleados_front/controllers/empleado_controller.dart';
import 'package:empleados_front/views/alta_empleados_view.dart';
import 'package:empleados_front/views/edit_empleado_view.dart';
import 'package:empleados_front/views/empleados_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.EMPLEADOS;

  static final routes = [
    GetPage(
      name: Routes.EMPLEADOS,
      page: () => EmpleadosView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => EmpleadoController());
      }),
    ),
    GetPage(
      name: Routes.ALTA_EMPLEADO,
      page: () => AltaEmpleadoView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AltaEmpleadoController());
      }),
    ),
    GetPage(
      name: Routes.EDITAR_EMPLEADO,
      page: () => EditEmpleadoView(),
    ),
  ];
}
