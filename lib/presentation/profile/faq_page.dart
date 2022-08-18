import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_yurist/bloc/faq_cubit/faq_cubit.dart';

class PAQPage extends StatefulWidget {
  const PAQPage({Key? key}) : super(key: key);

  @override
  State<PAQPage> createState() => _PAQPageState();
}

class _PAQPageState extends State<PAQPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FAQCubit(),
      child: const _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FAQCubit, FaqState>(
      builder: (context, state) {
        return Scaffold();
      },
    );
  }
}
