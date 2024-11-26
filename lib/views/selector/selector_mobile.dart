part of 'selector_view.dart';

class _SelectorMobile extends StatelessWidget {
  final SelectorViewModel vm;

  const _SelectorMobile(this.vm);

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
              "Selector de equipos",
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
                icon: const Icon(Icons.qr_code_scanner, color: AppColors.blue),
                onPressed: () {
                  vm.scanQrCode(context);
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.equiposList.length,
                    itemBuilder: (context, index) {
                      final equipo = vm.equiposList[index];
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              equipo.nombre,
                              style: const TextStyle(
                                color: AppColors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios,
                                  color: AppColors.blue),
                              onPressed: () {
                                vm.goToFormulario(equipo, null, context);
                              },
                            ),
                          ],
                        ),
                        subtitle: Text(
                          equipo.subequipos.isEmpty
                              ? "Sin subequipos"
                              : "Subequipos: ${equipo.subequipos.join(", ")}",
                          style: const TextStyle(
                            color: AppColors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        iconColor: AppColors.blue,
                      );
                    },
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
