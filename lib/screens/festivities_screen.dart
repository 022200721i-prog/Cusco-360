import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/festivity.dart';
import '../services/mock_service.dart';
import '../widgets/festivity_card.dart';
import 'festivity_detail.dart';
import 'weather_screen.dart';
import 'user_screens.dart';
import '../sitios_arqueologicos/screens/sitios_screen.dart';
import '../sitios_arqueologicos/viewmodels/sitio_viewmodel.dart';

class FestivitiesScreen extends StatefulWidget {
  const FestivitiesScreen({super.key});

  @override
  State<FestivitiesScreen> createState() => _FestivitiesScreenState();
}

class _FestivitiesScreenState extends State<FestivitiesScreen> {
  final MockService _service = MockService();
  List<Festivity> _festivities = [];
  List<Festivity> _filteredFestivities = [];
  String _query = '';
  DateTime _selectedDate = DateTime.now();
  int _selectedIndex = 1;
  DateTime _currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFestivities();
  }

  Future<void> _loadFestivities() async {
    setState(() {
      _isLoading = true;
    });
    
    final data = await _service.fetchFestivities();
    setState(() {
      _festivities = data;
      _filteredFestivities = data;
      _isLoading = false;
    });
  }

  // NUEVA FUNCIÓN: Convertir fecha String a DateTime
  DateTime? _parseDateFromString(String dateString) {
    try {
      final parts = dateString.split(' ');
      if (parts.length >= 3) {
        final day = int.tryParse(parts[0]);
        final monthName = parts[2].toLowerCase();
        
        final monthMap = {
          'enero': 1, 'febrero': 2, 'marzo': 3, 'abril': 4,
          'mayo': 5, 'junio': 6, 'julio': 7, 'agosto': 8,
          'septiembre': 9, 'octubre': 10, 'noviembre': 11, 'diciembre': 12
        };
        
        final month = monthMap[monthName];
        
        if (day != null && month != null) {
          return DateTime(DateTime.now().year, month, day);
        }
      }
    } catch (e) {
      print('Error parsing date: $e');
    }
    return null;
  }

  List<Festivity> _getEventsForSelectedDate() {
    return _festivities.where((festivity) {
      final festivityDate = _parseDateFromString(festivity.fecha);
      if (festivityDate != null) {
        return festivityDate.day == _selectedDate.day && 
               festivityDate.month == _selectedDate.month;
      }
      return false;
    }).toList();
  }

  List<DateTime> _getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final days = <DateTime>[];
    
    final firstWeekday = firstDay.weekday;
    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(firstDay.subtract(Duration(days: i)));
    }
    
    for (int i = 0; i < lastDay.day; i++) {
      days.add(DateTime(month.year, month.month, i + 1));
    }
    
    final totalDays = days.length;
    final daysNeeded = 42 - totalDays;
    for (int i = 1; i <= daysNeeded; i++) {
      days.add(lastDay.add(Duration(days: i)));
    }
    
    return days;
  }

  void _selectDate(DateTime date) {
    if (date.month == _currentMonth.month) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _changeMonth(int delta) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + delta, 1);
    });
  }

  void _filterFestivities(String query) {
    setState(() {
      _query = query;
      if (query.isEmpty) {
        _filteredFestivities = _festivities;
      } else {
        _filteredFestivities = _festivities.where((f) =>
          f.nombre.toLowerCase().contains(query.toLowerCase()) ||
          f.ubicacion.toLowerCase().contains(query.toLowerCase()) ||
          f.descripcion.toLowerCase().contains(query.toLowerCase()) ||
          f.tipo.toLowerCase().contains(query.toLowerCase())
        ).toList();
      }
    });
  }

  void _navigateToFestivityDetail(Festivity festivity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FestivityDetailScreen(festivity: festivity),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dailyEvents = _getEventsForSelectedDate();
    final daysInMonth = _getDaysInMonth(_currentMonth);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Festividades',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF475569)),
            onPressed: _loadFestivities,
            tooltip: 'Recargar',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildCalendarSection(daysInMonth),
                  _buildDailyEventsSection(dailyEvents),
                  _buildAllFestivitiesSection(),
                ],
              ),
            ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCalendarSection(List<DateTime> days) {
    final monthNames = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];

    return Container(
      margin: const EdgeInsets.all(16),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${monthNames[_currentMonth.month - 1]} ${_currentMonth.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 20),
                      onPressed: () => _changeMonth(-1),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 20),
                      onPressed: () => _changeMonth(1),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                _CalendarDay(label: 'D', isHeader: true),
                _CalendarDay(label: 'L', isHeader: true),
                _CalendarDay(label: 'M', isHeader: true),
                _CalendarDay(label: 'M', isHeader: true),
                _CalendarDay(label: 'J', isHeader: true),
                _CalendarDay(label: 'V', isHeader: true),
                _CalendarDay(label: 'S', isHeader: true),
              ],
            ),
            const SizedBox(height: 8),
            
            Column(
              children: [
                for (int week = 0; week < 6; week++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        for (int day = 0; day < 7; day++)
                          Expanded(
                            child: _buildInteractiveDay(days[week * 7 + day]),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveDay(DateTime date) {
    final isCurrentMonth = date.month == _currentMonth.month;
    final isSelected = _selectedDate.year == date.year &&
        _selectedDate.month == date.month &&
        _selectedDate.day == date.day;
    
    // CORREGIDO: Usar la función de conversión
    final hasEvent = _festivities.any((festivity) {
      final festivityDate = _parseDateFromString(festivity.fecha);
      if (festivityDate != null) {
        return festivityDate.day == date.day && 
               festivityDate.month == date.month;
      }
      return false;
    });

    return GestureDetector(
      key: Key('day_${date.day}_${date.month}_${date.year}'),
      onTap: () => _selectDate(date),
      child: Container(
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4F46E5) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: isCurrentMonth
                    ? (isSelected ? Colors.white : const Color(0xFF0F172A))
                    : const Color(0xFFCBD5E1),
              ),
            ),
            if (hasEvent && isCurrentMonth)
              Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.only(top: 2),
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyEventsSection(List<Festivity> events) {
    final monthNames = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eventos en ${_selectedDate.day} de ${monthNames[_selectedDate.month - 1]} de ${_selectedDate.year}',
              key: const Key('events_title'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 16),

            if (events.isEmpty)
              const Center(
                child: Text(
                  'No hay eventos programados para esta fecha',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              Column(
                children: events.map((festivity) {
                  return GestureDetector(
                    onTap: () => _navigateToFestivityDetail(festivity),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4F46E5),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  festivity.nombre,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  festivity.descripcion,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF475569),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 14, color: Color(0xFF64748B)),
                                    const SizedBox(width: 4),
                                    Text(
                                      festivity.ubicacion,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF64748B)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllFestivitiesSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Todas las Festividades',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar por nombre, ubicación o tipo...',
              prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
            ),
            onChanged: _filterFestivities,
          ),
          const SizedBox(height: 16),

          if (_filteredFestivities.isEmpty)
            const Center(
              child: Column(
                children: [
                  Icon(Icons.search_off, size: 64, color: Color(0xFFCBD5E1)),
                  SizedBox(height: 16),
                  Text(
                    'No se encontraron festividades',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _filteredFestivities.length,
              itemBuilder: (context, index) {
                final festivity = _filteredFestivities[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: FestivityCard(
                    festivity: festivity,
                    onTap: () => _navigateToFestivityDetail(festivity),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      key: const Key('bottom_navigation'),
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
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
        // Ya estamos en Festividades
        break;
      case 2:
        _showSitiosScreen(context);
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WeatherScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserScreens()),
        );
        break;
    }
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

class _CalendarDay extends StatelessWidget {
  final String label;
  final bool isHeader;

  const _CalendarDay({
    required this.label,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? const Color(0xFF64748B) : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}