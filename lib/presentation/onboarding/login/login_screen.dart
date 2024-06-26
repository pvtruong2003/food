import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/routers.dart';
import '../../../core/resource/colors.dart';
import '../../../core/resource/language.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onPress;

  const LoginScreen({super.key, required this.onPress});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController ctrPhone = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    ctrPhone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (_, state) {
        Navigator.pop(context);
        widget.onPress.call();
      },
      builder: (_, state) {
        return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                              child: Container(
                            width: 48,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: const Color(0xFFCDD4DB)),
                          )),
                          const Text(
                            kTitleInputPhone,
                            style: TextStyle(
                                color: kBlackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                              'You will receive a 6 digit for phone verification number',
                              style: TextStyle(
                                color: kBlackColor,
                                fontWeight: FontWeight.normal,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            onSaved: (value) {
                              ctrPhone.text = value!;
                            },
                            validator: (String? value) {
                              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                              RegExp regExp = RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (!regExp.hasMatch(value)) {
                                return 'Please enter valid mobile number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                counter: const SizedBox.shrink(),
                                filled: true,
                                isDense: true,
                                fillColor: const Color(0xFFF6F7F8),
                                border: outlineInputBorder(),
                                enabledBorder: outlineInputBorder(),
                                focusedBorder: outlineInputBorder(),
                                errorBorder: outlineInputBorder(),
                                hintText: "Enter phone number",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: kGrayEnterFieldColor),
                                prefixIcon: InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, searchCountryRoute),
                                  child: Container(
                                    width: 79,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        left: 4, right: 12, top: 4, bottom: 4),
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFDEE3E7),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/flag_vn.png',
                                          height: 24,
                                          width: 24,
                                        ),
                                        const SizedBox(width: 4),
                                        const Text(
                                          '+84',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: kBlackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                    minHeight: 56, minWidth: 83)),
                          ),
                          const SizedBox(height: 48),
                          MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                context.read<LoginBloc>().add(
                                    SendOtpPhoneNumberEvent(
                                        phoneNumber: ctrPhone.text));
                              }
                            },
                            color: kPrimaryColor,
                            minWidth: double.infinity,
                            height: 52,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text(
                              'Continue',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ))));
      },
    );
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: kGrayOutlineColor, width: 1));
  }
}
