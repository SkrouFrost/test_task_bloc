import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_bloc/features/contacts/data/models/contact_model.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/add_bloc/add_bloc.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/add_bloc/add_state.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/home_bloc/home_event.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/home_bloc/home_state.dart';
import 'package:test_task_bloc/features/contacts/presentation/widgets/circle_widget.dart';
import 'package:test_task_bloc/features/contacts/presentation/widgets/text_widget.dart';
import 'package:test_task_bloc/core/styles/color_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddContactBloc, AddContactState>(
        listener: (context, state) {
      if (state is AddContactSuccessState) {
        context.read<HomeBloc>().add(InitializeContactsEvent());
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text('Your contacts'),
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              height: 4,
              color: backgroundColor,
            ),
          ),
          actions: [
            IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              icon: const Icon(Icons.add),
              onPressed: () {
                context.go('/add');
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is ContactsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ContactsLoadedState) {
              List<Contact> contacts = state.contacts;
              return HomeBody(
                contacts: contacts,
                onContactTap: (String contactID) {
                  context.go('/details/$contactID');
                },
              );
            } else if (state is ContactsErrorState) {
              return Text('Error database connections: ${state.errorMessage}');
            } else {
              return const Text('Unknown state');
            }
          },
        ),
        // ),
      );
    });
  }
}

class HomeBody extends StatelessWidget {
  final List<Contact> contacts;
  final ValueChanged<String> onContactTap;

  const HomeBody({
    super.key,
    required this.contacts,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        const containerHeight = 60.0;
        const circleRadius = containerHeight * 0.5;
        Contact contact = contacts[index];
        return InkWell(
          onTap: () => onContactTap(contact.contactID),
          child: Container(
            height: containerHeight,
            color: lightbackgroundColor,
            margin: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 10),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const CircleWidget(radius: circleRadius),
                const SizedBox(width: 10),
                Expanded(
                  child: TextWidget(
                    text: '${contact.firstName} ${contact.lastName}',
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
