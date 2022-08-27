import 'package:bloc/bloc.dart';
import 'package:top_yurist/data/Models/review/review.dart';

import '../../data/Models/user/user.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewState(reviews: [], selectedREviewType: 0)) {
    getReviews();
  }

  Future<void> getReviews() async {
    final newState = state.copyWith(
      reviews: [
        Review(
          id: 0,
          user: const User(
            fullName: 'Феруз Тахирович',
            username: '+998999999999',
            profilePhoto: 'assets/images/lawyer.jpg',
            lawyerState: false,
            userType: UserType.lawyer,
            selectedAmount: 5,
            finishedApplicatoinCount: 6,
            offerAmount: 0,
          ),
          lawyer: const User(
            fullName: 'Феруз Тахирович',
            username: '+998999999999',
            profilePhoto: 'assets/images/lawyer.jpg',
            lawyerState: false,
            userType: UserType.lawyer,
            selectedAmount: 5,
            finishedApplicatoinCount: 6,
            offerAmount: 0,
          ),
          isResolved: true,
          title:
              'Очень приятно было работать с Ферузом Тахировичем грамотно проконсультировал подготовил документы. Запрос решен на 100%',
          time: DateTime.parse('2022-12-04'),
          isShowOnProfile: true,
        ),
        Review(
          id: 1,
          user: const User(
            fullName: 'Феруз Тахирович',
            username: '+998999999999',
            profilePhoto: 'assets/images/lawyer.jpg',
            lawyerState: false,
            userType: UserType.lawyer,
            selectedAmount: 5,
            finishedApplicatoinCount: 6,
            offerAmount: 0,
          ),
          lawyer: const User(
            fullName: 'Феруз Тахирович',
            username: '+998999999999',
            profilePhoto: 'assets/images/lawyer.jpg',
            lawyerState: false,
            userType: UserType.lawyer,
            selectedAmount: 5,
            finishedApplicatoinCount: 6,
            offerAmount: 0,
          ),
          isResolved: true,
          title:
              'Очень приятно было работать с Ферузом Тахировичем грамотно проконсультировал подготовил документы. Запрос решен на 100%',
          time: DateTime.parse('2022-12-04'),
          isShowOnProfile: false,
        ),
      ],
    );
    emit(newState);
  }

  void changeReviewType(int index) {
    final newState = state.copyWith(selectedREviewType: index);
    emit(newState);
  }

  void editReviewShowProfile({required int id, required bool isShowOnProfile}) {
    final reviews = state.reviews
        .map((e) =>
            e.id == id ? e.copyWith(isShowOnProfile: isShowOnProfile) : e)
        .toList();
    final newState = state.copyWith(reviews: reviews);
    emit(newState);
  }
}
