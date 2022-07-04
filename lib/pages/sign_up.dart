import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import '../components/auth_required_state.dart';
import '../components/auth_state.dart';
import '../utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}



class _SignUpPageState extends AuthRequiredState<SignUpPage> {
  final _usernameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  var _loading = false;

  Future<void> _saveProfile() async {
    setState(() {
      _loading = true;
    });
    //variable meaning is defined in program runtime
    //set info from request to variables
    final name = _usernameController.text;
    final surname = _surnameController.text;
    final phone = _phoneController.text;
    final city = _cityController.text;
    final country = _countryController.text;
    final user = supabase.auth.currentUser;
    //fulfill structure os data to update the info
    final save = {
      'id_user': user!.id,
      'name': name,
      'surname': surname,
      'phone': phone,
      'city': city,
      'country': country,
    };
    //send request to database in order to update the information
    final response = await supabase.from('clients').insert(save).execute();
    final error = response.error;
    //if smth went wrong, while the info was updating, print the error
    if (error != null) {
      ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
          content: Text(error.message),
          backgroundColor: Colors.red[200])
      );
    } else {
      ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(
          content: Text('Successfully saved profile!'),
          backgroundColor: Colors.white54)
      );
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _signOut() async {
    final response = await supabase.auth.signOut();
    final error = response.error;
    if (error != null) {
      ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
          content: Text(error.message),
          backgroundColor: Colors.red[200])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'User Name'),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _surnameController,
            decoration: const InputDecoration(labelText: 'User Surname'),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _cityController,
            decoration: const InputDecoration(labelText: 'City'),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _countryController,
            decoration: const InputDecoration(labelText: 'Country'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
              onPressed: _saveProfile,
              child: Text(_loading ? 'Saving...' : 'Save')),
          const SizedBox(height: 18),
          ElevatedButton(onPressed: _signOut, child: const Text('Sign Out')),
        ],
      ),
    );
  }

}