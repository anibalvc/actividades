part of 'actividades_view.dart';

class _ActividadesMobile extends StatelessWidget {
  final ActividadesViewModel vm;

  const _ActividadesMobile(this.vm);

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
              "Actividades del día",
              style: TextStyle(
                color: AppColors.blue,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                vm.drawerKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu, color: AppColors.blue),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => vm.goToDetallesEquipo(),
                icon: const Icon(Icons.info_outlined, color: AppColors.blue),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Selector de actividades",
                    style: TextStyle(
                        color: AppColors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                const Divider(
                  color: AppColors.blue,
                  thickness: .5,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.actividadesPorCategoria.length,
                    itemBuilder: (context, index) {
                      final categoria =
                          vm.actividadesPorCategoria.keys.elementAt(index);
                      final actividades =
                          vm.actividadesPorCategoria[categoria]!;
                      return Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          collapsedIconColor: AppColors.blue,
                          iconColor: AppColors.blue,
                          title: Text(
                            categoria,
                            style: const TextStyle(
                              color: AppColors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: actividades.map((actividad) {
                            return ListTile(
                              title: Text(
                                actividad.nombre,
                                style: const TextStyle(
                                  color: AppColors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () {
                                vm.seleccionarActividad(actividad, context);
                              },
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                if (vm.actividadesData.isEmpty)
                  const Center(
                    child: Text(
                      "No tiene actividades asignadas para el día de hoy",
                      style: TextStyle(
                        color: AppColors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                if (vm.actividadesData.isNotEmpty) ...[
                  const Text("Actividades realizadas",
                      style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  Divider(
                    color: AppColors.blue,
                    thickness: .5,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: vm.actividadesData.length,
                      itemBuilder: (context, index) {
                        final actividad = vm.actividadesData[index];
                        return ListTile(
                          title: Text(
                            actividad.nombre,
                            style: const TextStyle(
                              color: AppColors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Inicio: ${actividad.horaInicio} - Fin: ${actividad.horaFin}',
                                style: const TextStyle(
                                  color: AppColors.blue,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                actividad.jefeMina,
                                style: const TextStyle(
                                  color: AppColors.blue,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                actividad.nombreMina,
                                style: const TextStyle(
                                  color: AppColors.blue,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          onTap: null,
                        );
                      },
                    ),
                  ),
                ],
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
