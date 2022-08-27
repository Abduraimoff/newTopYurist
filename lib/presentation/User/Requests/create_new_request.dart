import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_yurist/bloc/Bloc/Application/application_bloc.dart';
import 'package:top_yurist/bloc/Bloc/ProblemType/problem_type_bloc.dart';
import 'package:top_yurist/utils/colors.dart';
import '../../../bloc/Bloc/Auth/auth_bloc.dart';
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
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? image;
  bool _isPhotoUploading = false;
  final AuthBloc _bloc = AuthBloc();
   List<String> _imageList = [];
  bool isHideMyNumber = false;
  bool? _publishAll = false;
  bool _isLoading = false;
  String? categoryError;
  String? descriptionError;
  String? imageError;

  Future pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 30);
      if (image == null) return;
      final temporaryImage = File(image.path);
      setState(() {
        this.image = temporaryImage;
        _isPhotoUploading = true;
      });
      _bloc.add(UploadImageEvent(temporaryImage, "application"));
    } on PlatformException catch (e) {
      print("filed to pick image: $e");
    }
  }

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
        title: LocaleText(
          'create_request',
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _bloc,
  listener: (context, state) {
    if (state is UploadImageSuccessState) {
      _imageList.add(state.response?.fullPath ?? "");
      setState(() {
        _isPhotoUploading = false;
        imageError = null;
      });
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text("`Your image successfully uploaded")));
    }
  },
  child: BlocListener<ApplicationBloc, ApplicationState>(
    bloc: _applicationBloc,
  listener: (context, state) {
    if(state is ApplicationCreatedSuccessfullyState){
      setState(() {
        _imageList = [];
        selectedCategory = '';
        isHideMyNumber = false;
        _publishAll = false;
        _controller.text = '';
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Your application successfully created")));
    }
  },
  child: Padding(
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
                  if (state is ProblemLoadedSuccess) {
                    _categories = state.response;
                  }
                  return DropdownButtonFormField<RegionsResponse>(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      hintText: context.localeString('select_category_request'),
                      hintStyle: Theme.of(context).textTheme.headline5,
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: AppColors.black),
                    items: _categories.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city.title?.ruRu ?? ""),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCategory = val?.id;
                        categoryError = null;
                      });
                    },
                  );

                },
              ),
            ),
            Visibility(
                visible: categoryError != null ,
                child: LocaleText(categoryError?? "", style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.red),)),
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
              child: TextField(
                controller: _controller,
                onChanged: (value){
                  if(value.length > 15){
                    setState(() {
                      descriptionError = null;
                    });
                  }
                },
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF18181C)),
                maxLines: 100,
                decoration: InputDecoration(
                  hintText: 'Введите описание',
                  hintStyle: Theme.of(context).textTheme.headline5,
                  border: InputBorder.none,
                ),
              ),
            ),
            Visibility(
                visible: descriptionError != null,
                child: LocaleText(descriptionError ?? "", style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.red),)),
            SizedBox(height: 20.h),
             LocaleText(
              'photo',
              style: Theme.of(context).textTheme.headline3,
            ),
             SizedBox(height: 4.h),
             LocaleText(
              'add_file_pdf_jpg',
              style: Theme.of(context).textTheme.headline6,
            ),
             SizedBox(height: 16.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Row(children: _imageList.map((e) {
                    return Container(
                      margin: EdgeInsets.only(left: 5.w),
                      width: 94,
                      height: 94,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: const Color(0xFF858DA3),
                          width: 1.w,
                        ),

                      ),
                      child: Image.network(e, height: 94.h, width: 94.w, fit: BoxFit.fill,),
                    );
                  }).toList(),),
                  SizedBox(width: 6.w),
                  DottedBorder(
                    color: const Color(0xFF858DA3),
                    radius: const Radius.circular(5),
                    child: InkWell(
                      onTap: pickImage,
                      child: Container(
                        width: 94.w,
                        height: 90.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: _isPhotoUploading ? const Center(child: CupertinoActivityIndicator()) : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/gallery-import.svg",
                              color: AppColors.grey,
                            ),
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
                  ),
                ],
              ),
            ),
            Visibility(
                visible: imageError != null,
                child: LocaleText(imageError ?? "", style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.red),)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 LocaleText(
                  'hide_my_number',
                  style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black),
                ),
                CupertinoSwitch(
                  value: isHideMyNumber,
                  onChanged: (value) {

                    setState(() {
                      isHideMyNumber = value;
                    });
                  },
                ),

              ],
            ),
            const Divider(color: AppColors.dividerColor,),

            SizedBox(

              height: 25.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [LocaleText('publish_all', style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black),),
                  Checkbox(value: _publishAll, onChanged: ( value){
                    setState(() {
                      _publishAll = value;
                      imageError = null;
                    });
                  }, activeColor: AppColors.primary,)
              ],),
            ),
            LocaleText("publish_all_not", style: Theme.of(context).textTheme.headline6?.copyWith(color: AppColors.black.withOpacity(0.5)),),
             SizedBox(height: 33.h),
            Container(
              width: double.infinity,
              height: 46.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1C4FD1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {

                    if(selectedCategory == null || _controller.text.length < 15 || _imageList.isEmpty){
                      if(selectedCategory == null){
                       setState(() {
                         categoryError = "category_error";
                       });
                      }
                        if(_controller.text.length < 15){
                        setState(() {
                          descriptionError = "problem_description_error";
                        });
                      }
                        if(imageError == null){
                          setState(() {
                            imageError = "must_add_image_error";
                          });
                        }
                    } else{
                      _applicationBloc.add(CreateApplicationEvent(
                          {
                            "problem_type_id": selectedCategory,
                            "description": _controller.text,
                            "photos": _imageList,
                            "private_phone": isHideMyNumber,
                            "publish": _publishAll
                          }
                      ));
                    }


                },
                child: _isLoading ? const Center(child: CupertinoActivityIndicator()) : const LocaleText(
                  'publish',
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
),
),
    );
  }
}
