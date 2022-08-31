import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/Bloc/MessageTemplate/message_template_bloc.dart';
import 'package:top_yurist/presentation/UserUploadedServices/create_new_template.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../data/Models/message_template/message_template.dart';

class CreateTemplateScreen extends StatefulWidget {
  static const String routeName = "create/template";

  const CreateTemplateScreen({Key? key}) : super(key: key);

  @override
  State<CreateTemplateScreen> createState() => _CreateTemplateScreenState();
}

class _CreateTemplateScreenState extends State<CreateTemplateScreen> {
  List<MessageTemplateResponse>? templates;
  final MessageTemplateBloc _bloc = MessageTemplateBloc();

  @override
  void initState() {
    _bloc.add(GetMessageTemplateEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.grey),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const LocaleText(
          'templates',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 2.4,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MessageTemplateBloc, MessageTemplateState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is MessageTemplateErrorState) {
            return Center(child: Text(state.error),);
    }
          if(state is MessageTemplateInitial){
            return const Center(child: CupertinoActivityIndicator());
    }
          if(state is MessageTemplateListLoadedState){
            templates = state.response;
    }
            return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF1C4FD1).withOpacity(0.10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(CreateNewTemplate.routeName).then((value) => _bloc.add(GetMessageTemplateEvent()));
                    },
                    child: const LocaleText(
                      'create_template',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFF1C4FD1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(child: ListView.builder(itemBuilder: (context, i){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          SizedBox(

                            child: Expanded(
                              child: Text(
                                templates?[i].description ?? "",
                              ),
                            ),
                          ),
                          Container(
                            color: AppColors.white,
                            child: DropdownButton<String>(

                              icon: const Icon(Icons.more_horiz,
                                  color: Colors.grey),
                              elevation: 0,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: const SizedBox(),
                              onChanged: (String? newValue) {
                               if(newValue == "edit"){
                                 Navigator.of(context).pushNamed(CreateNewTemplate.routeName, arguments: {
                                   "description": templates?[i].description,
                                   "id": templates?[i].id
                                 });
                               } else if(newValue == "del"){
                                 _bloc.add(DeleteTemplateEvent(id: templates?[i].id));
                               }
                              },
                              items:  <String>["edit", "del"].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: LocaleText(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: templates?.length,
                ))
              ],
            ),
          );

        },

      ),


    );
  }
}
