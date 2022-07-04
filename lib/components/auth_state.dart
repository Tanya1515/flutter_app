import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//Push the route with the given name onto the navigator that most tightly encloses the given context,
// and then remove all the previous routes until the predicate returns true.

//To remove all the routes below the pushed route, use a RoutePredicate
// that always returns false (e.g. (Route<dynamic> route) => false).
class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
   if (mounted) {
      Navigator.of(context).pushNamed('/login');
    }
  }

  @override
  void onAuthenticated(Session session) {
    //Navigator.of(context).pushNamedAndRemoveUntil('/sign_up', (route) => false);
    //Navigator.of(context).pushNamedAndRemoveUntil('/account', (route) => false);
  }

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[200])
    );
  }
}
