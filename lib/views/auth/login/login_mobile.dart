part of 'login_view.dart';

class _LoginMobile extends StatelessWidget {
  final LoginViewModel vm;

  _LoginMobile(this.vm);
  final _navigationService = locator<NavigatorService>();

  @override
  Widget build(BuildContext context) {
    return MyTapToHideKeyboard(
      child: Scaffold(
        appBar: AppBar(),
        body: ProgressWidget(
          inAsyncCall: vm.loading,
          child: AuthPageWidget(
            child: Form(
              key: vm.formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextField(
                    text: 'Usuario',
                    controller: vm.tcEmail,
                    validator: (pass) {
                      if (pass!.trim().length < 3) {
                        return 'Usuario inválido';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  AppTextField(
                    text: 'Contraseña',
                    validator: (pass) {
                      if (pass!.trim().length < 3) {
                        return 'Contraseña inválida';
                      } else {
                        return null;
                      }
                    },
                    controller: vm.tcPassword,
                    obscureText: vm.obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    iconButton: AppObscureTextIcon(
                      icon: vm.obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onPressed: vm.changeObscure,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AppButtonLogin(
                    text: 'Ingresar',
                    textColor: AppColors.blue,
                    onPressed: () => vm.signIn(context),
                    color: AppColors.white,
                  ),

                  // InkWell(
                  // onTap: () => vm.goToConfigPassword(),
                  // child:

                  // color: AppColors.orange,

                  /* AppButtonLogin(
                    text: 'Recuperar contraseña',
                    onPressed: () => vm.goToRecoveryPassword(),
                    color: AppColors.white,
                    textColor: Colors.black,
                    borderColor: AppColors.black,
                  ) */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
