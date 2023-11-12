class LanguageModel {
  LanguageModel(this.label, this.proficiency);
  String label;
  double proficiency;
}

// Map<String, double> toMap(List<LanguageModel> list) {
//   Map<String, double> langMap = {};
//   for (var i in list) {
//     langMap[i.label] = i.proficiency;
//   }
//   return langMap;
// }
