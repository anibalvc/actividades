part of 'formulario_view.dart';

class _FormularioMobile extends StatelessWidget {
  final FormularioViewModel vm;

  const _FormularioMobile(this.vm);

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
              "Formulario previo",
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
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre del Operador: ${vm.authenticationClient.loadUsuario.nombrePerfil}',
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Fecha Actual: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: vm.jefeDeMina,
                  items: vm.jefesDeMina.map((String jefe) {
                    return DropdownMenuItem<String>(
                      value: jefe,
                      child: Text(jefe),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    vm.setJefeDeMina(newValue, context);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Jefe de Mina',
                    labelStyle: TextStyle(color: AppColors.blue),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: vm.mina,
                  items: vm.minas.map((String mina) {
                    return DropdownMenuItem<String>(
                      value: mina,
                      child: Text(mina),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    vm.setMina(newValue, context);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Mina',
                    labelStyle: TextStyle(color: AppColors.blue),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: vm.labor,
                  items: vm.labores.map((String labor) {
                    return DropdownMenuItem<String>(
                      value: labor,
                      child: Text(labor),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    vm.setLabor(newValue, context);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Labor',
                    labelStyle: TextStyle(color: AppColors.blue),
                    border: OutlineInputBorder(),
                  ),
                ),
                const Spacer(),
                if (vm.mina != null &&
                    vm.labor != null &&
                    vm.jefeDeMina != null &&
                    vm.mina!.isNotEmpty &&
                    vm.jefeDeMina!.isNotEmpty &&
                    vm.labor!.isNotEmpty)
                  ElevatedButton(
                    onPressed: () => vm.goToActividades(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Completar formulario',
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
