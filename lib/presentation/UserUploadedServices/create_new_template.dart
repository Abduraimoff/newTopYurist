import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/Bloc/MessageTemplate/message_template_bloc.dart';
import 'package:top_yurist/utils/colors.dart';

class CreateNewTemplate extends StatefulWidget {
  static const String routeName = "create/new/template";

  const CreateNewTemplate({Key? key}) : super(key: key);

  @override
  State<CreateNewTemplate> createState() => _CreateNewTemplateState();
}

class _CreateNewTemplateState extends State<CreateNewTemplate> {
  final MessageTemplateBloc _bloc = MessageTemplateBloc();
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? data;

  @override
  void didChangeDependencies() {
    if(ModalRoute.of(context)?.settings.arguments != null){
      data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      _controller.text = data?["description"];
    }


    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(
        title: LocaleText(
          "create_new_template",
          style: Theme.of(context).textTheme.headline3,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.grey),
      ),
      body: BlocListener<MessageTemplateBloc, MessageTemplateState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is MessageTemplateCreatedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("You successfully create a template")));
            Navigator.of(context).maybePop();
          }
          if (state is TemplateUpdatedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("You successfully updated the template")));
            Navigator.of(context).maybePop();
          }
        },
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16.sp),
              width: double.infinity,
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF858DA3),
                  width: 1,
                ),
              ),
              child: TextField(
                maxLines: 10,
                controller: _controller,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: Color(0xFF18181C)),
                decoration: InputDecoration(
                  hintText: 'Введите текст',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Color(0xFF18181C)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 48.h,
          width: double.infinity,
          child: FloatingActionButton(
            onPressed: () async {
              ModalRoute.of(context)?.settings.arguments == null
                  ? _bloc.add(CreateNewTemplateEvent(_controller.text))
                  : _bloc.add(UpdateTemplateEvent(
                      id: data?["id"], description: _controller.text));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.primary,
            child: LocaleText(
              "save",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
