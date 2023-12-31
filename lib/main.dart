import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_bloc/features/contacts/data/repositories/contact_dao.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/add_bloc/add_bloc.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/contact_bloc/contact_bloc.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/edit_bloc/edit_bloc.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/home_bloc/home_event.dart';
import 'package:test_task_bloc/features/contacts/presentation/screens/add_contact_screen.dart';
import 'package:test_task_bloc/features/contacts/presentation/screens/contact_detail_screen.dart';
import 'package:test_task_bloc/features/contacts/presentation/screens/edit_contact_screen.dart';
import 'package:test_task_bloc/features/contacts/presentation/screens/home_screen.dart';
import 'package:test_task_bloc/core/styles/color_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ContactDao.instance.openBox();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) =>
              HomeBloc(ContactDao.instance.box)..add(InitializeContactsEvent()),
        ),
        BlocProvider<AddContactBloc>(
          create: (context) => AddContactBloc(),
        ),
        BlocProvider<ContactBloc>(
          create: (context) => ContactBloc(),
        ),
        BlocProvider<EditContactBloc>(
          create: (context) => EditContactBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
            path: 'details/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ContactScreen(id: id);
            },
            routes: [
              GoRoute(
                path: 'edit',
                builder: (context, state) {
                  final ide = state.pathParameters['id']!;
                  return ContactEditScreen(id: ide);
                },
              ),
            ]),
        GoRoute(path: 'add', builder: (context, state) => AddContactScreen()),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Test task BLoC',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: lightbackgroundColor,
        ),
      ),
      routerConfig: _router,
    );
  }
}
