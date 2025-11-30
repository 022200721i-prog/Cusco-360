class SitioArqueologico {
  final String id;
  final String nombre;
  final String descripcionCorta;
  final String descripcionLarga;
  final String ubicacion;
  final double latitud;
  final double longitud;
  final String historia;
  final List<String> imagenes;
  final String epoca;
  final String cultura;
  final double alturaMsnm;
  final List<String> caracteristicas;
  final String tipo;
  final bool esPopular;
  final String horario;
  final String precioEntrada;
  final int tiempoVisita; // en horas
  final double calificacion;
  final int reviews;
  final List<String> actividades;
  final String dificultad; // Baja, Media, Alta
  final bool requiereGuia;
  final DateTime fechaCreacion;

  SitioArqueologico({
    required this.id,
    required this.nombre,
    required this.descripcionCorta,
    required this.descripcionLarga,
    required this.ubicacion,
    required this.latitud,
    required this.longitud,
    required this.historia,
    required this.imagenes,
    required this.epoca,
    required this.cultura,
    required this.alturaMsnm,
    required this.caracteristicas,
    required this.tipo,
    required this.esPopular,
    required this.horario,
    required this.precioEntrada,
    required this.tiempoVisita,
    required this.calificacion,
    required this.reviews,
    required this.actividades,
    required this.dificultad,
    required this.requiereGuia,
    required this.fechaCreacion,
  });

  SitioArqueologico copyWith({
    String? id,
    String? nombre,
    String? descripcionCorta,
    String? descripcionLarga,
    String? ubicacion,
    double? latitud,
    double? longitud,
    String? historia,
    List<String>? imagenes,
    String? epoca,
    String? cultura,
    double? alturaMsnm,
    List<String>? caracteristicas,
    String? tipo,
    bool? esPopular,
    String? horario,
    String? precioEntrada,
    int? tiempoVisita,
    double? calificacion,
    int? reviews,
    List<String>? actividades,
    String? dificultad,
    bool? requiereGuia,
    DateTime? fechaCreacion,
  }) {
    return SitioArqueologico(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcionCorta: descripcionCorta ?? this.descripcionCorta,
      descripcionLarga: descripcionLarga ?? this.descripcionLarga,
      ubicacion: ubicacion ?? this.ubicacion,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      historia: historia ?? this.historia,
      imagenes: imagenes ?? this.imagenes,
      epoca: epoca ?? this.epoca,
      cultura: cultura ?? this.cultura,
      alturaMsnm: alturaMsnm ?? this.alturaMsnm,
      caracteristicas: caracteristicas ?? this.caracteristicas,
      tipo: tipo ?? this.tipo,
      esPopular: esPopular ?? this.esPopular,
      horario: horario ?? this.horario,
      precioEntrada: precioEntrada ?? this.precioEntrada,
      tiempoVisita: tiempoVisita ?? this.tiempoVisita,
      calificacion: calificacion ?? this.calificacion,
      reviews: reviews ?? this.reviews,
      actividades: actividades ?? this.actividades,
      dificultad: dificultad ?? this.dificultad,
      requiereGuia: requiereGuia ?? this.requiereGuia,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcionCorta': descripcionCorta,
      'descripcionLarga': descripcionLarga,
      'ubicacion': ubicacion,
      'latitud': latitud,
      'longitud': longitud,
      'historia': historia,
      'imagenes': imagenes,
      'epoca': epoca,
      'cultura': cultura,
      'alturaMsnm': alturaMsnm,
      'caracteristicas': caracteristicas,
      'tipo': tipo,
      'esPopular': esPopular,
      'horario': horario,
      'precioEntrada': precioEntrada,
      'tiempoVisita': tiempoVisita,
      'calificacion': calificacion,
      'reviews': reviews,
      'actividades': actividades,
      'dificultad': dificultad,
      'requiereGuia': requiereGuia,
      'fechaCreacion': fechaCreacion.millisecondsSinceEpoch,
    };
  }

  factory SitioArqueologico.fromMap(Map<String, dynamic> map) {
    return SitioArqueologico(
      id: map['id'],
      nombre: map['nombre'],
      descripcionCorta: map['descripcionCorta'],
      descripcionLarga: map['descripcionLarga'],
      ubicacion: map['ubicacion'],
      latitud: map['latitud'],
      longitud: map['longitud'],
      historia: map['historia'],
      imagenes: List<String>.from(map['imagenes']),
      epoca: map['epoca'],
      cultura: map['cultura'],
      alturaMsnm: map['alturaMsnm'],
      caracteristicas: List<String>.from(map['caracteristicas']),
      tipo: map['tipo'],
      esPopular: map['esPopular'],
      horario: map['horario'],
      precioEntrada: map['precioEntrada'],
      tiempoVisita: map['tiempoVisita'],
      calificacion: map['calificacion'],
      reviews: map['reviews'],
      actividades: List<String>.from(map['actividades']),
      dificultad: map['dificultad'],
      requiereGuia: map['requiereGuia'],
      fechaCreacion: DateTime.fromMillisecondsSinceEpoch(map['fechaCreacion']),
    );
  }
}