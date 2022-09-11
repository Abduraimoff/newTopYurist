import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Models/review/review.dart';
import 'package:top_yurist/data/Repositories/profile_repository.dart';

import '../../data/Models/user/user.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit({required this.userType}) : super(ReviewInitialState()) {
    getReviews();
  }

  final UserType userType;
  final types = ['all', 'resolved', 'not_resolved'];
  final _profileRepository = ProfileRepository();
  Future<void> getReviews() async {
    try {
      final reviews = await _profileRepository.getCustomerReview(userType);
      final acceptedReivews =
          reviews.where((e) => e.isAccepted == true).toList();
      final rejectedRreviews =
          reviews.where((element) => element.isAccepted == false).toList();
      emit(ReviewLoadedState(
          selectedREviewType: 0,
          acceptedReivews: acceptedReivews,
          rejectedRreviews: rejectedRreviews));
    } catch (e) {
      emit(ReviewErrorState('Something went wrong'));
    }
  }

  void changeReviewType(int index) {
    final newState =
        (state as ReviewLoadedState).copyWith(selectedREviewType: index);
    emit(newState);
  }

  // void editReviewShowProfile({required int id, required bool isShowOnProfile}) {
  //   final reviews = state.reviews
  //       .map((e) =>
  //           e.id == id ? e.copyWith(isShowOnProfile: isShowOnProfile) : e)
  //       .toList();
  //   final newState = state.copyWith(reviews: reviews);
  //   emit(newState);
  // }
}
