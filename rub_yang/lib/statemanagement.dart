import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final userLogged = StateProvider((ref) => FirebaseAuth.instance.currentUser);