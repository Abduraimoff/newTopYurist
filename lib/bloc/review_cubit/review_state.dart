part of 'review_cubit.dart';

abstract class ReviewState extends Equatable {}

class ReviewInitialState extends ReviewState {
  @override
  List<Object?> get props => [];
}

class ReviewLoadedState extends ReviewState {
  ReviewLoadedState({
    required this.selectedREviewType,
    required this.rejectedRreviews,
    required this.acceptedReivews,
  });

  final int selectedREviewType;
  final List<Review> rejectedRreviews;
  final List<Review> acceptedReivews;

  @override
  List<Object?> get props => [
        selectedREviewType,
        rejectedRreviews,
        acceptedReivews,
      ];

  ReviewLoadedState copyWith({
    int? selectedREviewType,
    List<Review>? rejectedRreviews,
    List<Review>? acceptedReivews,
  }) {
    return ReviewLoadedState(
      selectedREviewType: selectedREviewType ?? this.selectedREviewType,
      rejectedRreviews: rejectedRreviews ?? this.rejectedRreviews,
      acceptedReivews: acceptedReivews ?? this.acceptedReivews,
    );
  }
}

class ReviewErrorState extends ReviewState {
  ReviewErrorState(this.errorText);
  final String errorText;
  @override
  List<Object?> get props => [errorText];
}
