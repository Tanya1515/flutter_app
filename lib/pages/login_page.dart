import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import '../components/auth_state.dart';
import '../utils/constants.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends AuthState<LoginPage> {
  bool _isLoading = false;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase.auth.signUp(
        _emailController.text,
        _passwordController.text);
    final error = response.error;
    //print error if smth went wrong while the email address was typed
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
          backgroundColor: Colors.red[200])
      );
    }
    //print success string, if everything is ok
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('You have been successfully signed up!'),
          backgroundColor: Colors.white54)
      );
      _emailController.clear();
      _passwordController.clear();
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushNamedAndRemoveUntil('/sign_up', (route) => false);
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase.auth.signIn(
        email: _emailController.text,
        password: _passwordController.text);
    final error = response.error;
    //print error if smth went wrong while the email address was typed
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
          backgroundColor: Colors.red[200])
      );
    }
    //print success string, if everything is ok
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('You have been successfully signed in!'),
          backgroundColor: Colors.white54)
      );
      _emailController.clear();
      _passwordController.clear();
    }
    Navigator.of(context).pushNamedAndRemoveUntil('/account', (route) => false);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ISP RAS')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Please enter your email and password for signing up'),
          //size of field for e-mail enter
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          //distance to button
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _signIn,
            child: Text(_isLoading ? 'Loading' : 'Sign In'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _signUp,
            child: Text(_isLoading ? 'Loading' : 'Sign Up'),
          ),
        ],
      ),
    );
  }
}