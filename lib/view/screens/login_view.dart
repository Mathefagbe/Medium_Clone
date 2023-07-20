import 'package:dblog/view/screens/signup_view.dart';
import 'package:dblog/view/widgets/logo.dart';
import 'package:dblog/viewmodel/providers/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/enums/enums.dart';
import '../style/colors/colorstyle.dart';
import '../../viewmodel/providers/password_visibility.dart';
import '../widgets/login_signup_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController email;
  late TextEditingController password;

  final _formstate = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
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
            const SizedBox(height: 50),
            Text('Welcome Back.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 25)),
            const SizedBox(
              height: 30,
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
              height: 30,
            ),
            _PasswordTextForm(
              controller: password,
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                if (_formstate.currentState!.validate()) {
                  Map<String, String> formdata = {
                    'email': email.text,
                    'password': password.text,
                  };
                  Provider.of<AuthChangeNotifer>(context, listen: false)
                      .login(formdata);
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
                            color: ColorStyle.white,
                          ),
                        )
                      : const Text(
                          "Login",
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
            // ***************************
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: const Text(
                      "Sign Up.",
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class _PasswordTextForm extends StatelessWidget {
  final TextEditingController controller;
  const _PasswordTextForm({required this.controller});

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
