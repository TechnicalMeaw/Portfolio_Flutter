import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:portfolio/model/experience_company_data_model.dart';
import 'package:portfolio/model/pie_chart_data_model.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/view_model/base_controller.dart';

class ExperienceTabViewModel extends BaseGetXController {

  RxDouble scrollProgress = 0.0.obs;
  ScrollController scrollController = ScrollController();

  RxBool topBtnHovered = false.obs;

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
    scrollController.addListener(_updateScrollProgress);

    super.onInit();
  }

  void _updateScrollProgress() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    scrollProgress.value = (currentScroll / maxScroll).clamp(0.0, 1.0);
  }

  @override
  void animateToExperienceTab() {
    print("ExperienceTab First Opened----------------${!super.isTabInMemoryStack(1).value}");
    if (!super.isTabInMemoryStack(1).value){
      isAnimationCompleted.value = false;
      resetAnimations();
      startExperiencePageAnimations();
    }
    scrollProgress.value = 0;
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
              Project(
                  title: "Canara HSBC Life",
                  logoUrl: "https://play-lh.googleusercontent.com/y4aEvyR9l4Def7itYAel0IhVHlRPArkEDTV8rIrwM93tqTjYXTiwXK9JsYtHa3WMXaiXkZ4yGSAvlhvKsY7pCVM=w480-h960-rw",
                  redirectUrl: "https://play.google.com/store/apps/details?id=com.choiceapp.genius"
              ),
              Project(
                  title: "Insta Serve",
                  logoUrl: "https://play-lh.googleusercontent.com/SadIsVLMIE96AUpnJEZwaDkBsZXnJDGmTU6y6D1thZ3z4mAL4cvbVL2yR0iRe4Fyqg=w480-h960-rw",
                  redirectUrl: "https://play.google.com/store/apps/details?id=com.choice.distributor"
              ),
              Project(
                  title: "SBI General Insurance",
                  logoUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpGuI7J3LkxwxiwvKTiqKUzv-JyKeHpTHg2g&s",
                  redirectUrl: "https://play.google.com/store/apps/details?id=com.sbig.insurance"
              ),
              Project(
                title: "Manipal Hospitals",
                logoUrl: "https://upload.wikimedia.org/wikipedia/en/d/dd/Manipal_Hospitals_%28logo%29.png",
                redirectUrl: "https://play.google.com/store/apps/details?id=com.manipal.manipallifeson"
              ),
              Project(
                  title: "Manipal Doctors",
                  logoUrl: "https://play-lh.googleusercontent.com/3w0UtjoEvy9BdmPO6FFyCZxAsfaY_WpYZAuElWHD_PTJstEyT8UIvoOmH8DL0iSCb4A=w240-h480-rw",
                  redirectUrl: "https://apps.apple.com/in/app/manipal-doctors/id6741423418"
              ),
              Project(
                  title: "Green Brillance",
                  logoUrl: "https://es-media-prod.s3.amazonaws.com/media/supplier/logo/source/GreenBrilliance_Logo_1080_Square_kT2ETQ4.jpg",
                  redirectUrl: "https://greenbrilliance.com"
              ),
              Project(
                  title: "Care Health Insurance",
                  logoUrl: "https://play-lh.googleusercontent.com/ZBdHZIdRgt-8pMRTHrSiJqLLQ_03SDr9LVfj_wZOUOgEb5CXA2_Dy-0pJdNKVicex-BS=w240-h480-rw",
                  redirectUrl: "https://play.google.com/store/apps/details?id=com.religare.healthinsurance"
              ),
              Project(
                  title: "Blaze Solar",
                  logoUrl: "https://play-lh.googleusercontent.com/VRh30hR50buyXTagkEYldX1sfBFvTi7-bqsTNvC7t-TY-2QP6_KnUGgeabupT1sQeLQ=w240-h480-rw",
                  redirectUrl: "https://apps.apple.com/in/app/blaze-solar/id6476022542"
              ),
              Project(
                  title: "Blaze CRM",
                  logoUrl: "https://play-lh.googleusercontent.com/6UTDoRJfIQSlR18n17QWf2XOoBJhNa3bm-grvlcmgdQIzlGmb6pwKv_Mknw2sYBrQK0h=w480-h960-rw",
                  redirectUrl: "https://apps.apple.com/in/app/blaze-crm/id6477693152"
              ),
              Project(
                  title: "Hero Insurance",
                  logoUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVdj6TumZRkyMvGB9Jn_RR-LwrJZ3nklckzQ&s",
              ),
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
            Project(title: "Shilah Rakhs", logoUrl: "https://raw.githubusercontent.com/TechnicalMeaw/ShilahRakhs/master/app/src/main/ic_launcher-playstore.png"),
          ]
        )
    );
  }

  void addFreelanceExperienceDetails() {
    freelanceExperienceList.add(
        ExperienceCompanyDataModel(
          jobTitle: "Full Stack Mobile Developer",
          companyName: "InfusedByte Technologies",
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
            Project(
                title: "Plantonic",
                logoUrl: "https://play-lh.googleusercontent.com/xVgqu1sLpSt6iPPwCIB09rkSgkmsroDq91UuwMElTXDCAjw_ccfsJrRJlBShveuuGLU=w240-h480-rw",
                redirectUrl: "https://play.google.com/store/apps/details?id=co.in.plantonic"
            ),
            Project(
                title: "The Laundry lounge",
                logoUrl: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhrIttNsBm7mBISxUTEo0C7ne3-VPQMfoiJ9l3vBAaOZVQZ9YD3vwFRd3MB1H6AhuTF2ibK3Mtu9110O-f7brwFIXvZ0sc8A7obOZCdPJdjtlbLtXq_3sApHn1lCaqa6YiiX243gnVZNXL_YEDtsCdTzeuddiqWtn6I5Ks5I5Z5XAaE2sbUB3RWhWfiwzA/s320/tll_logo.jpg",
                redirectUrl: "https://crm.thelaundrylounge.in"
            ),
            Project(
                title: "Gangs of Greenpur",
                logoUrl: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjxg2VdN56bgPRq9D0_Ih6mJDPrWGnkOnCbWYBfg9tflBq1p4KZzlXeXq1e67aIpGltVZdEn3hxqxQe3VAuns4b3GZaNVbJ5qM4uhNzkRTYAGW4AbuPCkD6mf55t9Dy-EEtR26W4bcyiDx9pRX-iWQHh7lFEBgFVO19N51e_I0Pn2CZg2kRRq96yJbtcgQ/s320/gog_logo.png",
                redirectUrl: "https://play.google.com/store/apps/details?id=com.gangsofgreenpur"
            ),
            Project(title: "95 Club", logoUrl: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEijbnCSKWmDGgrhFQ8yNqzq0esRwr6_9T_K7tyAPEtWtuKS73O8d8AznU_w_CHIyOGEFtbv-ycC-M9eoKbHO35CTIKBrBOwTd5NYpXmW-J5SRz4qomVTrmhyphenhyphenFL3A8BMvwfAsgjKeL3ewAQ_pCe_Pc6gEI8BqUeSSuw1rbXd0ZdubYCZaXJrCJOZT2Q1VhQ/s1024/app_logo.jpg"),
            Project(title: "Bhumi Technocare", logoUrl: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh1oYj4l5Ty26T5fPGESet3aynoGMC2eSbPNe1FnOAEB_XG4ATZ1Ovnd4wv48qa92mcESymqrgtjk-ugDhr56yOPa3lNFg5A2L8JbnAOg09ZR2mH7ns2XNPXi4RXLJDQanTSsr7naPS8asAtft3y0MzcgFnBFsqpuqOgmuW2bEWk0fYeXE2yrLM7TZGjn8/s562/bhumi_logo.jpg"),
          ]
        )
    );

  }

  List<PieChartDataModel> processedTechData(
      List<PieChartDataModel> input,
      ) {
    final List<PieChartDataModel> main = [];
    double others = 0;

    for (final e in input) {
      if (e.percentage < 6) {
        others += e.percentage;
      } else {
        main.add(e);
      }
    }

    if (others > 0) {
      main.add(
        PieChartDataModel(
          title: 'Others',
          percentage: others,
          color: const Color(0xFF9E9E9E),
        ),
      );
    }

    main.sort((a, b) => b.percentage.compareTo(a.percentage));
    return main;
  }


  void addTechnologyStackData(){
    technologyStackList = [
      PieChartDataModel(title: "Flutter", color: ColorConstants.blue1, percentage: 25),
      PieChartDataModel(title: "FastAPI", color: ColorConstants.grassGreen, percentage: 18),
      PieChartDataModel(title: "AWS", color: ColorConstants.minimizeYellow, percentage: 13),

      PieChartDataModel(title: "Django", color: ColorConstants.darkQueenViolet.withOpacity(0.85), percentage: 8),

      PieChartDataModel(title: "Android Development", color: ColorConstants.textBlue, percentage: 16),
      PieChartDataModel(title: "Firebase", color: ColorConstants.orange, percentage: 8),

      PieChartDataModel(title: "PostgresQL", color: ColorConstants.cyanBlue, percentage: 5),
      PieChartDataModel(title: "Unity 2D", color: ColorConstants.deepQueenViolet, percentage: 3),

      PieChartDataModel(title: "Docker", color: ColorConstants.teal, percentage: 2),
      PieChartDataModel(title: "Amplify", color: ColorConstants.deepTeal.withOpacity(0.7), percentage: 2),

      // PieChartDataModel(title: "", color: ColorConstants.glassBlack, percentage: 20),
    ];
  }

  void addProgrammingLanguageListData(){
    programmingLanguageList = [
      PieChartDataModel(title: "Python", color: ColorConstants.grassGreen, percentage: 26),
      PieChartDataModel(title: "Dart", color: ColorConstants.blue, percentage: 25),
      PieChartDataModel(title: "Kotlin", color: ColorConstants.orange, percentage: 21),
      PieChartDataModel(title: "Go", color: ColorConstants.teal, percentage: 3),
      PieChartDataModel(title: "C", color: ColorConstants.textBlue, percentage: 6),
      PieChartDataModel(title: "Java", color: ColorConstants.minimizeYellow, percentage: 19),

    ];
  }

  void addDomainKnowledgeListData(){
    domainKnowledgeList = [
      PieChartDataModel(title: "Mobile", color: ColorConstants.textBlue, percentage: 30),
      PieChartDataModel(title: "Backend", color: ColorConstants.orange, percentage: 18),
      PieChartDataModel(title: "DevOps", color: ColorConstants.teal, percentage: 14),
      PieChartDataModel(title: "Cyber Security", color: ColorConstants.queenViolet, percentage: 12),

      PieChartDataModel(title: "Product Development", color: ColorConstants.grassGreen, percentage: 9),
      PieChartDataModel(title: "Leadership", color: ColorConstants.lightYellow, percentage: 6),
      PieChartDataModel(title: "DBMS", color: ColorConstants.darkQueenViolet, percentage: 7),
      PieChartDataModel(title: "CI/CD", color: ColorConstants.blue1, percentage: 4),
      // PieChartDataModel(title: "Game Development", color: ColorConstants.minimizeYellow, percentage: 4),

    ];
  }


}