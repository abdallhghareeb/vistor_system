
abstract class Category {
  late int id;
  late String name;
  static List<Category> filterCategories(List<Category> categories,
      {bool includeAll = false}) {
    if (includeAll) {
      // If includeAll is true, add the "all" category at the beginning
      List<Category> filteredCategories = List.from(categories);
      // filteredCategories.insert(
      //     0,
      //     CategoryEntity(
      //         id: 0, name: LanguageProvider.translate('categories', 'all')));
      return filteredCategories;
    } else {
      return List.from(categories);
    }
  }
}
