import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_bloc/data/models/contact_model.dart';
import 'package:test_task_bloc/presentations/bloc/contact_bloc/contact_bloc.dart';
import 'package:test_task_bloc/presentations/bloc/contact_bloc/contact_event.dart';
import 'package:test_task_bloc/presentations/bloc/contact_bloc/contact_state.dart';
import 'package:test_task_bloc/presentations/bloc/edit_bloc/edit_bloc.dart';
import 'package:test_task_bloc/presentations/bloc/edit_bloc/edit_state.dart';
import 'package:test_task_bloc/presentations/bloc/home_bloc/home_bloc.dart';
import 'package:test_task_bloc/presentations/bloc/home_bloc/home_event.dart';
import 'package:test_task_bloc/styles/color_constants.dart';
import 'package:test_task_bloc/styles/fonts.dart';

class ContactScreen extends StatefulWidget {
  final String id;

  const ContactScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    context.read<ContactBloc>().add(LoadContactEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text('Contact'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                context.go('/details/${widget.id}/edit');
              },
            ),
          ],
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              height: 4,
              color: backgroundColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ContactBody(id: widget.id),
        ),
      );
    });
  }
}

class ContactBody extends StatelessWidget {
  final String id;

  const ContactBody({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditContactBloc, EditContactState>(
        listener: (context, state) {
      if (state is ContactSavedState) {
        context.read<ContactBloc>().add(LoadContactEvent(id));
        context.read<HomeBloc>().add(InitializeContactsEvent());
      }
      if (state is ContactDeletedState) {
        context.read<HomeBloc>().add(InitializeContactsEvent());
      }
    }, builder: (context, state) {
      return BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is ContactErrorState) {
            return Text('Error Data Base access: ${state.errorMessage}');
          } else if (state is ContactLoadedState) {
            Contact? contact =
                state.contact; // Use Contact? to handle nullable response
            // String contactValue = contact != null ? contact.firstName : 'Oh, no'; // Default empty value if contact is null
            return Column(
              children: [
                ContactInfoRow(
                    label: 'First name', value: contact?.firstName ?? ''),
                ContactInfoRow(
                    label: 'Last name', value: contact?.lastName ?? ''),
                ContactInfoRow(
                    label: 'Phone number', value: contact?.phoneNumber ?? ''),
                ContactInfoRow(
                    label: 'Street address 1',
                    value: contact?.streetAddress1 ?? ''),
                ContactInfoRow(
                    label: 'streetAddress2',
                    value: contact?.streetAddress2 ?? ''),
                ContactInfoRow(label: 'city', value: contact?.city ?? ''),
                ContactInfoRow(label: 'state', value: contact?.state ?? ''),
                ContactInfoRow(label: 'zipCode', value: contact?.zipCode ?? ''),
              ],
            );
          }
          return Container();
        },
      );
    });
  }
}

class ContactInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ContactInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: lightbackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: contactLabelStyle,
          ),
          Text(
            value,
            style: contactValueStyle,
          ),
        ],
      ),
    );
  }
}
