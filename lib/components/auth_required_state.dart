import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//handy created class, that was inherited from SupabaseAuthRequiredState,
// which is provided by by supabase_flutter package
class AuthRequiredState<T extends StatefulWidget>
    extends SupabaseAuthRequiredState<T> {
  //feature that enables a child class to provide different implementation for a method
  //that is already defined and/or implemented in its parent class
  @override
  void onUnauthenticated() {
    // Users will be sent back to the LoginPage if they sign out.
    if (mounted) {
      // Users will be sent back to the LoginPage if they sign out.
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }
}