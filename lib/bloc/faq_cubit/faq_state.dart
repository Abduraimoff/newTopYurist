part of 'faq_cubit.dart';

abstract class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

class FaqInitial extends FaqState {}

class FaqLoadedState extends FaqState {
  const FaqLoadedState(this.faqs);
  final List<Faq> faqs;
}

class FaqErrorState extends FaqState {
  const FaqErrorState(this.errorText);
  final String errorText;
}
