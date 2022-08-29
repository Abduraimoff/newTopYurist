import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Models/faq/faq.dart';
import 'package:top_yurist/data/Repositories/profile_repository.dart';
import 'package:top_yurist/data/data_provider/faq_data_provider.dart';

part 'faq_state.dart';

class FAQCubit extends Cubit<FaqState> {
  FAQCubit() : super(FaqInitial()) {
    getFAQ();
  }
  final _profileRepository = ProfileRepository();
  final _faqDataProvider = FAQDataProvider();

  Future<void> getFAQ() async {
    try {
      final localData = await _faqDataProvider.getFAQ();
      if (localData != null) {
        emit(FaqLoadedState(localData));
        _updateLocalData();
        return;
      }
      final faqs = await _profileRepository.getFAQ();
      _saveFAQ(faqs);
      emit(FaqLoadedState(faqs));
    } catch (e) {
      emit(FaqErrorState(e.toString()));
    }
  }

  Future<void> _updateLocalData() async {
    final faqs = await _profileRepository.getFAQ();
    _saveFAQ(faqs);
  }

  void _saveFAQ(List<Faq> list) {
    _faqDataProvider.saveFAQ(list);
  }
}
