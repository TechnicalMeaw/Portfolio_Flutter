import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:portfolio/model/experience_company_data_model.dart';
import 'package:portfolio/model/pie_chart_data_model.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/view_model/base_controller.dart';

class ExperienceTabViewModel extends BaseGetXController {

  RxBool crossBtnHovered = false.obs;
  RxBool minimizeBtnHovered = false.obs;

  List<ExperienceCompanyDataModel> experienceCompanyList = [];
  List<ExperienceCompanyDataModel> freelanceExperienceList = [];
  List<PieChartDataModel> technologyStackList = [];
  List<PieChartDataModel> programmingLanguageList = [];
  List<PieChartDataModel> domainKnowledgeList = [];

  @override
  void onInit() {

    addCompanyDetails();
    addFreelanceExperienceDetails();
    addTechnologyStackData();
    addProgrammingLanguageListData();
    addDomainKnowledgeListData();

    super.onInit();
  }



  void addCompanyDetails() {
    experienceCompanyList.add(
        ExperienceCompanyDataModel(
          jobTitle: "Software Engineer",
          companyName: "Mantra Labs",
          jobDuration: "June 2022 - Present",
          keyResponsibilities: [
            Responsibilities(
              // title: "Development and Enhancement of Flutter apps",
                responsibilityTexts: [
                  CompanyResponsibilityText(
                      text: "Development of ",
                      textType: TextType.normal
                  ),CompanyResponsibilityText(
                      text: "Flutter",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " apps with ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "pixel-perfect UI",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " and fluid ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "animations",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: ", leveraging ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "GetX",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " and ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "Bloc",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " for state management.",
                      textType: TextType.normal
                  ),

                ]
            ),
            Responsibilities(
              // title: "Flutter",
                responsibilityTexts: [
                  CompanyResponsibilityText(
                      text: "Proficient in integrating ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "third-party APIs",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " and ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "SDKs ",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: "with expertise in working with ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "Canvas",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " and ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "CustomPaint",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " for crafting ",
                      textType: TextType.normal
                  ),CompanyResponsibilityText(
                      text: "custom widgets.",
                      textType: TextType.bold
                  ),
                ]
            ),
            Responsibilities(
              // title: "Django",
                responsibilityTexts: [
                  CompanyResponsibilityText(
                      text: "Optimized",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: " MySQL ",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: "data flow",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: " with ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "Django Restful APIs",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: ", cutting ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "response time",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " by ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "30%",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: ", boosting user experience.",
                      textType: TextType.normal
                  ),
                ]
            ),

          ],
        )
    );
    experienceCompanyList.add(
        ExperienceCompanyDataModel(
          jobTitle: "Android Developer",
          companyName: "Coprotect Ventures",
          jobDuration: "Aug 2021 - Oct 2021",
          keyResponsibilities: [
            Responsibilities(
              // title: "Flutter",
                responsibilityTexts: [
                  CompanyResponsibilityText(
                      text: "Extensive experience in developing ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "Android ",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: "applications using ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "Java/Kotlin",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: ", with ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "MVVM",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " architecture.",
                      textType: TextType.normal
                  ),

                ]
            ),
            Responsibilities(
              // title: "Flutter",
                responsibilityTexts: [
                  CompanyResponsibilityText(
                      text: "End-to-end",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " development of a ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "social media application",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " from ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "scratch.",
                      textType: TextType.bold
                  ),

                ]
            ),
          ],
        )
    );
  }

  void addFreelanceExperienceDetails() {
    freelanceExperienceList.add(
        ExperienceCompanyDataModel(
          jobTitle: "Full Stack Mobile Developer",
          companyName: "",
          jobDuration: "Aug 2021 - Oct 2021",
          keyResponsibilities: [
            Responsibilities(
              // title: "Flutter",
                responsibilityTexts: [
                  CompanyResponsibilityText(
                      text: "End-to-end",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " development of a ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "gaming application",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " with multiple games",
                      textType: TextType.normal
                  ),
                  // CompanyResponsibilityText(
                  //     text: "",
                  //     textType: TextType.bold
                  // ),
                  CompanyResponsibilityText(
                      text: " and ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "in-app currency",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " and an ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "admin app",
                      textType: TextType.bold
                  ),
                   CompanyResponsibilityText(
                      text: " for active management.",
                      textType: TextType.normal
                  ),

                ]
            ),

            Responsibilities(
              // title: "Flutter",
                responsibilityTexts: [
                  CompanyResponsibilityText(
                      text: "Crafted an ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "e-commerce application",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: ", integrating ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "courier services",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: ", along with an ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "admin panel",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " for efficient product and order management.",
                      textType: TextType.normal
                  ),

                ]
            ),
          ],
        )
    );
  }

  void addTechnologyStackData(){
    technologyStackList = [
      PieChartDataModel(title: "Android Development", color: ColorConstants.textBlue, percentage: 24),
      PieChartDataModel(title: "Flutter", color: ColorConstants.blue, percentage: 20),
      PieChartDataModel(title: "FastApi", color: ColorConstants.crossRed, percentage: 14),
      PieChartDataModel(title: "AWS", color: ColorConstants.minimizeYellow, percentage: 6),
      PieChartDataModel(title: "Django", color: ColorConstants.grassGreen, percentage: 12),
      PieChartDataModel(title: "PostgresQL", color: ColorConstants.cyanBlue, percentage: 4),
      PieChartDataModel(title: "Unity 2D", color: ColorConstants.queenViolet, percentage: 4),
      PieChartDataModel(title: "MySQL", color: ColorConstants.teal, percentage: 3),
      PieChartDataModel(title: "Amplify", color: ColorConstants.glassBlack.withOpacity(0.7), percentage: 4),
      PieChartDataModel(title: "Firebase", color: ColorConstants.orange, percentage: 9),
      // PieChartDataModel(title: "", color: ColorConstants.glassBlack, percentage: 20),
    ];
  }

  void addProgrammingLanguageListData(){
    programmingLanguageList = [
      PieChartDataModel(title: "Python", color: ColorConstants.grassGreen, percentage: 24),
      PieChartDataModel(title: "Dart", color: ColorConstants.blue, percentage: 21),
      PieChartDataModel(title: "Kotlin", color: ColorConstants.orange, percentage: 22),
      PieChartDataModel(title: "Go", color: ColorConstants.teal, percentage: 8),
      PieChartDataModel(title: "C", color: ColorConstants.textBlue, percentage: 6),

      PieChartDataModel(title: "Java", color: ColorConstants.minimizeYellow, percentage: 19),

    ];
  }

  void addDomainKnowledgeListData(){
    domainKnowledgeList = [
      PieChartDataModel(title: "Mobile", color: ColorConstants.textBlue, percentage: 30),
      PieChartDataModel(title: "Backend", color: ColorConstants.orange, percentage: 18),
      PieChartDataModel(title: "DevOps", color: ColorConstants.teal, percentage: 8),
      PieChartDataModel(title: "Cyber Security", color: ColorConstants.queenViolet, percentage: 13),

      PieChartDataModel(title: "DSA", color: ColorConstants.grassGreen, percentage: 22),
      // PieChartDataModel(title: "Game Development", color: ColorConstants.minimizeYellow, percentage: 4),
      PieChartDataModel(title: "DBMS", color: ColorConstants.crossRed, percentage: 9),

    ];
  }
}