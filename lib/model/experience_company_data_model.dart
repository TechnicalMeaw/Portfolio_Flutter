class ExperienceCompanyDataModel{
  final String jobTitle;
  final String companyName;
  final String jobDuration;
  final List<Responsibilities> keyResponsibilities;
  final List<Project> projects;
  // int index;

  const ExperienceCompanyDataModel({
    required this.jobTitle,
    required this.keyResponsibilities,
    required this.jobDuration,
    required this.companyName,
    this.projects = const []
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

class Project{
  String title;
  String? logoUrl;

  Project({required this.title, this.logoUrl});
}

enum TextType{
  bold, normal
}