import 'dart:convert';
import 'package:empleados_front/models/departamento.dart';
import 'package:http/http.dart' as http;

class DepartamentoService {
  static var client = http.Client();

  static Future<List<Departamento>?> fetchDepartamentos() async {
    var response =
        await client.get(Uri.parse('http://127.0.0.1:8000/api/departamentos'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      List jsonList = json.decode(jsonString);
      return jsonList.map((data) => Departamento.fromJson(data)).toList();
    } else {
      return null;
    }
  }

  static Future<Departamento?> obtenerDepartamentoPorId(int id) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/departamentos/$id');

    var response = await client.get(url);

    if (response.statusCode == 200) {
      var jsonMap = json.decode(response.body);
      return Departamento.fromJson(
          jsonMap);
    } else {
      return null;
    }
  }
}
