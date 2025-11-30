class Festivity {
  final String id;
  final String nombre;
  final String descripcion;
  final String fecha;
  final String ubicacion;
  final String historia;
  final List<String> imagenes;
  final List<String> actividades;
  final String tipo;
  final String mes;
  final bool esDestacada;
  final double latitud;
  final double longitud;

  Festivity({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.fecha,
    required this.ubicacion,
    required this.historia,
    required this.imagenes,
    required this.actividades,
    this.tipo = 'Cultural',
    this.mes = 'Junio',
    this.esDestacada = false,
    this.latitud = -13.53195,
    this.longitud = -71.96746,
  });
}