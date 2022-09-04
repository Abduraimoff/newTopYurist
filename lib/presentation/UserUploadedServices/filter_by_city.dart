import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/Bloc/Regions/regions_bloc.dart';
import 'package:top_yurist/utils/colors.dart';

class FilterByCity extends StatefulWidget {
  static const routeName = "filter/by/city";
final   ValueChanged<int>? onChanged;

  const FilterByCity({Key? key, this.onChanged}) : super(key: key);

  @override
  State<FilterByCity> createState() => _FilterByCityState();
}

class _FilterByCityState extends State<FilterByCity> {
  final RegionsBloc _bloc = RegionsBloc();

  @override
  void initState() {
    _bloc.add(GetRegions());
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
        title:  LocaleText(
          'filter_by_regions',
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<RegionsBloc, RegionsState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is RegionsInitial){
            return const Center(child: CupertinoActivityIndicator(),);
          }
          if(state is RegionsLoadedSuccessState){
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(itemBuilder: (context, i) {
                  return InkWell(
                    onTap: (){
                      widget.onChanged!(state.response[i].id );
                      Navigator.of(context).maybePop();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h,),
                        Text(state.response[i].title?.ruRu ?? ""),
                        SizedBox(height: 16.h),
                        Divider(color: AppColors.grey, height: 1.h,),
                      ],
                    ),
                  );
                }, itemCount: state.response.length,)
            );
          } else{
            return Center(child: Text("Something went wrong"),);
          }

        },
      ),
    );
  }
}
