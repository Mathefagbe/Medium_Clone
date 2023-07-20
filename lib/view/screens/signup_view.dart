import 'package:dblog/view/widgets/logo.dart';
import 'package:dblog/viewmodel/providers/password_visibility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/enums/enums.dart';
import '../../viewmodel/providers/auth_viewmodel.dart';
import '../style/colors/colorstyle.dart';
import '../widgets/login_signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmpassword;
  late TextEditingController username;
  late TextEditingController fullname;

  final _formstate = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    confirmpassword = TextEditingController();
    fullname = TextEditingController();
    username = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmpassword.dispose();
    fullname.dispose();
    username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formstate,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Column(
          children: [
            const Logo(),
            const SizedBox(height: 40),
            Text('Join Medium.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 25)),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                style: Theme.of(context).textTheme.labelMedium,
                controller: username,
                validator: (val) => val!.isEmpty ? "Enter your username" : null,
                decoration: formDecoration.copyWith(
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    hintText: "Username",
                    labelText: "Username")),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
                style: Theme.of(context).textTheme.labelMedium,
                controller: email,
                validator: (val) => val!.isEmpty ? "Enter your email" : null,
                decoration: formDecoration.copyWith(
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    hintText: "Email",
                    labelText: "Email")),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
                style: Theme.of(context).textTheme.labelMedium,
                controller: fullname,
                validator: (val) =>
                    val!.isEmpty ? "Enter your full name" : null,
                decoration: formDecoration.copyWith(
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    hintText: "Full name",
                    labelText: "Full name")),
            const SizedBox(
              height: 10,
            ),
            _PasswordField(
              controller: password,
            ),
            const SizedBox(
              height: 10,
            ),
            _ConfirmPasswordField(
              controller: confirmpassword,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                if (_formstate.currentState!.validate() &&
                    password.text == confirmpassword.text) {
                  Map<String, String> formdata = {
                    'username': username.text.trim(),
                    'email': email.text.trim(),
                    'fullname': fullname.text.trim(),
                    'password': password.text,
                    'confirm_password': confirmpassword.text
                  };
                  Provider.of<AuthChangeNotifer>(context, listen: false)
                      .signUp(formdata);
                }
              },
              child: Consumer<AuthChangeNotifer>(
                builder: (context, value, child) => Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorStyle.lightgreen[400],
                  ),
                  child: value.fetchstate == PageState.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: ColorStyle.white),
                        )
                      : const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorStyle.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const ErrorMessage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Sign In",
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const _PasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<VisibilityNotifier>(
      builder: (context, value, child) => TextFormField(
          style: Theme.of(context).textTheme.labelMedium,
          controller: controller,
          obscureText: value.passwordtoggle ? true : false,
          validator: (val) => val!.isEmpty ? "Enter your Password" : null,
          decoration: formDecoration.copyWith(
              hintStyle: Theme.of(context).textTheme.labelMedium,
              labelStyle: Theme.of(context).textTheme.labelMedium,
              suffixIcon: IconButton(
                onPressed: () {
                  Provider.of<VisibilityNotifier>(context, listen: false)
                      .visibility('password');
                },
                icon: value.passwordtoggle
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
              hintText: "Password",
              labelText: "Password")),
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  const _ConfirmPasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<VisibilityNotifier>(
      builder: (context, value, child) => TextFormField(
          style: Theme.of(context).textTheme.labelMedium,
          obscureText: value.confirmtoggle ? true : false,
          controller: controller,
          validator: (val) =>
              val!.isEmpty ? "Enter your ComfirmPassword" : null,
          decoration: formDecoration.copyWith(
              hintStyle: Theme.of(context).textTheme.labelMedium,
              labelStyle: Theme.of(context).textTheme.labelMedium,
              suffixIcon: IconButton(
                onPressed: () {
                  Provider.of<VisibilityNotifier>(context, listen: false)
                      .visibility('confirmPassword');
                },
                icon: value.confirmtoggle
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
              hintText: "Comfirm Password",
              labelText: "Comfirm Password")),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    // var bud = Provider.of<AuthChangeNotifer>(context).
    // print(bud);
    print('build');
    return Consumer<AuthChangeNotifer>(
      builder: (context, value, child) => value.errormessage == ""
          ? const SizedBox()
          : Text(
              value.errormessage,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.red),
            ),
    );
  }
}
