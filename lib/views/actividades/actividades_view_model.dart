import 'package:binance_api_test/core/authentication_client.dart';
import 'package:binance_api_test/core/database/tables/actividades_table.dart';
import 'package:binance_api_test/core/database/tables/equipos_asignados_table.dart';
import 'package:binance_api_test/core/database/tables/equipos_table.dart';
import 'package:binance_api_test/core/locator.dart';
import 'package:binance_api_test/core/models/actividades_response.dart';
import 'package:binance_api_test/core/models/equipos_asignados_response.dart';
import 'package:binance_api_test/core/models/equipos_response.dart';
import 'package:binance_api_test/core/providers/equipo_seleccionado_provider.dart';
import 'package:binance_api_test/core/services/navigator_service.dart';
import 'package:binance_api_test/views/detalles_equipo/detalles_equipo_view.dart';
import 'package:binance_api_test/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ActividadesViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;

  List<Actividad> actividadesList = [];
  late EquiposAsignadosResponse equipoAsignado;
  List<ActividadData> actividadesData = [];
  Map<String, List<Actividad>> actividadesPorCategoria = {};
  Actividad? actividadSeleccionada;
  ActividadesDB actividadesDB = ActividadesDB();
  EquiposDB equiposDB = EquiposDB();
  EquiposAsignadosDB equiposAsignadosDB = EquiposAsignadosDB();
  final authenticationClient = locator<AuthenticationClient>();

  TextEditingController horaInicioController = TextEditingController();
  TextEditingController horaFinController = TextEditingController();
  TextEditingController horometroController = TextEditingController();

  String? laborSeleccionada;
  List<String> labores = ["Labor 1", "Labor 2", "Labor 3"];
  bool actividadRequiereHorometro = false;
  final _navigationService = locator<NavigatorService>();

  void cargarActividades() {
    actividadesPorCategoria = {
      "Mantenimiento": [
        Actividad(
            nombre: "Inspección de rutina del equipo",
            requiereHorometro: false),
        Actividad(nombre: "Mantenimiento preventivo", requiereHorometro: false),
        Actividad(nombre: "Cambio de aceite", requiereHorometro: false),
        Actividad(nombre: "Ajuste de frenos", requiereHorometro: false),
        Actividad(
            nombre: "Revisión de sistemas hidráulicos",
            requiereHorometro: false),
        Actividad(nombre: "Reemplazo de filtros", requiereHorometro: false),
      ],
      "Operación": [
        Actividad(nombre: "Excavación de material", requiereHorometro: true),
        Actividad(nombre: "Transporte de material", requiereHorometro: true),
        Actividad(nombre: "Carga de material", requiereHorometro: true),
        Actividad(nombre: "Descarga de material", requiereHorometro: true),
        Actividad(nombre: "Compactación de material", requiereHorometro: true),
      ],
    };
    notifyListeners();
  }

  Future<void> seleccionarHoraInicio(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      horaInicioController.text = picked.format(context);
    }
  }

  Future<void> seleccionarHoraFin(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      horaFinController.text = picked.format(context);
    }
  }

  void seleccionarActividad(Actividad actividad, BuildContext context) {
    var providerEquipoSeleccionado =
        Provider.of<EquipoSeleccionadoProvider>(context, listen: false);
    actividadSeleccionada = actividad;
    horaInicioController.clear();
    horaFinController.clear();
    if (actividadesData.isNotEmpty) {
      horaInicioController.text = actividadesData.last.horaFin;
    }
    laborSeleccionada = providerEquipoSeleccionado.labor;
    actividadRequiereHorometro = actividad.requiereHorometro;
    if (actividadRequiereHorometro) {
      horometroController.text = providerEquipoSeleccionado
              .equipoSeleccionado.valorHorometro
              .toString() +
          " horas"; // Obtener el valor actual del horómetro de la BD
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Formulario de Actividad'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: horaInicioController,
                  enabled: actividadesData.isEmpty,
                  decoration:
                      const InputDecoration(labelText: 'Hora de Inicio'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la hora de inicio';
                    }
                    return null;
                  },
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    await seleccionarHoraInicio(context);
                  },
                ),
                TextFormField(
                  controller: horaFinController,
                  decoration: const InputDecoration(labelText: 'Hora de Fin'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la hora de fin';
                    }
                    DateTime horaInicio =
                        DateFormat('HH:mm').parse(horaInicioController.text);
                    DateTime horaFin = DateFormat('HH:mm').parse(value);
                    if (horaFin.isBefore(horaInicio)) {
                      return 'Seleccione una hora adecuada';
                    }
                    return null;
                  },
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    await seleccionarHoraFin(context);
                  },
                ),
                DropdownButtonFormField<String>(
                  value: laborSeleccionada,
                  items: labores.map((String labor) {
                    return DropdownMenuItem<String>(
                      value: labor,
                      child: Text(labor),
                    );
                  }).toList(),
                  onChanged: (String? newValue) async {
                    providerEquipoSeleccionado.setLabor(labor: newValue ?? "");
                    var equipoAsignado =
                        await equiposAsignadosDB.getEquipoAsignadoDelDia(
                            idUsuario: int.tryParse(
                                    authenticationClient.loadUsuario.id) ??
                                0);
                    await equiposAsignadosDB.actualizarLabor(
                        idEquipoAsignado:
                            equipoAsignado.data.first.idEquipoAsignado,
                        nuevaLabor: newValue ?? "");
                    setLaborSeleccionada(newValue);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Labor',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor seleccione una labor';
                    }
                    return null;
                  },
                ),
                if (actividadRequiereHorometro)
                  TextFormField(
                    controller: horometroController,
                    decoration: const InputDecoration(labelText: 'Horómetro'),
                    readOnly: true,
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await guardarActividad(context, actividadRequiereHorometro);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
    notifyListeners();
  }

  void setLaborSeleccionada(String? labor) {
    laborSeleccionada = labor;
    notifyListeners();
  }

  Future<void> guardarActividad(
      BuildContext context, bool requiereHorometro) async {
    if (formKey.currentState!.validate()) {
      // Convertir las horas a objetos DateTime
      DateTime horaInicio =
          DateFormat('HH:mm').parse(horaInicioController.text);
      DateTime horaFin = DateFormat('HH:mm').parse(horaFinController.text);
      var providerEquipoSeleccionado =
          Provider.of<EquipoSeleccionadoProvider>(context, listen: false);

      // Calcular la diferencia en horas
      double diferenciaHoras = horaFin.difference(horaInicio).inMinutes / 60.0;

      double totalHoras = diferenciaHoras;
      for (var actividad in actividadesData) {
        DateTime actividadInicio =
            DateFormat('HH:mm').parse(actividad.horaInicio);
        DateTime actividadFin = DateFormat('HH:mm').parse(actividad.horaFin);
        totalHoras += actividadFin.difference(actividadInicio).inMinutes / 60.0;
      }
      if (totalHoras > 12.0) {
        Dialogs.error(msg: 'El total de horas no debe superar las 12 horas');
        return;
      }

      if (requiereHorometro) {
        // Actualizar el valor del horómetro en la base de datos
        int idEquipo =
            int.tryParse(providerEquipoSeleccionado.equipoSeleccionado.id) ?? 0;
        await equiposDB.actualizarValorHorometro(
            idEquipo: idEquipo, incrementoValorHorometro: diferenciaHoras);

        await equiposDB.selectById(idEquipo).then((value) {
          providerEquipoSeleccionado.setEquipo(equipo: value!);
        });
      }
      // Insertar la actividad en la base de datos
      await actividadesDB.insert(
        nombre: actividadSeleccionada!.nombre,
        idEquipo: int.parse(providerEquipoSeleccionado.equipoSeleccionado.id),
        idUsuario: int.parse(authenticationClient.loadUsuario.id),
        fechaActividad: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        horaInicio: horaInicioController.text,
        horaFin: horaFinController.text,
        labor: laborSeleccionada ?? "",
        horaHorometro: diferenciaHoras,
        jefeMina: providerEquipoSeleccionado.jefeMina,
        nombreMina: providerEquipoSeleccionado.nombreMina,
      );

      var actividades = await actividadesDB.selectActividadesDelDia(
          idEquipo:
              int.tryParse(providerEquipoSeleccionado.equipoSeleccionado.id) ??
                  0,
          idUsuario: int.tryParse(authenticationClient.loadUsuario.id) ?? 0);
      actividadesData = actividades.data;

      // Limpiar los campos del formulario
      horaInicioController.clear();
      horaFinController.clear();
      laborSeleccionada = null;
      horometroController.clear();

      notifyListeners();
    }
  }

  void goToDetallesEquipo() {
    _navigationService.navigateToPage(DetallesEquipoView.routeName);
  }

  Future<void> onInit(BuildContext context) async {
    var providerEquipoSeleccionado =
        Provider.of<EquipoSeleccionadoProvider>(context, listen: false);
    loading = true;
    cargarActividades();
    equipoAsignado = await equiposAsignadosDB.getEquipoAsignadoDelDia(
        idUsuario: int.tryParse(authenticationClient.loadUsuario.id) ?? 0);
    var actividades = await actividadesDB.selectActividadesDelDia(
        idEquipo:
            int.tryParse(providerEquipoSeleccionado.equipoSeleccionado.id) ?? 0,
        idUsuario: int.tryParse(authenticationClient.loadUsuario.id) ?? 0);
    actividadesData = actividades.data;

    notifyListeners();
    loading = false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class Actividad {
  final String nombre;
  final bool requiereHorometro;

  Actividad({required this.nombre, required this.requiereHorometro});
}
