import 'package:flutter/material.dart';
import '../models/sitio_arqueologico.dart';
import '../services/sitio_service.dart';

class SitioViewModel with ChangeNotifier {
  final SitioService _service = SitioService();
  List<SitioArqueologico> _sitios = [];
  List<SitioArqueologico> _sitiosFiltrados = [];
  bool _cargando = false;
  String _error = '';

  List<SitioArqueologico> get sitios => _sitiosFiltrados;
  bool get cargando => _cargando;
  String get error => _error;

  SitioViewModel() {
    cargarSitios();
  }

  Future<void> cargarSitios() async {
    _cargando = true;
    notifyListeners();

    try {
      _sitios = await _service.obtenerSitios();
      _sitiosFiltrados = _sitios;
      _error = '';
    } catch (e) {
      _error = 'Error al cargar los sitios: $e';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<void> agregarSitio(SitioArqueologico sitio) async {
    _cargando = true;
    notifyListeners();

    try {
      final nuevoSitio = await _service.agregarSitio(sitio);
      _sitios.add(nuevoSitio);
      _sitiosFiltrados = _sitios;
      _error = '';
    } catch (e) {
      _error = 'Error al agregar el sitio: $e';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<void> actualizarSitio(SitioArqueologico sitio) async {
    _cargando = true;
    notifyListeners();

    try {
      final sitioActualizado = await _service.actualizarSitio(sitio);
      final index = _sitios.indexWhere((s) => s.id == sitio.id);
      if (index != -1) {
        _sitios[index] = sitioActualizado;
        _sitiosFiltrados = _sitios;
      }
      _error = '';
    } catch (e) {
      _error = 'Error al actualizar el sitio: $e';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<void> eliminarSitio(String id) async {
    _cargando = true;
    notifyListeners();

    try {
      await _service.eliminarSitio(id);
      _sitios.removeWhere((sitio) => sitio.id == id);
      _sitiosFiltrados = _sitios;
      _error = '';
    } catch (e) {
      _error = 'Error al eliminar el sitio: $e';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  void buscarSitios(String consulta) async {
    if (consulta.isEmpty) {
      _sitiosFiltrados = _sitios;
    } else {
      _sitiosFiltrados = await _service.buscarSitios(consulta);
    }
    notifyListeners();
  }

  Future<List<SitioArqueologico>> obtenerSitiosPopulares() async {
    return await _service.obtenerSitiosPopulares();
  }

  Future<List<SitioArqueologico>> obtenerSitiosPorTipo(String tipo) async {
    return await _service.obtenerSitiosPorTipo(tipo);
  }

  void limpiarError() {
    _error = '';
    notifyListeners();
  }
}