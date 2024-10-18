class Empleado {
  final int id;
  final String nombre;
  final String correo;
  final String fechanac;
  final bool activo;
  final int idDepartamento;

  Empleado({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.fechanac,
    required this.activo,
    required this.idDepartamento,
  });

  factory Empleado.fromJson(Map<String, dynamic> json) {
    return Empleado(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      fechanac: json['fechanac'],
      activo: json['activo'] == 1,
      idDepartamento: json['id_departamento'],
    );
  }
}
