import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_3/controller/profile_controller.dart';
import 'package:flutter_3/ui/gradient_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final Map<String, dynamic> map;

  @override
  void initState() {
    super.initState();
    final profile = context.read<UserProfileNotifier>().profile;
    map = {
      'name': profile.name,
      'birthday': profile.birthday,
      'phone': profile.phone?.toString(),
      'email': profile.email,
      'instagram': profile.instagram,
      'password': profile.password,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: map,
            skipDisabled: true,
            child: ListView(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                FormBuilderDateTimePicker(
                  name: 'birthday',
                  initialDatePickerMode: DatePickerMode.day,
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  inputType: InputType.date,
                  format: DateFormat.yMMMMd(),
                  currentDate: DateTime.now(),
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now(),
                  decoration: const InputDecoration(
                    hintText: 'Birthday',
                    prefixIcon: Icon(Icons.calendar_month),
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24),
                  ),
                ),
                FormBuilderTextField(
                  name: 'phone',
                  decoration: const InputDecoration(
                    hintText: 'phone',
                    prefixIcon: Icon(Icons.phone_android),
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  valueTransformer: (value) =>
                      value == null ? null : int.tryParse(value),
                  buildCounter: (
                    _, {
                    required currentLength,
                    required isFocused,
                    required maxLength,
                  }) =>
                      null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                FormBuilderTextField(
                  name: 'instagram',
                  decoration: const InputDecoration(
                    hintText: 'Instagram account',
                    prefixIcon: Icon(Icons.face),
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24),
                  ),
                ),
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.remove_red_eye_outlined),
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24),
                    suffixIcon: Icon(Icons.sync),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ReactiveGradientButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
              ),
            ),
            onTap: () {
              /// TODO: save result
            },
            child: const Text('Edit profile'),
          ),
        ),
      ],
    );
  }
}
