import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:portfolio/model/experience_company_data_model.dart';
import 'package:portfolio/model/pie_chart_data_model.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/view_model/base_controller.dart';

class ExperienceTabViewModel extends BaseGetXController {

  RxBool crossBtnHovered = false.obs;
  RxBool minimizeBtnHovered = false.obs;
  RxBool isAnimationCompleted = true.obs;

  RxBool isProExperienceVisible = false.obs;
  RxBool isFreelanceExperienceVisible = false.obs;
  RxBool isTechStackVisible = false.obs;
  RxBool isLangVisible = false.obs;
  RxBool isDomainVisible = false.obs;

  List<ExperienceCompanyDataModel> experienceCompanyList = [];
  List<ExperienceCompanyDataModel> freelanceExperienceList = [];
  List<PieChartDataModel> technologyStackList = [];
  List<PieChartDataModel> programmingLanguageList = [];
  List<PieChartDataModel> domainKnowledgeList = [];

  RxBool isProject1KnowMoreBtnHovered = false.obs;

  @override
  void onInit() {

    addCompanyDetails();
    addFreelanceExperienceDetails();
    addTechnologyStackData();
    addProgrammingLanguageListData();
    addDomainKnowledgeListData();

    super.onInit();
  }


  @override
  void animateToExperienceTab() {
    print("ExperienceTab First Opened----------------${!super.isTabInMemoryStack(1).value}");
    if (!super.isTabInMemoryStack(1).value){
      isAnimationCompleted.value = false;
      resetAnimations();
      startExperiencePageAnimations();
    }
    // super.animateToExperienceTab();
  }

  void resetAnimations(){
    isProExperienceVisible.value = false;
    isFreelanceExperienceVisible.value = false;
    isTechStackVisible.value = false;
    isLangVisible.value = false;
    isDomainVisible.value = false;
  }

  void startExperiencePageAnimations() {
    Future.delayed(const Duration(milliseconds: 200), (){
      isProExperienceVisible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 800), (){
      isFreelanceExperienceVisible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 700), (){
      isTechStackVisible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 1300), (){
      isLangVisible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 1800), (){
      isDomainVisible.value = true;
    });

    Future.delayed(const Duration(milliseconds: 2400), (){
      isAnimationCompleted.value = true;
    });
  }


  void addCompanyDetails() {
    experienceCompanyList.add(
        ExperienceCompanyDataModel(
          jobTitle: "Software Engineer",
          companyName: "Mantra Labs",
          jobDuration: "June 2022 - Present",
          keyResponsibilities: [
            Responsibilities(
              // title: "Mobile Development [SBI General Insurance]",
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
            projects : [
              Project(title: "SBI General Insurance", logoUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpGuI7J3LkxwxiwvKTiqKUzv-JyKeHpTHg2g&s"),
              Project(title: "Manipal Hospitals", logoUrl: "https://upload.wikimedia.org/wikipedia/en/d/dd/Manipal_Hospitals_%28logo%29.png"),
              Project(title: "Green Brillance", logoUrl: "https://es-media-prod.s3.amazonaws.com/media/supplier/logo/source/GreenBrilliance_Logo_1080_Square_kT2ETQ4.jpg"),
              Project(title: "Care Health Insurance", logoUrl: "https://play-lh.googleusercontent.com/ZBdHZIdRgt-8pMRTHrSiJqLLQ_03SDr9LVfj_wZOUOgEb5CXA2_Dy-0pJdNKVicex-BS=w240-h480-rw"),

              Project(title: "Blaze Solar", logoUrl: "https://play-lh.googleusercontent.com/VRh30hR50buyXTagkEYldX1sfBFvTi7-bqsTNvC7t-TY-2QP6_KnUGgeabupT1sQeLQ=w240-h480-rw"),
              Project(title: "Hero Insurance", logoUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVdj6TumZRkyMvGB9Jn_RR-LwrJZ3nklckzQ&s"),
            ]
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
          projects: [
            Project(title: "Shilah Rakhs", logoUrl: "https://raw.githubusercontent.com/TechnicalMeaw/ShilahRakhs/master/app/src/main/ic_launcher-playstore.png")
          ]
        )
    );
  }

  void addFreelanceExperienceDetails() {
    freelanceExperienceList.add(
        ExperienceCompanyDataModel(
          jobTitle: "Full Stack Mobile Developer",
          companyName: "",
          jobDuration: "Nov 2022 - Mar 2023",
          keyResponsibilities: [
            Responsibilities(
              // title: "Flutter",
                responsibilityTexts: [
                  CompanyResponsibilityText(
                      text: "Developed a ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "social-media application",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: " featuring ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "multiple sub-communities",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: ", ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "video streaming",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: ", interactive features like ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "follow, like, comment",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: ", Instagram-like ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "story sharing",
                      textType: TextType.bold
                  ),
                  CompanyResponsibilityText(
                      text: ", and advanced ",
                      textType: TextType.normal
                  ),
                  CompanyResponsibilityText(
                      text: "location and role management.",
                      textType: TextType.bold
                  )
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


          ],
          projects: [
            Project(title: "Plantonic", logoUrl: "https://play-lh.googleusercontent.com/xVgqu1sLpSt6iPPwCIB09rkSgkmsroDq91UuwMElTXDCAjw_ccfsJrRJlBShveuuGLU=w240-h480-rw"),
            Project(title: "Gangs of Greenpur", logoUrl: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjxg2VdN56bgPRq9D0_Ih6mJDPrWGnkOnCbWYBfg9tflBq1p4KZzlXeXq1e67aIpGltVZdEn3hxqxQe3VAuns4b3GZaNVbJ5qM4uhNzkRTYAGW4AbuPCkD6mf55t9Dy-EEtR26W4bcyiDx9pRX-iWQHh7lFEBgFVO19N51e_I0Pn2CZg2kRRq96yJbtcgQ/s320/gog_logo.png"),
            Project(title: "95 Club", logoUrl: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEijbnCSKWmDGgrhFQ8yNqzq0esRwr6_9T_K7tyAPEtWtuKS73O8d8AznU_w_CHIyOGEFtbv-ycC-M9eoKbHO35CTIKBrBOwTd5NYpXmW-J5SRz4qomVTrmhyphenhyphenFL3A8BMvwfAsgjKeL3ewAQ_pCe_Pc6gEI8BqUeSSuw1rbXd0ZdubYCZaXJrCJOZT2Q1VhQ/s1024/app_logo.jpg")
          ]
        )
    );

  }

  void addTechnologyStackData(){
    technologyStackList = [
      PieChartDataModel(title: "Android Development", color: ColorConstants.textBlue, percentage: 24),
      PieChartDataModel(title: "Flutter", color: ColorConstants.blue, percentage: 20),
      PieChartDataModel(title: "FastApi", color: ColorConstants.darkQueenViolet.withOpacity(0.85), percentage: 14),
      PieChartDataModel(title: "AWS", color: ColorConstants.minimizeYellow, percentage: 7),
      PieChartDataModel(title: "Django", color: ColorConstants.grassGreen, percentage: 12),

      PieChartDataModel(title: "PostgresQL", color: ColorConstants.cyanBlue, percentage: 4),
      PieChartDataModel(title: "Unity 2D", color: ColorConstants.queenViolet, percentage: 4),
      PieChartDataModel(title: "Firebase", color: ColorConstants.orange, percentage: 8),

      PieChartDataModel(title: "MySQL", color: ColorConstants.teal, percentage: 3),
      PieChartDataModel(title: "Amplify", color: ColorConstants.deepTeal.withOpacity(0.7), percentage: 4),

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
      PieChartDataModel(title: "DevOps", color: ColorConstants.teal, percentage: 9),
      PieChartDataModel(title: "Cyber Security", color: ColorConstants.queenViolet, percentage: 13),

      PieChartDataModel(title: "DSA", color: ColorConstants.grassGreen, percentage: 20),
      // PieChartDataModel(title: "Game Development", color: ColorConstants.minimizeYellow, percentage: 4),
      PieChartDataModel(title: "DBMS", color: ColorConstants.deepTeal.withOpacity(0.7), percentage: 10),

    ];
  }


}