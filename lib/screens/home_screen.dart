import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/festivity_card.dart';
import '../models/festivity.dart';
import 'festivities_screen.dart';
import 'weather_screen.dart';
import 'user_screens.dart';
// Nuevas importaciones para sitios arqueológicos
import '../sitios_arqueologicos/screens/sitios_screen.dart';
import '../sitios_arqueologicos/viewmodels/sitio_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: _isSearching 
            ? _buildSearchField()
            : const Text(
                'Cusco 360',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
        actions: [
          if (!_isSearching)
            IconButton(
              tooltip: 'Buscar',
              icon: const Icon(Icons.search, color: Color(0xFF475569)),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ),
          IconButton(
            tooltip: 'Notificaciones',
            icon: const Icon(Icons.notifications_none, color: Color(0xFF475569)),
            onPressed: () {},
          ),
        ],
      ),

      // CONTENIDO PRINCIPAL
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Barra de búsqueda (alternativa si prefieres mantenerla en el body)
              if (!_isSearching) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          SizedBox(width: 16),
                          Icon(Icons.search, color: Color(0xFF64748B)),
                          SizedBox(width: 12),
                          Text(
                            'Buscar en Cusco...',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // 🔹 Sección: Explora Cusco
              if (!_isSearching) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Explora Cusco',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 🔹 Grid de Explora Cusco
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      _buildExploreCard(
                        'Festividades',
                        Icons.celebration,
                        const Color(0xFF4F46E5),
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FestivitiesScreen(),
                            ),
                          );
                        },
                      ),
                      _buildExploreCard(
                        'Sitios Arqueológicos',
                        Icons.landscape,
                        const Color(0xFF059669),
                        () {
                          _showSitiosScreen(context);
                        },
                      ),
                      _buildExploreCard(
                        'Rutas Turísticas',
                        Icons.map,
                        const Color(0xFFDC2626),
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Rutas Turísticas')),
                          );
                        },
                      ),
                      _buildExploreCard(
                        'Hoteles y Guías',
                        Icons.hotel,
                        const Color(0xFF7C3AED),
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Hoteles y Guías')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // 🔹 Sección: Descubre
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Descubre',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 🔹 Tarjetas de Descubre
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildDiscoverCard(
                        'Camino Inca',
                        'Una ruta histórica ancestral',
                        'https://images.unsplash.com/photo-1580502304784-8985b7eb7260?w=400&auto=format&fit=crop&q=60',
                      ),
                      const SizedBox(width: 12),
                      _buildDiscoverCard(
                        'Valle Sagrado',
                        'Belleza y cultura andina',
                        'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=400&auto=format&fit=crop&q=60',
                      ),
                      const SizedBox(width: 12),
                      _buildDiscoverCard(
                        'Machu Picchu',
                        'Maravilla del mundo',
                        'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=400&auto=format&fit=crop&q=60',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // 🔹 Festividades destacadas
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Festividades destacadas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 🔹 Lista horizontal de festividades
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildFestivityCard(
                        'Inti Raymi',
                        '24 de Junio',
                        'https://images.unsplash.com/photo-1580502304784-8985b7eb7260?w=300&auto=format&fit=crop&q=60',
                      ),
                      const SizedBox(width: 12),
                      _buildFestivityCard(
                        'Corpus Christi',
                        'Mes de Junio',
                        'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=300&auto=format&fit=crop&q=60',
                      ),
                      const SizedBox(width: 12),
                      _buildFestivityCard(
                        'Virgen del Carmen',
                        '16 de Julio',
                        'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=300&auto=format&fit=crop&q=60',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],

              // 🔹 Resultados de búsqueda
              if (_isSearching) ...[
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Resultados de búsqueda',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                _buildSearchResults(),
              ],
            ],
          ),
        ),
      ),

      // 🔹 Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: const Color(0xFF94A3B8),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _handleNavigation(context, index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.celebration_outlined),
            activeIcon: Icon(Icons.celebration),
            label: 'Festividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place_outlined),
            activeIcon: Icon(Icons.place),
            label: 'Sitios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Buscar festividades, sitios...',
        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF64748B)),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchController.clear();
            });
          },
        ),
      ),
      style: const TextStyle(color: Color(0xFF0F172A)),
      onChanged: (value) {
        setState(() {});
      },
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Buscando: $value')),
          );
        }
      },
    );
  }

  Widget _buildSearchResults() {
    final query = _searchController.text.toLowerCase();
    
    if (query.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Escribe algo para buscar...',
          style: TextStyle(color: Color(0xFF64748B)),
        ),
      );
    }

    // Simulación de resultados de búsqueda
    final results = [
      {'title': 'Inti Raymi', 'type': 'Festividad', 'subtitle': '24 de Junio'},
      {'title': 'Machu Picchu', 'type': 'Sitio Arqueológico', 'subtitle': 'Valle Sagrado'},
      {'title': 'Corpus Christi', 'type': 'Festividad', 'subtitle': 'Junio'},
    ].where((item) => 
        item['title']!.toLowerCase().contains(query) ||
        item['type']!.toLowerCase().contains(query) ||
        item['subtitle']!.toLowerCase().contains(query)
    ).toList();

    if (results.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'No se encontraron resultados',
          style: TextStyle(color: Color(0xFF64748B)),
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              item['type'] == 'Festividad' ? Icons.celebration : Icons.place,
              color: const Color(0xFF475569),
            ),
          ),
          title: Text(item['title']!),
          subtitle: Text('${item['type']} • ${item['subtitle']}'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Abriendo ${item['title']}')),
            );
          },
        );
      },
    );
  }

  Widget _buildExploreCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscoverCard(String title, String subtitle, String imageUrl) {
    return Container(
      width: 280,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFestivityCard(String title, String date, String imageUrl) {
    return GestureDetector(
      onTap: () {
        _showFestivityDetails(context, title, date);
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Ya estamos en Home
        break;
      case 1:
        // Navegar a Festividades
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FestivitiesScreen(),
          ),
        );
        break;
      case 2:
        // Navegar a Sitios
        _showSitiosScreen(context);
        break;
      case 3:
        // Navegar a Mapa/Clima
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WeatherScreen(),
          ),
        );
        break;
      case 4:
        // Navegar a Perfil
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserScreens(),
          ),
        );
        break;
    }
  }

  void _showFestivityDetails(BuildContext context, String title, String date) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text('Fecha: $date'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showSitiosScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => SitioViewModel(),
          child: const SitiosScreen(),
        ),
      ),
    );
  }
}