import 'dart:convert';
import 'package:empleados_front/models/empleado.dart';
import 'package:http/http.dart' as http;

class EmpleadoService {
  static var client = http.Client();

  static Future<List<Empleado>?> fetchEmpleados() async {
    var response =
        await client.get(Uri.parse('http://127.0.0.1:8000/api/empleados'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      List jsonList = json.decode(jsonString);
      return jsonList.map((data) => Empleado.fromJson(data)).toList();
    } else {
      return null;
    }
  }

  static Future<http.Response?> registrarEmpleado(
      Map<String, dynamic> empleadoData) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/empleados');

    var response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(empleadoData),
    );

    if (response.statusCode == 201) {
      return response;
    } else {
      return null;
    }
  }

  static Future<http.Response?> eliminarEmpleado(int id) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/empleados/$id');

    var response = await client.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  static Future<Empleado?> obtenerEmpleadoPorId(int id) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/empleados/$id');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var jsonMap = json.decode(response.body);
      return Empleado.fromJson(jsonMap);
    } else {
      return null;
    }
  }

  static Future<http.Response?> actualizarEstatusEmpleado(
      int id, int estatus) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/empleados/$id/status');
    var response = await client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'activo': estatus}),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }
}
