import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/bloc/Offer/offer_bloc.dart';
import 'package:top_yurist/presentation/messaging/messaging_page.dart';
import 'package:top_yurist/presentation/widgets/profileImage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/Models/offers/offer_list_response.dart';
import '../../../utils/colors.dart';

class UserProfileScreen extends StatefulWidget {
  static const String routeName = "user/profile";
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final OfferBloc _offerBloc = OfferBloc();
  Datum? data;
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  @override
  void didChangeDependencies() {
   data = ModalRoute.of(context)?.settings.arguments as Datum;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.grey),

        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(child: ProfileImage(imageUrl: data?.lawyerProfilePhoto)),
             SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  data?.lawyerFullName ?? "",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 3.h),
                LocaleText(
                  'verified',
                  style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.green),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        actions:  [
          (data?.isFavorite ?? false)
              ? IconButton(onPressed: (){
            BlocProvider.of<OfferBloc>(context).add(UnFavouriteEvent(data?.lawyerId));
          },icon: SvgPicture.asset("assets/svg/heart.svg"),)
              : IconButton(onPressed: (){

            BlocProvider.of<OfferBloc>(context).add(FavouriteEvent(data?.lawyerId));
          },icon: SvgPicture.asset("assets/svg/heart_empty.svg"),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
             Text(
              '${context.localeString("phone_number")}: ${data?.lawyerPhoneNumber ?? "Phone number is hidden"}',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
            const SizedBox(height: 8),


             Text(
              '${context.localeString("experience")}: ${data?.workExperience} лет',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
             Text(
              '${context.localeString("solved_request")}: ${data?.doneApplicationCount ?? 0}',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
             SizedBox(height: 8.h),
             Text(
              '${context.localeString("in_system")}: ${data?.inSystemYears ?? 0} года',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
             SizedBox(height: 20.h),
            Row(
              children: [
                BlocListener<OfferBloc, OfferState>(
                  bloc: _offerBloc,
  listener: (context, state) {
if(state is SelectLawyerState){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You successfully selected the lawyer")));
}
  },
  child: Container(
                  height: 44,
                  width: 233,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF1C4FD1),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _offerBloc.add(SelectLawyerEvent(data?.id));
                    },
                    child:  LocaleText(
                      'select_lawyer',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ),
),
                 SizedBox(width: 10.w),
                 SmallButton(icon: SvgPicture.asset("assets/svg/message.svg"), onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (_) => MessagingPage(chatId: data?.chatId, fullName: data?.lawyerFullName, imageUrl: data?.lawyerProfilePhoto,)));
                 },),
                 SizedBox(width: 10.w),
                 SmallButton(icon: SvgPicture.asset("assets/svg/call.svg"), onPressed:()async{
                   await _makePhoneCall(data?.lawyerPhoneNumber?? "+998901111111");
                 },),
              ],
            ),
            SizedBox(height: 20.h,),
             LocaleText("message", style: Theme.of(context).textTheme.headline3,),
             SizedBox(height: 8.h,),
             Text(data?.description ?? "",style: Theme.of(context).textTheme.headline5,),
             SizedBox(height: 20.h,),
             LocaleText("about_activity", style: Theme.of(context).textTheme.headline3,),
             SizedBox(height: 8.h,),
             Text(data?.lawyerDescription ?? ""),
             SizedBox(height: 40.h),
             Text(
              '${context.localeString("reviews")} (${data?.reviewCount ?? 0})',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
             SizedBox(height: 12.h),
            Card(
              child: Padding(
                padding:  EdgeInsets.all(16.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 32.h,
                              width: 32.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person_outline_outlined,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                             SizedBox(width: 8.w),
                            const Text(
                              'Альбина Юлдашева',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 23,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(52),
                            color: const Color(0xFF2CAD7F).withOpacity(0.1),
                          ),
                          child: const Center(
                            child: Text(
                              'Решено',
                              style: TextStyle(color: Color(0xFF2CAD7F)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    const Text(
                      'Очень приятно было работать с Ферузом Тахировичем грамотно проконсультировал подготовил документы. Запрос решен на 100%',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 11),
                    const Text(
                      '15.07.2022',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  const SmallButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(28, 79, 209, 0.1),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
