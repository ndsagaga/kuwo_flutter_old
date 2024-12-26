import 'package:flutter/material.dart';
import 'card_list_item_widget.dart';
import 'package:searchfield/searchfield.dart';
import '../models/card_model.dart';

class SearchFieldWidget extends StatelessWidget {
  final List<CardModel> cards;
  final Function(String) onCardTapped;
  const SearchFieldWidget(
      {super.key, required this.cards, required this.onCardTapped});

  SearchFieldListItem<CardModel> toSearchFieldItem(CardModel card) {
    return SearchFieldListItem<CardModel>("",
        child: CardListItemWidget(cardModel: card), item: card);
  }

  bool searchQueryComparator(String query, CardModel e) {
    return e.title
        .toLowerCase()
        .split(' ')
        .any((word) => word.startsWith(query.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchField<CardModel>(
        focusNode: focus,
        onTapOutside: (p0) => p0.down ? focus.unfocus() : focus.requestFocus(),
        maxSuggestionsInViewPort: 3,
        itemHeight: 100,
        hint: 'Search for articles',
        suggestionsDecoration: SuggestionDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8),
          ),
          border: Border.all(
            color: const Color.fromARGB(255, 215, 212, 212).withOpacity(0.5),
          ),
        ),
        searchInputDecoration: SearchInputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none),
        ),
        onSuggestionTap: (p0) {
          focus.unfocus();
          onCardTapped(p0.item!.id);
        },
        onSearchTextChanged: (query) {
          if (query.isNotEmpty) {
            final c = cards
                .where((e) => searchQueryComparator(query, e))
                .take(5)
                .map(toSearchFieldItem)
                .toList();
            return c;
          }
          return cards.take(5).map(toSearchFieldItem).toList();
        },
        suggestions: cards.map(toSearchFieldItem).toList(),
      ),
    );
  }
}
