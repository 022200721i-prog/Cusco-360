import '../models/sitio_arqueologico.dart';

class SitioService {
  List<SitioArqueologico> _sitios = [];

  SitioService() {
    _inicializarDatos();
  }

  void _inicializarDatos() {
    _sitios = [
      SitioArqueologico(
        id: '1',
        nombre: 'Machu Picchu',
        descripcionCorta: 'La ciudad perdida de los Incas, una de las 7 maravillas del mundo moderno',
        descripcionLarga: 'Machu Picchu es una antigua ciudadela inca ubicada en las alturas de las montañas de los Andes en Perú. Construida en el siglo XV y abandonada posteriormente, es famosa por sus sofisticadas construcciones de piedra seca que se integran con el paisaje natural. Este sitio arqueológico es considerado una obra maestra de la arquitectura y la ingeniería, y fue declarado Patrimonio de la Humanidad por la UNESCO en 1983.',
        ubicacion: 'Distrito de Machupicchu, Provincia de Urubamba, Cusco',
        latitud: -13.1631,
        longitud: -72.5450,
        historia: 'Descubierta en 1911 por Hiram Bingham, Machu Picchu fue construida alrededor del año 1450 durante el gobierno del emperador Pachacútec. Se cree que fue un centro ceremonial, astronómico y agrícola. La ciudadela fue abandonada durante la conquista española y permaneció oculta hasta su redescubrimiento en el siglo XX.',
        imagenes: [
          'https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=800&auto=format&fit=crop&q=80',
          'https://images.unsplash.com/photo-1526392060635-9d6019884377?w=800&auto=format&fit=crop&q=80',
          'https://images.unsplash.com/photo-1599669454699-248893623440?w=800&auto=format&fit=crop&q=80'
        ],
        epoca: 'Siglo XV (1450 d.C.)',
        cultura: 'Inca',
        alturaMsnm: 2430,
        caracteristicas: ['Templo del Sol', 'Intihuatana', 'Templo de las Tres Ventanas', 'Puerta del Sol', 'Templo del Cóndor', 'Residencia Real'],
        tipo: 'Ciudadela',
        esPopular: true,
        horario: '6:00 AM - 5:00 PM',
        precioEntrada: 'Extranjeros: 152 PEN | Nacionales: 64 PEN | Estudiantes: 32 PEN',
        tiempoVisita: 4,
        calificacion: 4.9,
        reviews: 12845,
        actividades: ['Tour guiado', 'Caminata', 'Fotografía', 'Observación astronómica', 'Visita al Museo de Sitio'],
        dificultad: 'Media',
        requiereGuia: true,
        fechaCreacion: DateTime(2024, 1, 1),
      ),
      SitioArqueologico(
        id: '2',
        nombre: 'Sacsayhuamán',
        descripcionCorta: 'Impresionante fortaleza ceremonial con muros de piedra ciclópeos',
        descripcionLarga: 'Sacsayhuamán es una fortaleza ceremonial inca ubicada a 2 km del Cusco. Famosa por sus enormes piedras que encajan perfectamente, algunas de las cuales pesan más de 100 toneladas. El complejo ofrece vistas panorámicas espectaculares de la ciudad del Cusco y es escenario principal del Inti Raymi, la fiesta del sol.',
        ubicacion: 'Norte de la ciudad del Cusco',
        latitud: -13.5086,
        longitud: -71.9811,
        historia: 'Construida durante el gobierno de Pachacútec en el siglo XV, servía como fortaleza y centro ceremonial. Fue escenario de batallas durante la conquista española. Los españoles desmantelaron parcialmente la estructura para construir iglesias y casas en el Cusco colonial.',
        imagenes: [
          'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=800&auto=format&fit=crop&q=80',
          'https://images.unsplash.com/photo-1578326457399-7c713b0fe5cf?w=800&auto=format&fit=crop&q=80'
        ],
        epoca: 'Siglo XV',
        cultura: 'Inca',
        alturaMsnm: 3701,
        caracteristicas: ['Muros ciclópeos', 'Rodadero', 'Tronadero', 'Anfiteatro', 'Chincanas', 'Puertas trapezoidales'],
        tipo: 'Fortaleza',
        esPopular: true,
        horario: '7:00 AM - 5:30 PM',
        precioEntrada: 'Incluido en Boleto Turístico General (70 PEN)',
        tiempoVisita: 2,
        calificacion: 4.7,
        reviews: 8923,
        actividades: ['Tour histórico', 'Fotografía', 'Vistas panorámicas', 'Observación de cóndores'],
        dificultad: 'Baja',
        requiereGuia: false,
        fechaCreacion: DateTime(2024, 1, 2),
      ),
      SitioArqueologico(
        id: '3',
        nombre: 'Ollantaytambo',
        descripcionCorta: 'Pueblo inca viviente con impresionante arquitectura y terrazas agrícolas',
        descripcionLarga: 'Ollantaytambo es uno de los mejores ejemplos de planificación urbana inca que sigue habitado. Este complejo arqueológico funcionaba como fortaleza, templo y área agrícola, con impresionantes andenes y un elaborado sistema de riego que aún funciona.',
        ubicacion: 'Ollantaytambo, Provincia de Urubamba, Cusco',
        latitud: -13.2581,
        longitud: -72.2633,
        historia: 'Construido durante el gobierno de Pachacútec, fue escenario de una importante victoria inca contra los españoles en 1536. Sirvió como punto de control del Valle Sagrado y refugio temporal para Manco Inca durante la resistencia.',
        imagenes: [
          'https://images.unsplash.com/photo-1578326457399-7c713b0fe5cf?w=800&auto=format&fit=crop&q=80'
        ],
        epoca: 'Siglo XV',
        cultura: 'Inca',
        alturaMsnm: 2792,
        caracteristicas: ['Templo del Sol', 'Baño de la Ñusta', 'Andenes', 'Almacenes', 'Plaza Principal', 'Calles empedradas'],
        tipo: 'Fortaleza y Pueblo',
        esPopular: true,
        horario: '7:00 AM - 5:00 PM',
        precioEntrada: 'Incluido en Boleto Turístico General (70 PEN)',
        tiempoVisita: 3,
        calificacion: 4.6,
        reviews: 7568,
        actividades: ['Tour histórico', 'Caminata por andenes', 'Visita al pueblo', 'Fotografía arquitectónica'],
        dificultad: 'Media',
        requiereGuia: true,
        fechaCreacion: DateTime(2024, 1, 3),
      ),
    ];
  }

  // CREATE - Agregar nuevo sitio
  Future<SitioArqueologico> agregarSitio(SitioArqueologico sitio) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final nuevoSitio = sitio.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fechaCreacion: DateTime.now(),
    );
    _sitios.add(nuevoSitio);
    return nuevoSitio;
  }

  // READ - Obtener todos los sitios
  Future<List<SitioArqueologico>> obtenerSitios() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_sitios);
  }

  // READ - Obtener sitio por ID
  Future<SitioArqueologico?> obtenerSitioPorId(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _sitios.firstWhere((sitio) => sitio.id == id);
    } catch (e) {
      return null;
    }
  }

  // UPDATE - Actualizar sitio
  Future<SitioArqueologico> actualizarSitio(SitioArqueologico sitioActualizado) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _sitios.indexWhere((sitio) => sitio.id == sitioActualizado.id);
    if (index != -1) {
      _sitios[index] = sitioActualizado;
      return sitioActualizado;
    }
    throw Exception('Sitio no encontrado');
  }

  // DELETE - Eliminar sitio
  Future<void> eliminarSitio(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _sitios.removeWhere((sitio) => sitio.id == id);
  }

  // SEARCH - Buscar sitios
  Future<List<SitioArqueologico>> buscarSitios(String consulta) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (consulta.isEmpty) return _sitios;
    
    return _sitios.where((sitio) =>
      sitio.nombre.toLowerCase().contains(consulta.toLowerCase()) ||
      sitio.ubicacion.toLowerCase().contains(consulta.toLowerCase()) ||
      sitio.descripcionCorta.toLowerCase().contains(consulta.toLowerCase()) ||
      sitio.tipo.toLowerCase().contains(consulta.toLowerCase()) ||
      sitio.cultura.toLowerCase().contains(consulta.toLowerCase())
    ).toList();
  }

  // Obtener sitios populares
  Future<List<SitioArqueologico>> obtenerSitiosPopulares() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _sitios.where((sitio) => sitio.esPopular).toList();
  }

  // Obtener sitios por tipo
  Future<List<SitioArqueologico>> obtenerSitiosPorTipo(String tipo) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _sitios.where((sitio) => sitio.tipo == tipo).toList();
  }
}