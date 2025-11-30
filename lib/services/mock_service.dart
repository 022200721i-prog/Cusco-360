import '../models/festivity.dart';

class MockService {
  Future<List<Festivity>> fetchFestivities() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      Festivity(
        id: '1',
        nombre: 'Inti Raymi',
        descripcion: 'El Inti Raymi es una antigua ceremonia Inca en honor al dios Sol, celebrada cada 24 de junio en Cusco.',
        fecha: '24 de Junio',
        ubicacion: 'Sacsayhuamán, Cusco',
        historia: 'Ceremonia incaica en honor a Inti (el dios sol), que se realizaba cada solsticio de invierno en los Andes.',
        imagenes: [
          'https://images.unsplash.com/photo-1580502304784-8985b7eb7260?w=800&auto=format&fit=crop&q=80',
          'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=800&auto=format&fit=crop&q=80'
        ],
        actividades: ['Ceremonia Principal', 'Desfile de Danzas', 'Representación Histórica'],
        tipo: 'Cultural',
        mes: 'Junio',
        esDestacada: true,
        latitud: -13.5086,
        longitud: -71.9811,
      ),
      Festivity(
        id: '2',
        nombre: 'Señor de los Temblores',
        descripcion: 'Festividad religiosa más importante de Cusco, realizada en Semana Santa.',
        fecha: 'Lunes Santo',
        ubicacion: 'Catedral del Cusco',
        historia: 'Procesión del Cristo Negro que data del siglo XVII, protector de la ciudad contra los terremotos.',
        imagenes: [
          'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=800&auto=format&fit=crop&q=80'
        ],
        actividades: ['Procesión Religiosa', 'Misa Solemne', 'Vía Crucis'],
        tipo: 'Religiosa',
        mes: 'Abril',
        esDestacada: true,
        latitud: -13.5160,
        longitud: -71.9788,
      ),
      Festivity(
        id: '3',
        nombre: 'Corpus Christi',
        descripcion: 'Procesión en la que se reúnen las imágenes de los santos y vírgenes de Cusco en una gran celebración.',
        fecha: 'Junio (movible)',
        ubicacion: 'Plaza de Armas del Cusco',
        historia: 'Fiesta católica que combina tradiciones españolas con rituales andinos prehispánicos.',
        imagenes: [
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&auto=format&fit=crop&q=80'
        ],
        actividades: ['Procesión de Santos', 'Misa Central', 'Ferias Gastronómicas'],
        tipo: 'Religiosa',
        mes: 'Junio',
        esDestacada: true,
        latitud: -13.5167,
        longitud: -71.9789,
      ),
      Festivity(
        id: '4',
        nombre: 'Virgen del Carmen',
        descripcion: 'Celebración en honor a la Virgen del Carmen en Paucartambo, con coloridas danzas y tradiciones.',
        fecha: '16 de Julio',
        ubicacion: 'Paucartambo, Cusco',
        historia: 'Fiesta que combina elementos católicos con tradiciones andinas, famosa por sus máscaras y danzas.',
        imagenes: [
          'https://images.unsplash.com/photo-1551632811-561732d1e306?w=800&auto=format&fit=crop&q=80'
        ],
        actividades: ['Danzas Tradicionales', 'Procesión', 'Feria Artesanal'],
        tipo: 'Religiosa',
        mes: 'Julio',
        esDestacada: true,
        latitud: -13.3156,
        longitud: -71.6028,
      ),
    ];
  }

  Future<Festivity?> getFestivityById(String id) async {
    final allFestivities = await fetchFestivities();
    try {
      return allFestivities.firstWhere((festivity) => festivity.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Festivity>> fetchFestivitiesByMonth(String month) async {
    final allFestivities = await fetchFestivities();
    return allFestivities.where((f) => f.mes == month).toList();
  }

  Future<List<Festivity>> fetchFeaturedFestivities() async {
    final allFestivities = await fetchFestivities();
    return allFestivities.where((f) => f.esDestacada).toList();
  }

  Future<List<Festivity>> searchFestivities(String query) async {
    final allFestivities = await fetchFestivities();
    if (query.isEmpty) return allFestivities;
    
    return allFestivities.where((f) =>
      f.nombre.toLowerCase().contains(query.toLowerCase()) ||
      f.ubicacion.toLowerCase().contains(query.toLowerCase()) ||
      f.descripcion.toLowerCase().contains(query.toLowerCase()) ||
      f.tipo.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}