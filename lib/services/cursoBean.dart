class cursoBean {
  String curso;
  String nombre_profesor;
  String apellido_profesor;
  String correo_profesor;

  cursoBean({
    required this.curso,
    required this.nombre_profesor,
    required this.apellido_profesor,
    required this.correo_profesor,
  });

  factory cursoBean.fromJson(Map json) {
    return cursoBean(
        curso: json["curso"],
        nombre_profesor: json["nombre_docente"],
        apellido_profesor: json["apellido_docente"],
        correo_profesor: json["correo_docente"]);
  }
}
