import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/model/experience_company_data_model.dart';
import 'package:portfolio/model/pie_chart_data_model.dart';
import 'package:portfolio/resources/color_constants.dart';

class ExperienceState {
  final double scrollProgress;
  final bool topBtnHovered;
  final bool isAnimationCompleted;
  final bool isProExperienceVisible;
  final bool isFreelanceExperienceVisible;
  final bool isTechStackVisible;
  final bool isLangVisible;
  final bool isDomainVisible;
  final bool isProject1KnowMoreBtnHovered;

  final List<ExperienceCompanyDataModel> experienceCompanyList;
  final List<ExperienceCompanyDataModel> freelanceExperienceList;
  final List<PieChartDataModel> technologyStackList;
  final List<PieChartDataModel> programmingLanguageList;
  final List<PieChartDataModel> domainKnowledgeList;

  const ExperienceState({
    this.scrollProgress = 0.0,
    this.topBtnHovered = false,
    this.isAnimationCompleted = true,
    this.isProExperienceVisible = false,
    this.isFreelanceExperienceVisible = false,
    this.isTechStackVisible = false,
    this.isLangVisible = false,
    this.isDomainVisible = false,
    this.isProject1KnowMoreBtnHovered = false,
    this.experienceCompanyList = const [],
    this.freelanceExperienceList = const [],
    this.technologyStackList = const [],
    this.programmingLanguageList = const [],
    this.domainKnowledgeList = const [],
  });

  ExperienceState copyWith({
    double? scrollProgress,
    bool? topBtnHovered,
    bool? isAnimationCompleted,
    bool? isProExperienceVisible,
    bool? isFreelanceExperienceVisible,
    bool? isTechStackVisible,
    bool? isLangVisible,
    bool? isDomainVisible,
    bool? isProject1KnowMoreBtnHovered,
    List<ExperienceCompanyDataModel>? experienceCompanyList,
    List<ExperienceCompanyDataModel>? freelanceExperienceList,
    List<PieChartDataModel>? technologyStackList,
    List<PieChartDataModel>? programmingLanguageList,
    List<PieChartDataModel>? domainKnowledgeList,
  }) {
    return ExperienceState(
      scrollProgress: scrollProgress ?? this.scrollProgress,
      topBtnHovered: topBtnHovered ?? this.topBtnHovered,
      isAnimationCompleted:
          isAnimationCompleted ?? this.isAnimationCompleted,
      isProExperienceVisible:
          isProExperienceVisible ?? this.isProExperienceVisible,
      isFreelanceExperienceVisible: isFreelanceExperienceVisible ??
          this.isFreelanceExperienceVisible,
      isTechStackVisible: isTechStackVisible ?? this.isTechStackVisible,
      isLangVisible: isLangVisible ?? this.isLangVisible,
      isDomainVisible: isDomainVisible ?? this.isDomainVisible,
      isProject1KnowMoreBtnHovered: isProject1KnowMoreBtnHovered ??
          this.isProject1KnowMoreBtnHovered,
      experienceCompanyList:
          experienceCompanyList ?? this.experienceCompanyList,
      freelanceExperienceList:
          freelanceExperienceList ?? this.freelanceExperienceList,
      technologyStackList: technologyStackList ?? this.technologyStackList,
      programmingLanguageList:
          programmingLanguageList ?? this.programmingLanguageList,
      domainKnowledgeList: domainKnowledgeList ?? this.domainKnowledgeList,
    );
  }
}

class ExperienceCubit extends Cubit<ExperienceState> {
  ExperienceCubit() : super(const ExperienceState()) {
    _init();
  }

  final ScrollController scrollController = ScrollController();

  void _init() {
    final experienceCompanyList = <ExperienceCompanyDataModel>[];
    final freelanceExperienceList = <ExperienceCompanyDataModel>[];
    final technologyStackList = <PieChartDataModel>[];
    final programmingLanguageList = <PieChartDataModel>[];
    final domainKnowledgeList = <PieChartDataModel>[];

    _addCompanyDetails(experienceCompanyList);
    _addFreelanceExperienceDetails(freelanceExperienceList);
    _addTechnologyStackData(technologyStackList);
    _addProgrammingLanguageListData(programmingLanguageList);
    _addDomainKnowledgeListData(domainKnowledgeList);

    scrollController.addListener(_updateScrollProgress);

    emit(ExperienceState(
      experienceCompanyList: experienceCompanyList,
      freelanceExperienceList: freelanceExperienceList,
      technologyStackList: technologyStackList,
      programmingLanguageList: programmingLanguageList,
      domainKnowledgeList: domainKnowledgeList,
    ));
  }

  void _updateScrollProgress() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    emit(state.copyWith(
        scrollProgress: (currentScroll / maxScroll).clamp(0.0, 1.0)));
  }

  void animateToTab({required bool isFirstOpen}) {
    if (isFirstOpen) {
      emit(state.copyWith(isAnimationCompleted: false));
      resetAnimations();
      startExperiencePageAnimations();
    }
    emit(state.copyWith(scrollProgress: 0));
  }

  void resetAnimations() {
    emit(state.copyWith(
      isProExperienceVisible: false,
      isFreelanceExperienceVisible: false,
      isTechStackVisible: false,
      isLangVisible: false,
      isDomainVisible: false,
    ));
  }

  void startExperiencePageAnimations() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (isClosed) return;
      emit(state.copyWith(isProExperienceVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (isClosed) return;
      emit(state.copyWith(isFreelanceExperienceVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      if (isClosed) return;
      emit(state.copyWith(isTechStackVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 1300), () {
      if (isClosed) return;
      emit(state.copyWith(isLangVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (isClosed) return;
      emit(state.copyWith(isDomainVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (isClosed) return;
      emit(state.copyWith(isAnimationCompleted: true));
    });
  }

  void setTopBtnHovered(bool value) =>
      emit(state.copyWith(topBtnHovered: value));

  void setProject1KnowMoreHovered(bool value) =>
      emit(state.copyWith(isProject1KnowMoreBtnHovered: value));

  List<PieChartDataModel> processedTechData(List<PieChartDataModel> input) {
    final main = <PieChartDataModel>[];
    double others = 0;

    for (final e in input) {
      if (e.percentage < 6) {
        others += e.percentage;
      } else {
        main.add(e);
      }
    }

    if (others > 0) {
      main.add(PieChartDataModel(
          title: 'Others',
          percentage: others,
          color: const Color(0xFF9E9E9E)));
    }

    main.sort((a, b) => b.percentage.compareTo(a.percentage));
    return main;
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_updateScrollProgress);
    scrollController.dispose();
    return super.close();
  }

  void _addCompanyDetails(List<ExperienceCompanyDataModel> list) {
    list.add(
      ExperienceCompanyDataModel(
        jobTitle: "Research Engineer",
        companyName: "Havells India Ltd.",
        jobDuration: "Feb 2025 - Present",
        keyResponsibilities: [
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Leading the development of ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "Flutter applications",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: " powering the ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "Havells One",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text:
                      " smart home ecosystem with scalable and production-ready architecture.",
                  textType: TextType.normal),
            ],
          ),
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Designed and implemented ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "IoT connectivity",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: ", including ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "MQTT communication",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text:
                      ", device onboarding, provisioning, and real-time device control.",
                  textType: TextType.normal),
            ],
          ),
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Developed secure ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "geofencing",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: ", ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "root/jailbreak detection",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text:
                      ", anti-Frida detection, SSL certificate pinning and app integrity features for Android & iOS.",
                  textType: TextType.normal),
            ],
          ),
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Improved application quality by profiling ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "battery consumption",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: " using ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "Perfetto",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text:
                      ", Android Profiler and LeakCanary, identifying performance bottlenecks and optimizing resource usage.",
                  textType: TextType.normal),
            ],
          ),
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Built reusable ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "Flutter packages",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text:
                      " and modular architectures, improving maintainability and development velocity across multiple IoT products.",
                  textType: TextType.normal),
            ],
          ),
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Collaborated with ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "cross-functional teams",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text:
                      " to deliver premium smart home experiences while following Clean Architecture, MVVM, Bloc and best engineering practices.",
                  textType: TextType.normal),
            ],
          ),
        ],
        projects: [
          Project(
            title: "Havells One",
            logoUrl:
                "https://play-lh.googleusercontent.com/xP4q2rM8U8Qf6k8JY7nXn4vR5M2VvM6LkN6z8nJ4rP4vD9QeY6nN7Q9kM5vP4qA=w240-h480-rw",
            redirectUrl:
                "https://play.google.com/store/apps/details?id=com.havells.havellsone",
          ),
        ],
      ),
    );

    list.add(
      ExperienceCompanyDataModel(
        jobTitle: "Software Engineer",
        companyName: "Mantra Labs",
        jobDuration: "June 2022 - Feb 2025",
        keyResponsibilities: [
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Developed high-performance ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "Flutter",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text:
                      " applications with pixel-perfect UI, responsive layouts and smooth animations.",
                  textType: TextType.normal),
            ],
          ),
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Implemented scalable architectures using ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "GetX",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: " and ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "Bloc",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: " for robust state management.",
                  textType: TextType.normal),
            ],
          ),
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Integrated multiple ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "REST APIs",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: ", third-party SDKs and custom UI components using ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "Canvas",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: " and ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "CustomPaint",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: ".",
                  textType: TextType.normal),
            ],
          ),
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Optimized backend communication through ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "Django REST APIs",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text:
                      ", reducing response times and improving overall application performance.",
                  textType: TextType.normal),
            ],
          ),
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Delivered enterprise applications for ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "insurance, healthcare and solar energy",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text:
                      " domains while collaborating with cross-functional teams.",
                  textType: TextType.normal),
            ],
          ),
        ],
        projects: [
          Project(
            title: "Canara HSBC Life",
            logoUrl:
                "https://play-lh.googleusercontent.com/y4aEvyR9l4Def7itYAel0IhVHlRPArkEDTV8rIrwM93tqTjYXTiwXK9JsYtHa3WMXaiXkZ4yGSAvlhvKsY7pCVM=w480-h960-rw",
            redirectUrl:
                "https://play.google.com/store/apps/details?id=com.choiceapp.genius",
          ),
          Project(
            title: "SBI General Insurance",
            logoUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpGuI7J3LkxwxiwvKTiqKUzv-JyKeHpTHg2g&s",
            redirectUrl:
                "https://play.google.com/store/apps/details?id=com.sbig.insurance",
          ),
          Project(
            title: "Manipal Hospitals",
            logoUrl:
                "https://upload.wikimedia.org/wikipedia/en/d/dd/Manipal_Hospitals_%28logo%29.png",
            redirectUrl:
                "https://play.google.com/store/apps/details?id=com.manipal.manipallifeson",
          ),
          Project(
            title: "Manipal Doctors",
            logoUrl:
                "https://play-lh.googleusercontent.com/3w0UtjoEvy9BdmPO6FFyCZxAsfaY_WpYZAuElWHD_PTJstEyT8UIvoOmH8DL0iSCb4A=w240-h480-rw",
            redirectUrl:
                "https://apps.apple.com/in/app/manipal-doctors/id6741423418",
          ),
          Project(
            title: "Care Health Insurance",
            logoUrl:
                "https://play-lh.googleusercontent.com/ZBdHZIdRgt-8pMRTHrSiJqLLQ_03SDr9LVfj_wZOUOgEb5CXA2_Dy-0pJdNKVicex-BS=w240-h480-rw",
            redirectUrl:
                "https://play.google.com/store/apps/details?id=com.religare.healthinsurance",
          ),
          Project(
            title: "Green Brilliance",
            logoUrl:
                "https://es-media-prod.s3.amazonaws.com/media/supplier/logo/source/GreenBrilliance_Logo_1080_Square_kT2ETQ4.jpg",
            redirectUrl: "https://greenbrilliance.com",
          ),
          Project(
            title: "Blaze Solar",
            logoUrl:
                "https://play-lh.googleusercontent.com/VRh30hR50buyXTagkEYldX1sfBFvTi7-bqsTNvC7t-TY-2QP6_KnUGgeabupT1sQeLQ=w240-h480-rw",
            redirectUrl:
                "https://apps.apple.com/in/app/blaze-solar/id6476022542",
          ),
          Project(
            title: "Blaze CRM",
            logoUrl:
                "https://play-lh.googleusercontent.com/6UTDoRJfIQSlR18n17QWf2XOoBJhNa3bm-grvlcmgdQIzlGmb6pwKv_Mknw2sYBrQK0h=w480-h960-rw",
            redirectUrl:
                "https://apps.apple.com/in/app/blaze-crm/id6477693152",
          ),
        ],
      ),
    );

    list.add(
      ExperienceCompanyDataModel(
        jobTitle: "Android Developer",
        companyName: "Coprotect Ventures",
        jobDuration: "Aug 2021 - Oct 2021",
        keyResponsibilities: [
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Developed native ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "Android applications",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: " using ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "Java",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: " and ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "Kotlin",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: " following ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "MVVM",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text: " architecture.",
                  textType: TextType.normal),
            ],
          ),
          Responsibilities(
            responsibilityTexts: [
              CompanyResponsibilityText(
                  text: "Built a ",
                  textType: TextType.normal),
              CompanyResponsibilityText(
                  text: "social networking application",
                  textType: TextType.bold),
              CompanyResponsibilityText(
                  text:
                      " from scratch, handling complete development lifecycle.",
                  textType: TextType.normal),
            ],
          ),
        ],
        projects: [
          Project(
            title: "Shilah Rakhs",
            logoUrl:
                "https://raw.githubusercontent.com/TechnicalMeaw/ShilahRakhs/master/app/src/main/ic_launcher-playstore.png",
          ),
        ],
      ),
    );
  }

  void _addFreelanceExperienceDetails(List<ExperienceCompanyDataModel> list) {
    list.add(ExperienceCompanyDataModel(
      jobTitle: "Full Stack Mobile Developer",
      companyName: "InfusedByte Technologies",
      jobDuration: "Nov 2022 - Mar 2023",
      keyResponsibilities: [
        Responsibilities(
          responsibilityTexts: [
            CompanyResponsibilityText(
                text: "Developed a ", textType: TextType.normal),
            CompanyResponsibilityText(
                text: "social-media application",
                textType: TextType.bold),
            CompanyResponsibilityText(
                text: " featuring ", textType: TextType.normal),
            CompanyResponsibilityText(
                text: "multiple sub-communities",
                textType: TextType.bold),
            CompanyResponsibilityText(
                text: ", ", textType: TextType.normal),
            CompanyResponsibilityText(
                text: "video streaming", textType: TextType.bold),
            CompanyResponsibilityText(
                text: ", interactive features like ",
                textType: TextType.normal),
            CompanyResponsibilityText(
                text: "follow, like, comment", textType: TextType.bold),
            CompanyResponsibilityText(
                text: ", Instagram-like ", textType: TextType.normal),
            CompanyResponsibilityText(
                text: "story sharing", textType: TextType.bold),
            CompanyResponsibilityText(
                text: ", and advanced ", textType: TextType.normal),
            CompanyResponsibilityText(
                text: "location and role management.",
                textType: TextType.bold),
          ],
        ),
        Responsibilities(
          responsibilityTexts: [
            CompanyResponsibilityText(
                text: "Crafted an ", textType: TextType.normal),
            CompanyResponsibilityText(
                text: "e-commerce application",
                textType: TextType.bold),
            CompanyResponsibilityText(
                text: ", integrating ", textType: TextType.normal),
            CompanyResponsibilityText(
                text: "courier services", textType: TextType.bold),
            CompanyResponsibilityText(
                text: ", along with an ", textType: TextType.normal),
            CompanyResponsibilityText(
                text: "admin panel", textType: TextType.bold),
            CompanyResponsibilityText(
                text:
                    " for efficient product and order management.",
                textType: TextType.normal),
          ],
        ),
        Responsibilities(
          responsibilityTexts: [
            CompanyResponsibilityText(
                text: "End-to-end", textType: TextType.bold),
            CompanyResponsibilityText(
                text: " development of a ", textType: TextType.normal),
            CompanyResponsibilityText(
                text: "gaming application", textType: TextType.bold),
            CompanyResponsibilityText(
                text: " with multiple games", textType: TextType.normal),
            CompanyResponsibilityText(
                text: " and ", textType: TextType.normal),
            CompanyResponsibilityText(
                text: "in-app currency", textType: TextType.bold),
            CompanyResponsibilityText(
                text: " and an ", textType: TextType.normal),
            CompanyResponsibilityText(
                text: "admin app", textType: TextType.bold),
            CompanyResponsibilityText(
                text: " for active management.",
                textType: TextType.normal),
          ],
        ),
      ],
      projects: [
        Project(
          title: "Plantonic",
          logoUrl:
              "https://play-lh.googleusercontent.com/xVgqu1sLpSt6iPPwCIB09rkSgkmsroDq91UuwMElTXDCAjw_ccfsJrRJlBShveuuGLU=w240-h480-rw",
          redirectUrl:
              "https://play.google.com/store/apps/details?id=co.in.plantonic",
        ),
        Project(
          title: "The Laundry lounge",
          logoUrl:
              "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhrIttNsBm7mBISxUTEo0C7ne3-VPQMfoiJ9l3vBAaOZVQZ9YD3vwFRd3MB1H6AhuTF2ibK3Mtu9110O-f7brwFIXvZ0sc8A7obOZCdPJdjtlbLtXq_3sApHn1lCaqa6YiiX243gnVZNXL_YEDtsCdTzeuddiqWtn6I5Ks5I5Z5XAaE2sbUB3RWhWfiwzA/s320/tll_logo.jpg",
          redirectUrl: "https://crm.thelaundrylounge.in",
        ),
        Project(
          title: "Gangs of Greenpur",
          logoUrl:
              "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjxg2VdN56bgPRq9D0_Ih6mJDPrWGnkOnCbWYBfg9tflBq1p4KZzlXeXq1e67aIpGltVZdEn3hxqxQe3VAuns4b3GZaNVbJ5qM4uhNzkRTYAGW4AbuPCkD6mf55t9Dy-EEtR26W4bcyiDx9pRX-iWQHh7lFEBgFVO19N51e_I0Pn2CZg2kRRq96yJbtcgQ/s320/gog_logo.png",
          redirectUrl:
              "https://play.google.com/store/apps/details?id=com.gangsofgreenpur",
        ),
        Project(
          title: "95 Club",
          logoUrl:
              "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEijbnCSKWmDGgrhFQ8yNqzq0esRwr6_9T_K7tyAPEtWtuKS73O8d8AznU_w_CHIyOGEFtbv-ycC-M9eoKbHO35CTIKBrBOwTd5NYpXmW-J5SRz4qomVTrmhyphenhyphenFL3A8BMvwfAsgjKeL3ewAQ_pCe_Pc6gEI8BqUeSSuw1rbXd0ZdubYCZaXJrCJOZT2Q1VhQ/s1024/app_logo.jpg",
        ),
        Project(
          title: "Bhumi Technocare",
          logoUrl:
              "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh1oYj4l5Ty26T5fPGESet3aynoGMC2eSbPNe1FnOAEB_XG4ATZ1Ovnd4wv48qa92mcESymqrgtjk-ugDhr56yOPa3lNFg5A2L8JbnAOg09ZR2mH7ns2XNPXi4RXLJDQanTSsr7naPS8asAtft3y0MzcgFnBFsqpuqOgmuW2bEWk0fYeXE2yrLM7TZGjn8/s562/bhumi_logo.jpg",
        ),
      ],
    ));
  }

  void _addTechnologyStackData(List<PieChartDataModel> list) {
    list.addAll([
      PieChartDataModel(
          title: "Flutter", color: ColorConstants.blue1, percentage: 25),
      PieChartDataModel(
          title: "FastAPI", color: ColorConstants.grassGreen, percentage: 18),
      PieChartDataModel(
          title: "AWS", color: ColorConstants.minimizeYellow, percentage: 13),
      PieChartDataModel(
          title: "Django",
          color: ColorConstants.darkQueenViolet.withOpacity(0.85),
          percentage: 8),
      PieChartDataModel(
          title: "Android Development",
          color: ColorConstants.textBlue,
          percentage: 16),
      PieChartDataModel(
          title: "Firebase", color: ColorConstants.orange, percentage: 8),
      PieChartDataModel(
          title: "PostgresQL",
          color: ColorConstants.cyanBlue,
          percentage: 5),
      PieChartDataModel(
          title: "Unity 2D",
          color: ColorConstants.deepQueenViolet,
          percentage: 3),
      PieChartDataModel(
          title: "Docker", color: ColorConstants.teal, percentage: 2),
      PieChartDataModel(
          title: "Amplify",
          color: ColorConstants.deepTeal.withOpacity(0.7),
          percentage: 2),
    ]);
  }

  void _addProgrammingLanguageListData(List<PieChartDataModel> list) {
    list.addAll([
      PieChartDataModel(
          title: "Python", color: ColorConstants.grassGreen, percentage: 26),
      PieChartDataModel(
          title: "Dart", color: ColorConstants.blue, percentage: 25),
      PieChartDataModel(
          title: "Kotlin", color: ColorConstants.orange, percentage: 21),
      PieChartDataModel(
          title: "Go", color: ColorConstants.teal, percentage: 3),
      PieChartDataModel(
          title: "C", color: ColorConstants.textBlue, percentage: 6),
      PieChartDataModel(
          title: "Java", color: ColorConstants.minimizeYellow, percentage: 19),
    ]);
  }

  void _addDomainKnowledgeListData(List<PieChartDataModel> list) {
    list.addAll([
      PieChartDataModel(
          title: "Mobile", color: ColorConstants.textBlue, percentage: 30),
      PieChartDataModel(
          title: "Backend", color: ColorConstants.orange, percentage: 18),
      PieChartDataModel(
          title: "DevOps", color: ColorConstants.teal, percentage: 14),
      PieChartDataModel(
          title: "Cyber Security",
          color: ColorConstants.queenViolet,
          percentage: 12),
      PieChartDataModel(
          title: "Product Development",
          color: ColorConstants.grassGreen,
          percentage: 9),
      PieChartDataModel(
          title: "Leadership",
          color: ColorConstants.lightYellow,
          percentage: 6),
      PieChartDataModel(
          title: "DBMS",
          color: ColorConstants.darkQueenViolet,
          percentage: 7),
      PieChartDataModel(
          title: "CI/CD", color: ColorConstants.blue1, percentage: 4),
    ]);
  }
}
