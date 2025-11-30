import 'package:flutter/material.dart';
import '../models/sitio_arqueologico.dart';

class SitioCard extends StatelessWidget {
  final SitioArqueologico sitio;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const SitioCard({
    super.key,
    required this.sitio,
    required this.onTap,
    this.onFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Imagen de fondo
              _buildImage(),
              
              // Gradiente overlay
              _buildGradient(),
              
              // Contenido
              _buildContent(),
              
              // Badge popular
              if (sitio.esPopular) _buildPopularBadge(),
              
              // Botón favorito
              if (onFavorite != null) _buildFavoriteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Image.network(
        sitio.imagenes.first,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[200],
            child: const Icon(Icons.photo, size: 50, color: Colors.grey),
          );
        },
      ),
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.transparent,
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre
          Text(
            sitio.nombre,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Descripción corta
          Text(
            sitio.descripcionCorta,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black45,
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 12),
          
          // Información adicional
          _buildInfoRow(),
        ],
      ),
    );
  }

  Widget _buildInfoRow() {
    return Row(
      children: [
        // Calificación
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.star, size: 14, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                sitio.calificacion.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Ubicación
        Expanded(
          child: Row(
            children: [
              const Icon(Icons.location_on, size: 14, color: Colors.white),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  sitio.ubicacion.split(',')[0], // Solo la primera parte
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        
        // Tiempo de visita
        Row(
          children: [
            const Icon(Icons.access_time, size: 14, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              '${sitio.tiempoVisita}h',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPopularBadge() {
    return Positioned(
      top: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Icon(Icons.trending_up, size: 12, color: Colors.white),
            SizedBox(width: 4),
            Text(
              'POPULAR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      top: 12,
      right: 12,
      child: GestureDetector(
        onTap: onFavorite,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}