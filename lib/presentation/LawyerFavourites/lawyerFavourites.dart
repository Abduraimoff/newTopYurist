import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/utils/colors.dart';

class LawyerFavourites extends StatelessWidget {
  const LawyerFavourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text('Избраное', style: Theme.of(context).textTheme.headline2,),
        ),
        SizedBox(height: 15,),
        Expanded(
          child: ListView.builder(itemBuilder: (context, i){
            return  Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Column(children: [
                ListTile(leading: CircleAvatar(child: Image.asset('assets/images/userError.png'),
                backgroundColor: Color.fromRGBO(28, 79, 209, 0.1),
                ),
                title: Text("Альбина Юлдашева", style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black),),
                  trailing: SvgPicture.asset("assets/svg/heart.svg"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Нужна консультация юриста по уголовному праву. Цену можем обговорить лично приме...", style: Theme.of(context).textTheme.headline5,),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/location.svg"),
                          SizedBox(width: 10,),
                          Text("Toshkent", style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black), )
                        ],
                      ),
                    Text("15.07.2022", style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black),)
                  ],),
                )
              ],),
            );
          },
          itemCount: 5,
          ),
        ),
      ],
    ));
  }
}
