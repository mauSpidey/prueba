class noticia {
  String id;
  String titular;
  String contenido;
  String fecha;
  String cod_carrera;

  noticia(
      {required this.id,
      required this.titular,
      required this.contenido,
      required this.fecha,
      required this.cod_carrera});

  factory noticia.fromJson(Map json) {
    return noticia(
        id: json["id"],
        titular: json["titular"],
        contenido: json["contenido"],
        fecha: json["fecha"],
        cod_carrera: json["carrera"]);
  }
}
