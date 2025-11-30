import 'package:flutter/material.dart';
import '../models/sitio_arqueologico.dart';

class AddEditSitioScreen extends StatefulWidget {
  final SitioArqueologico? sitio;

  const AddEditSitioScreen({super.key, this.sitio});

  @override
  State<AddEditSitioScreen> createState() => _AddEditSitioScreenState();
}

class _AddEditSitioScreenState extends State<AddEditSitioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sitio == null ? 'Agregar Sitio' : 'Editar Sitio'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Formulario para agregar/editar sitios'),
      ),
    );
  }
}