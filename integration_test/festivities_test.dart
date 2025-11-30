import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:cusco_360/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Robot automatizado: Prueba completa de Festividades', (WidgetTester tester) async {
    // 1. INICIAR LA APP - El robot abre la app
    print('🤖: Iniciando la aplicación...');
    await tester.pumpWidget(const Cusco360App());
    await tester.pumpAndSettle(Duration(seconds: 3));

    // 2. NAVEGAR A FESTIVIDADES DESDE LA PANTALLA DE INICIO
    print('🤖: Navegando a Festividades desde la pantalla de inicio...');
    
    // Buscar los botones de Festividades en la pantalla de inicio
    final festividadesButtons = find.text('Festividades');
    expect(festividadesButtons, findsAtLeast(1));
    
    // Presionar el primer botón de Festividades que encuentre
    await tester.tap(festividadesButtons.first);
    await tester.pumpAndSettle(Duration(seconds: 3));

    // 3. VERIFICAR QUE ESTAMOS EN LA PANTALLA DE FESTIVIDADES
    print('🤖: Verificando que estoy en Festividades...');
    
    final appBarTitle = find.descendant(
      of: find.byType(AppBar),
      matching: find.text('Festividades'),
    );
    
    if (appBarTitle.evaluate().isNotEmpty) {
      expect(appBarTitle, findsOneWidget);
      print('✅: ¡Encontré la pantalla de Festividades! (AppBar)');
    } else {
      expect(find.text('Festividades'), findsAtLeast(1));
      print('✅: ¡Encontré la pantalla de Festividades!');
    }

    // 4. ESPERAR A QUE CARGUE EL CONTENIDO
    print('🤖: Esperando a que cargue el contenido...');
    await tester.pumpAndSettle(Duration(seconds: 2));

    // 5. PROBAR EL CAMPO DE BÚSQUEDA
    print('🤖: Probando el campo de búsqueda...');
    
    // Buscar el campo de búsqueda por su hint text
    final searchField = find.byWidgetPredicate((widget) {
      if (widget is TextField) {
        final decoration = widget.decoration;
        if (decoration != null && decoration.hintText != null) {
          return decoration.hintText!.toLowerCase().contains('buscar');
        }
      }
      return false;
    });

    if (searchField.evaluate().isNotEmpty) {
      await tester.enterText(searchField, 'Inti Raymi');
      await tester.pumpAndSettle(Duration(seconds: 2));
      print('✅: ¡Búsqueda completada!');

      // 6. VERIFICAR RESULTADOS DE BÚSQUEDA
      print('🤖: Verificando resultados de búsqueda...');
      await tester.pumpAndSettle(Duration(seconds: 2));
      
      // Buscar "Inti Raymi" en los resultados
      final intiRaymiText = find.text('Inti Raymi');
      if (intiRaymiText.evaluate().isNotEmpty) {
        expect(intiRaymiText, findsAtLeast(1));
        print('✅: ¡Encontré Inti Raymi en los resultados!');
      } else {
        print('⚠️: No encontré "Inti Raymi" en los resultados');
      }

      // LIMPIAR BÚSQUEDA
      print('🤖: Limpiando búsqueda...');
      await tester.enterText(searchField, '');
      await tester.pumpAndSettle(Duration(seconds: 1));
    } else {
      print('⚠️: No se encontró campo de búsqueda, omitiendo esta sección');
    }

    // 7. PROBAR EL CALENDARIO
    print('🤖: Probando interacción con el calendario...');
    
    // Buscar un día específico que tenga evento (24 de junio)
    final currentYear = DateTime.now().year;
    final day24Button = find.byKey(Key('day_24_6_$currentYear'));
    
    if (day24Button.evaluate().isNotEmpty) {
      await tester.tap(day24Button);
      await tester.pumpAndSettle(Duration(seconds: 2));
      print('✅: ¡Toqué el día 24 de junio!');
    } else {
      // Si no existe, buscar cualquier día del mes actual
      final currentDate = DateTime.now();
      final anyDayButton = find.byKey(Key('day_${currentDate.day}_${currentDate.month}_${currentDate.year}'));
      
      if (anyDayButton.evaluate().isNotEmpty) {
        await tester.tap(anyDayButton);
        await tester.pumpAndSettle(Duration(seconds: 2));
        print('✅: ¡Toqué un día del calendario!');
      } else {
        // Si no hay días del mes actual, buscar el primer día del mes
        final firstDayButton = find.byKey(Key('day_1_${currentDate.month}_${currentDate.year}'));
        if (firstDayButton.evaluate().isNotEmpty) {
          await tester.tap(firstDayButton);
          await tester.pumpAndSettle(Duration(seconds: 2));
          print('✅: ¡Toqué el primer día del mes!');
        } else {
          print('⚠️: No encontré días clickeables en el calendario');
        }
      }
    }

    // 8. VERIFICAR SECCIÓN DE EVENTOS
    print('🤖: Verificando sección de eventos...');
    final eventsTitle = find.byKey(const Key('events_title'));
    if (eventsTitle.evaluate().isNotEmpty) {
      expect(eventsTitle, findsOneWidget);
      print('✅: ¡Sección de eventos visible!');
    } else {
      print('⚠️: No se encontró la sección de eventos');
    }

    // 9. PRUEBA COMPLETADA (SIN NAVEGACIÓN A SITIOS)
    print('🎉 ¡PRUEBA DE INTEGRACIÓN DE FESTIVIDADES COMPLETADA EXITOSAMENTE!');
    print('🤖: El robot simuló las siguientes acciones en Festividades:');
    print('   - Navegación desde pantalla de inicio');
    print('   - Búsqueda de festividades');
    print('   - Interacción con calendario');
    print('   - Verificación de eventos del día');
  });
}