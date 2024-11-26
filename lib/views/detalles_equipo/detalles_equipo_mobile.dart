part of 'detalles_equipo_view.dart';

class _DetallesEquipoMobile extends StatelessWidget {
  final DetallesEquipoViewModel vm;

  const _DetallesEquipoMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return MyTapToHideKeyboard(
      child: ProgressWidget(
        inAsyncCall: vm.loading,
        opacity: false,
        child: Scaffold(
          key: vm.drawerKey,
          drawer: GlobalDrawerDartDesktop(
            notify: () {
              vm.notifyListeners();
            },
          ),
          appBar: AppBar(
            title: const Text(
              "Detalles del Equipo",
              style: TextStyle(
                color: AppColors.blue,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(); // Volver atrás
              },
              icon: const Icon(Icons.arrow_back, color: AppColors.blue),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre del Equipo: ${vm.equipoSeleccionado.nombre}',
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Código del Equipo: ${vm.equipoSeleccionado.codigo}',
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Valor del Horómetro: ${vm.equipoSeleccionado.valorHorometro}',
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Subequipos: ${vm.equipoSeleccionado.subequipos.join(", ")}',
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Fecha de Actualización: ${DateFormat('dd/MM/yyyy').format(vm.equipoSeleccionado.fechaActualizacion)}',
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => vm.goToSelector(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Volver al Selector de Equipos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
