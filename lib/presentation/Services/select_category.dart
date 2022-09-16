import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/Bloc/Lawyer/HomeList/selected_services_list_bloc.dart';
import 'package:top_yurist/presentation/widgets/base_appbar.dart';

import '../../bloc/Bloc/ProblemType/problem_type_bloc.dart';
import '../../utils/colors.dart';

class SelectCategory extends StatefulWidget {
  static const String routeName = "select_category";
  const SelectCategory({Key? key}) : super(key: key);

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  final ProblemTypeBloc _typeBloc = ProblemTypeBloc();
  final List<String> serviceList = [];
  
  @override
  void initState() {
   _typeBloc.add(GetProblemsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final SelectedServicesListBloc servicesListBloc = ModalRoute.of(context)?.settings.arguments as SelectedServicesListBloc;
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return BlocProvider<SelectedServicesListBloc>(
  create: (context) => SelectedServicesListBloc(),
  child: Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), title: Text('Выберите свою категорию',
          style: Theme.of(context).textTheme.headline3,),),

      body: BlocBuilder<ProblemTypeBloc, ProblemTypeState>(
        bloc: _typeBloc,
  builder: (context, state) {
          if(state is ProblemLoadedSuccess){
            return Padding(
              padding:  EdgeInsets.only(left: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: ListView.builder(
                      itemCount: state.response.length,
                      itemBuilder: (context, i){
                        return Column(children: [
                          SizedBox(height: 16.h,),
                          InkWell(
                            onTap: (){
                              setState(() {
                                serviceList.add(state.response[i].id);
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 19.h,
                                  width: 19.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                  child:  Center(
                                    child: serviceList.contains(state.response[i].id) ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12.sp,
                                    ) : null,
                                  ),
                                ),
                                SizedBox(width: 9.w),
                                Text(state.response[i].title?.ruRu ?? "", style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.darkBlack, fontWeight: FontWeight.w400),)
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Divider(color: Colors.grey),
                          ),
                        ],);
                      })),
                  Container(
                    width: double.infinity,
                    height: 46,
                    margin: EdgeInsets.only(right: 16.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF1C4FD1)),
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<SelectedServicesListBloc>(context).add(AddServiceEvent(serviceList));
                        servicesListBloc.add(GetSelectedServicesEvent(context));
                        Navigator.of(context).maybePop();
                      },
                      child: const Text(
                        'Сохранить',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h,),
                ],
              ),
            );
          }
    return const Center(child: CupertinoActivityIndicator());
  },
),
    ),
);
  }
}
