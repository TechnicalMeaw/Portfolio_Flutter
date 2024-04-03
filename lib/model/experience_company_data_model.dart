class ExperienceCompanyDataModel{
  final String jobTitle;
  final String companyName;
  final String jobDuration;
  final List<Responsibilities> keyResponsibilities;
  // int index;

  const ExperienceCompanyDataModel({
    required this.jobTitle,
    required this.keyResponsibilities,
    required this.jobDuration,
    required this.companyName
  });
}

class Responsibilities{
  String title;
  List<CompanyResponsibilityText> responsibilityTexts;
  Responsibilities({this.title = "", required this.responsibilityTexts,});
}

class CompanyResponsibilityText{
  String text;
  TextType textType;

  CompanyResponsibilityText({required this.text, required this.textType});
}

enum TextType{
  bold, normal
}