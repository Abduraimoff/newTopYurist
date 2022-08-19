import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/bloc/Bloc/Application/application_bloc.dart';
import 'package:top_yurist/bloc/Bloc/ProblemType/problem_type_bloc.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../../data/Models/regions/regions.dart';

class CreateNewRequest extends StatefulWidget {
  static const String routeName = "create_request";
  const CreateNewRequest({Key? key}) : super(key: key);

  @override
  State<CreateNewRequest> createState() => _CreateNewRequestState();
}

class _CreateNewRequestState extends State<CreateNewRequest> {
  final ApplicationBloc _applicationBloc = ApplicationBloc();
  final ProblemTypeBloc _problemTypeBloc = ProblemTypeBloc();
     List<RegionsResponse> _categories = [];
  String? selectedCategory;

@override
  void initState() {
    _problemTypeBloc.add(GetProblemsEvent());
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
        title:   LocaleText(
          'create_request',
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              height: 48.h,
              // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF858DA3),
                  width: 1.w,
                ),
              ),
              child: BlocBuilder<ProblemTypeBloc, ProblemTypeState>(
                bloc: _problemTypeBloc,
  builder: (context, state) {
                  if(state is ProblemLoadedSuccess){
                    _categories = state.response;
                  }
    return DropdownButtonFormField<RegionsResponse>(
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  hintText: context.localeString('select_category_request'),
                  hintStyle: Theme.of(context).textTheme.headline5,
                ),
                style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black),
                items: _categories.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city.title?.ruRu?? ""),
                  );
                }).toList(),
                onChanged: (val) {
                  selectedCategory = val?.id;
                },
              );
  },
),
            ),
             SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              height: 180.h,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF858DA3),
                  width: 1,
                ),
              ),
              child: const TextField(
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF18181C)),
                maxLines: 100,
                decoration: InputDecoration(
                  hintText: 'Введите описание',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF18181C)),
                  border: InputBorder.none,
                ),
              ),
            ),
             SizedBox(height: 20.h),
            const Text(
              'Фото',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Добавьте документы в формате jpeg. pdf.',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFF18181C),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 94,
                  height: 94,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(0xFF858DA3),
                      width: 1,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/Rectangle106.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                 SizedBox(width: 6.w),
                DottedBorder(
                  color: const Color(0xFF858DA3),
                  radius: const Radius.circular(5),
                  child: Container(
                    width: 94,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svg/gallery-import.svg", color: AppColors.grey,),
                        const SizedBox(width: 7),
                        const Text(
                          'Добавить фото',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 9,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Скрыть мой номер от юристов',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                CupertinoSwitch(
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 33),
            Container(
              width: double.infinity,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF1C4FD1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Опубликовать',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 27),
          ],
        ),
      ),
    );
  }

}
