import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sitio_arqueologico.dart';
import '../viewmodels/sitio_viewmodel.dart';
import '../widgets/sitio_card.dart';
import 'sitio_detail_screen.dart';
// CORRECCIÓN: Subir 3 niveles
import '../../../screens/home_screen.dart';
import '../../../screens/festivities_screen.dart';

class SitiosScreen extends StatefulWidget {
  const SitiosScreen({super.key});

  @override
  State<SitiosScreen> createState() => _SitiosScreenState();
}

class _SitiosScreenState extends State<SitiosScreen> {
  int _indiceSeleccionado = 2;
  final TextEditingController _controladorBusqueda = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controladorBusqueda.addListener(_onBuscarCambio);
  }

  @override
  void dispose() {
    _controladorBusqueda.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onBuscarCambio() {
    final viewModel = context.read<SitioViewModel>();
    viewModel.buscarSitios(_controladorBusqueda.text);
  }

  void _navegarDetalleSitio(SitioArqueologico sitio) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SitioDetailScreen(sitio: sitio),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void _toggleFavorite(String sitioId) {
    // Implementar lógica de favoritos
    print('Toggle favorite: $sitioId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // AppBar personalizado
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF4F46E5),
                      Color(0xFF7C3AED),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Patrón de fondo
                    _buildBackgroundPattern(),
                    
                    // Contenido del header
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descubre',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Sitios Arqueológicos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Explora la magia del Imperio Inca',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Barra de búsqueda
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _controladorBusqueda,
                  decoration: InputDecoration(
                    hintText: 'Buscar sitios arqueológicos...',
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF4F46E5)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Lista de sitios
          Consumer<SitioViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.cargando && viewModel.sitios.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Color(0xFF4F46E5)),
                    ),
                  ),
                );
              }

              if (viewModel.sitios.isEmpty) {
                return SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.explore_off,
                        size: 80,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No se encontraron sitios',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Intenta con otros términos de búsqueda',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final sitio = viewModel.sitios[index];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, index == viewModel.sitios.length - 1 ? 16 : 0),
                      child: SitioCard(
                        sitio: sitio,
                        onTap: () => _navegarDetalleSitio(sitio),
                        onFavorite: () => _toggleFavorite(sitio.id),
                        isFavorite: false, // Implementar lógica de favoritos
                      ),
                    );
                  },
                  childCount: viewModel.sitios.length,
                ),
              );
            },
          ),
        ],
      ),

      // Barra de navegación inferior
      bottomNavigationBar: _construirBarraNavegacion(context),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned(
      right: -50,
      top: -50,
      child: Opacity(
        opacity: 0.1,
        child: Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  BottomNavigationBar _construirBarraNavegacion(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _indiceSeleccionado,
      selectedItemColor: const Color(0xFF4F46E5),
      unselectedItemColor: const Color(0xFF94A3B8),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      onTap: (indice) => _manejarNavegacion(context, indice),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.celebration_outlined),
          activeIcon: Icon(Icons.celebration_rounded),
          label: 'Festividades',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          activeIcon: Icon(Icons.explore_rounded),
          label: 'Descubrir',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          activeIcon: Icon(Icons.map_rounded),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Perfil',
        ),
      ],
    );
  }

  void _manejarNavegacion(BuildContext context, int indice) {
    switch (indice) {
      case 0:
        // Navegar a Inicio (HomeScreen)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        // Navegar a Festividades (FestivitiesScreen)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FestivitiesScreen()),
        );
        break;
      case 2:
        // Ya estamos en Sitios/Descubrir
        break;
      case 3:
        // Navegar a Mapa - Comentado hasta que crees la pantalla
        _mostrarMensajeProximamente(context, 'Mapa');
        break;
      case 4:
        // Navegar a Perfil - Comentado hasta que crees la pantalla
        _mostrarMensajeProximamente(context, 'Perfil');
        break;
    }
  }

  void _mostrarMensajeProximamente(BuildContext context, String pantalla) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$pantalla - Próximamente'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}