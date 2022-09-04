
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../bloc/Bloc/MessageTemplate/message_template_bloc.dart';
import '../../bloc/Offer/offer_bloc.dart';
import '../../utils/colors.dart';
import '../UserUploadedServices/create_template.dart';

class MessageModal extends StatefulWidget {

  final String? applicationId;

  const MessageModal({Key? key,  this.applicationId})
      : super(key: key);

  @override
  State<MessageModal> createState() => _MessageModalState();
}

class _MessageModalState extends State<MessageModal> {
  TextEditingController? controller ;

  TextEditingController? priceController;

   OfferBloc? _bloc;


  @override
  void initState() {
    controller = TextEditingController();
    priceController = TextEditingController();
    _bloc = OfferBloc();
    super.initState();
  }
  @override
  void dispose() {
    controller?.dispose();
    priceController?.dispose();


    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return BlocProvider<MessageTemplateBloc>(
      create: (context) =>
      MessageTemplateBloc()..add(GetMessageTemplateEvent()),
      child: DraggableScrollableSheet(
          initialChildSize: 0.8,
          maxChildSize: 0.8,
          minChildSize: 0,
          builder: (BuildContext context, ScrollController scrollController) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: BlocListener<OfferBloc, OfferState>(
                bloc: _bloc,
                listener: (context, state) {
                  if (state is OfferSuccessfullySend) {
                    print("hello");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            width: 50,
                            height: 3,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 28),
                        LocaleText(
                          'message',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          height: 180,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF858DA3),
                              width: 1,
                            ),
                          ),
                          child: TextField(

                            controller: controller,
                            onEditingComplete: () {
                              Navigator.of(context).pop();
                            },
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: const Color(0xFF18181C)),
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: context.localeString("type_text"),
                              contentPadding: EdgeInsets.only(bottom: 10),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: AppColors.black.withOpacity(0.5)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 28),
                        LocaleText('approximately_price',
                            style: Theme.of(context).textTheme.headline3),
                        Container(
                          width: double.infinity,
                          height: 48,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF858DA3),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: const Color(0xFF18181C)),
                            decoration: InputDecoration(
                              hintText: context.localeString("type_price_sum"),
                              contentPadding: EdgeInsets.only(bottom: 10),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: AppColors.black.withOpacity(0.5)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(CreateTemplateScreen.routeName);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LocaleText(
                                'templates',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              const Icon(Icons.keyboard_arrow_right_rounded,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        BlocBuilder<MessageTemplateBloc, MessageTemplateState>(
                          builder: (context, state) {
                            if (state is MessageTemplateListLoadedState) {
                              return Row(
                                children: state.response.map((e) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: InkWell(
                                      onTap: () {
                                        controller?.text = e.description ?? "";
                                      },
                                      child: SizedBox(
                                        width: 102,
                                        height: 98,
                                        child: DottedBorder(
                                          color: const Color(0xFF858DA3),
                                          radius: Radius.circular(5),
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              e.description ?? "",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }
                            return const CupertinoActivityIndicator();
                          },
                        ),
                        SizedBox(height: 95),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1C4FD1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if ((controller?.text.isNotEmpty ?? false) && ( priceController?.text.isNotEmpty ?? false)) {
                                _bloc?.add(CreateOffer(
                                    id: widget.applicationId,
                                    description: controller?.text,
                                    offerPrice: priceController?.text));
                              }
                            },
                            child: LocaleText(
                              'send',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
