part of 'review_cubit.dart';

class ReviewState {
  ReviewState({required this.selectedREviewType, required this.reviews});
  final int selectedREviewType;
  final List<Review> reviews;

  ReviewState copyWith({
    int? selectedREviewType,
    List<Review>? reviews,
  }) {
    return ReviewState(
      selectedREviewType: selectedREviewType ?? this.selectedREviewType,
      reviews: reviews ?? this.reviews,
    );
  }
}
