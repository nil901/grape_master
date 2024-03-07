import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:grape_master/model/plot_information_model/chatani_model.dart';
import 'package:grape_master/model/plot_information_model/description_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:grape_master/util/large_button.dart';
import 'package:open_file/open_file.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../model/home_model/plot_model.dart';
import '../../model/home_model/selected_crop_model.dart';
import '../../model/plot_information_model/aks_questions.dart';
import '../../model/plot_information_model/answer_submit_model.dart';
import '../../model/plot_information_model/dairy_list_model.dart';
import '../../model/plot_information_model/disease_categorey_model.dart';
import '../../model/plot_information_model/disease_information_model.dart';
import '../../model/plot_information_model/faq_categorey.dart';
import '../../model/plot_information_model/faq_questionlist_model.dart';
import '../../model/plot_information_model/nutrient_managment_model.dart';
import '../../model/plot_information_model/observation_report_model.dart';
import '../../model/plot_information_model/pakage_list_model.dart';
import '../../model/plot_information_model/question_categorey_model.dart';
import '../../model/plot_information_model/report_model.dart';
import '../../model/plot_information_model/shedule_list_model.dart';
import '../../model/plot_information_model/subscription_list_model.dart';
import '../../model/selected_plot_models/cultivation_type_model.dart';
import '../../model/selected_plot_models/land_type_model.dart';
import '../../model/selected_plot_models/veriety_model.dart';
import '../../network/api_constants.dart';
import '../../services/api_service.dart';
import '../../util/color.dart';
import '../../util/constants.dart';
import 'package:path/path.dart' as path;
import '../../util/dialog_helper.dart';
import '../../util/image_assets.dart';
import '../../util/prefs/PreferencesKey.dart';
import '../../util/prefs/app_preference.dart';
import '../../util/util.dart';
import '../Home/home.dart';
import '../auth/LocalString.dart';
import '../home_Screen.dart';

class plotcnt extends ChangeNotifier {
  bool _isLoading = false;

  bool get value => _isLoading;
  bool connections = false;
  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  String selectedGender = 'null';
  String methoad = "null";
  String updaesh = "Local";
  String? selctedvalue;
  String? cultivationType;
  String? veriteytype;
  String? landtype;
  String? chataniid;

  final List<String> items1 = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  List<Map<String, String>> items = [
    {'id': "1", 'name': txt_schedule.tr, 'image': ImageAssets.ic_schedule},
    {'id': "2", 'name': txt_ask_question.tr, 'image': ImageAssets.ic_question},
    {
      'id': "3",
      'name': txt_soil_water_reports.tr,
      'image': ImageAssets.ic_report
    },
    {'id': "4", 'name': txt_faq.tr, 'image': ImageAssets.ic_faq},
    {'id': "5", 'name': txt_diary.tr, 'image': ImageAssets.ic_diary},
    {'id': "6", 'name': txt_disease_control.tr, 'image': ImageAssets.ic_virus},
    {'id': "7", 'name': txt_my_plot.tr, 'image': ImageAssets.ic_plot},
    {
      'id': "8",
      'name': txt_observation_report.tr,
      'image': ImageAssets.ic_observation_report_image
    }
  ];

  List<Map<String, String>> scheduleitem = [
    {'id': "1", 'name': "Spray", 'image': ImageAssets.ic_spray},
    {'id': "2", 'name': "Firtilzer", 'image': ImageAssets.ic_fertilizer},
    {'id': "3", 'name': "General", 'image': ImageAssets.ic_general},
  ];
  bool isOpen = false;
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  late String _filePath;
  CropSelectedModel? selectedcrop;
  dynamic reportimage = "";
  TextEditingController cultivationcontroller = TextEditingController(text: "");
  TextEditingController varietycontroller = TextEditingController(text: "");
  TextEditingController datetimeContoller = TextEditingController(text: "");
  TextEditingController landtypeContoller = TextEditingController(text: "");
  TextEditingController plantingDistance = TextEditingController(text: "");
  TextEditingController plantingDistance1 = TextEditingController(text: "");
  TextEditingController pastproblemController = TextEditingController(text: "");

  TextEditingController waterScorceController = TextEditingController(text: "");

  TextEditingController quetionCategoreyController =
      TextEditingController(text: "");

  TextEditingController nameandQuantityofchemicalController =
      TextEditingController(text: "");

  TextEditingController titleNameController = TextEditingController(text: "");
  TextEditingController activeCommponetController =
      TextEditingController(text: "");
  TextEditingController purposeController = TextEditingController(text: "");
  TextEditingController phController = TextEditingController(text: "");

  int? reportId;
  String? reportName;
  TextEditingController cropNameCntroller = TextEditingController(text: "");
  TextEditingController nameofReportCntroller = TextEditingController(text: "");
  TextEditingController labortaryNameCntroller =
      TextEditingController(text: "");
  TextEditingController SampleDateController = TextEditingController(text: "");
  TextEditingController importanctContController =
      TextEditingController(text: "");

  //update
  TextEditingController soiltypeController = TextEditingController(text: "");
  TextEditingController updatecultivationcontroller =
      TextEditingController(text: "");
  TextEditingController updatevarietycontroller =
      TextEditingController(text: "");
  String? apidateformat;

  TextEditingController updatedatetimeContoller =
      TextEditingController(text: "");
  TextEditingController updatelandtypeContoller =
      TextEditingController(text: "");
  TextEditingController updateplantingDistance =
      TextEditingController(text: "");
  TextEditingController updateplantingDistance1 =
      TextEditingController(text: "");
  TextEditingController updateplotAreaController =
      TextEditingController(text: "");
  TextEditingController previousController = TextEditingController(text: "");

  //addrom

  int? cropId;
  int? varityID;
  int? soilId;
  String selectedOption = '';
  String selectedOption2 = '';
  String rachna1 = '';
  String? purningType;

  String waterspplayplot = '';

  String exportlocal = '';
  String metodwater = '';
  String? plotId;
  String? StId;
  String? CropId;
  String? viriatyId;
  int? scheduleId = 1;
  String? chataniID;
  String? imageData;
  int? categoreyPostId;

  bool isdisplay = false;
  startRecording() async {
    print('hello');
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String folderPath = path.join(appDocDir.path,
          '/storage/emulated/0/Music'); // Define the folder name
      await Directory(folderPath)
          .create(recursive: true); // Create the folder if it doesn't exist
      _filePath = path.join(folderPath,
          'ttttttttsvsvsv.aac'); // Define the file path within the folder

      print('File path: $_filePath');

      await _recorder.startRecorder(
        toFile: _filePath,
        codec: Codec.aacADTS,
      );

      print('Recorder started');
    } catch (err) {
      print('Error starting recorder: $err');
    }
  }

  stopRecording(context) async {
    // navigator!.pop(context);
    try {
      await _recorder.stopRecorder();
      //isdisplay = true;
      print('Recording stopped');

      if (_filePath != null) {
        print('File saved to: $_filePath');

        // Define the desired directory path
        final desiredDirectory =
            '/my_recordings'; // Change this to your desired directory

        // Get the external storage directory
        final externalDirectory = await getExternalStorageDirectory();
        if (externalDirectory != null) {
          // Create the directory if it doesn't exist
          final musicDirectory =
              Directory('${externalDirectory.path}$desiredDirectory');
          if (!await musicDirectory.exists()) {
            await musicDirectory.create(recursive: true);
          }

          // Define the new file path within the desired directory
          final newFilePath = '${musicDirectory.path}/recorded_audio.aac';
          await File(_filePath).copy(newFilePath);
          print('File saved to: $newFilePath');

          // Open the file using the open_file package
          OpenFile.open(newFilePath);
        }
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  String? selectedFilePath;

  Future<void> openFileExplorer(context) async {
    try {
      final filePath = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );
      if (filePath == null) return; // User canceled the picker
      final file = filePath.files.first;

      // Store the selected file path
      selectedFilePath = file.path;

      // Open the selected file
      OpenFile.open(selectedFilePath!);
    } catch (e) {
      print('Error picking/opening file: $e');
    }
    Navigator.pop(context);
  }

  TextEditingController caluculateareacontroller =
      TextEditingController(text: "");

  List<String> options = [
    txt_well.tr,
    txt_Borewell.tr,
    txt_canal_river.tr,
    txt_other.tr
  ];
  List<String> selectedOptions = [];
  String? option;

  Future selectedPlotModel() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": "",
                "END": "",
                "WORD": "",
                "GET_DATA": "Get_Crop",
                "ID1": "",
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        selectedcrop = CropSelectedModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return selectedcrop;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  ReportListModel? reportListModel;
  Future reportListApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": "",
                "END": "",
                "WORD": "",
                "GET_DATA": "ReportType",
                "ID1": "",
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        reportListModel = ReportListModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return reportListModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  ObservationReportModel? observationReportModel;
  Future observationApiList() async {
    log(" is gg  ${AppPreference().getString(PreferencesKey.languageid).toString()} ,$plotId, $CropId");
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.observation,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": plotId,
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "CROP_ID": CropId
              }))
          .then((value) {
        observationReportModel = ObservationReportModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return observationReportModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  SubmitAnswerModel? submitAnswerModel;
  Future answerSubmit(qid) async {
    log(" is gg  ${AppPreference().getString(PreferencesKey.languageid).toString()} ,$plotId, $CropId");
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url:
                  "http://newgrapemastersnskapi.cropmaster.in/api/ObservationQuestion/1",
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "LANG_ID": "1",
                "Q_ID": qid
              }))
          .then((value) {
        submitAnswerModel = SubmitAnswerModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return submitAnswerModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  CultivationTypeModel? cultivationTypeModel;

  Future culitivationApi() async {
    log(" is gg  ${AppPreference().getString(PreferencesKey.languageid).toString()}");
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": "",
                "END": "",
                "WORD": "",
                "GET_DATA": "Get_ChhataniType",
                "ID1": CropId,
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": 1
              }))
          .then((value) {
        cultivationTypeModel?.data.clear();
        cultivationTypeModel = CultivationTypeModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return cultivationTypeModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  VarietyModel? varietyModel;

  Future vationApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": "",
                "END": "",
                "WORD": "",
                "GET_DATA": "Get_Variety",
                "ID1": CropId,
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        varietyModel?.data.clear();
        varietyModel = VarietyModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return varietyModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  ChatanitypeModel? chatanitypeModel;
  Future chataniApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": "",
                "END": "",
                "WORD": "",
                "GET_DATA": "Get_ChhataniType",
                "ID1": CropId,
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": "1"
              }))
          .then((value) {
        chatanitypeModel = ChatanitypeModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return chatanitypeModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  LandTypeModel? landTypeModel;

  Future landTypeApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": "",
                "END": "",
                "WORD": "",
                "GET_DATA": "Get_SoilType",
                "ID1": "",
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        landTypeModel = LandTypeModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return landTypeModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  Future rigstar(BuildContext context) async {
    try {
      if (selectedOptions.isEmpty) {
        // Utils.showFlushbar("", context);
      }
      await plotRagister(context);
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      log('$e  rfgrtgytt');
      DialogHelper.hideLoading();
    }
  }

  void validationRegtrationcrop(context) {
    // plotRagister(context);
    // if (cultivationType == null) {
    //   Utils().validationTostmassage(
    //     txt_lagvadiche_prakar.tr,
    //   );
    // } else if (datetimeContoller.text.isEmpty) {
    //   Utils().validationTostmassage(
    //     txt_date_of_planting.tr,
    //   );
    // } else if (veriteytype == null) {
    //   Utils().validationTostmassage(
    //     txt_variety.tr,
    //   );
    // } else if (CropId != "22" && CropId != "21") {
    //   Utils().validationTostmassage(
    //     jaminprakar.tr,
    //   );
    // }

     if (CropId == '1') {
      if (veriteytype == null) {
        Utils().validationTostmassage(
          txt_variety.tr,
        );
      } else if (chataniid == null) {
        Utils().validationTostmassage(
          txt_select_chatni_type.tr,
        );
      } else if (datetimeContoller.text.isEmpty) {
        Utils().validationTostmassage(
          txt_date_of_planting.tr,
        );
      } else if (landtype == null) {
        Utils().validationTostmassage(
          jaminprakar.tr,
        );
      }else if (waterScorceController.text.isEmpty) {
        Utils().validationTostmassage(select_irrigation_source.tr);
      } else if (selectedOption == ' ') {
        Utils().validationTostmassage(
          txt_lagvad_padhat.tr,
        );
      }  else if (plantingDistance.text.isEmpty) {
        Utils().validationTostmassage(txt_planting_distance.tr);
      }else if (plantingDistance1.text.isEmpty) {
        Utils().validationTostmassage(txt_planting_distance.tr);
      } else if (caluculateareacontroller.text.isEmpty) {
        Utils().validationTostmassage(plotcalculation.tr);
      } else {
        plotRagister(context);
      }
    }

    if (CropId == '36') {
      if (cultivationType == null) {
        Utils().validationTostmassage(
          txt_lagvadiche_prakar.tr,
        );
      } else if (datetimeContoller.text.isEmpty) {
        Utils().validationTostmassage(
          txt_date_of_planting.tr,
        );
      } else if (veriteytype == null) {
        Utils().validationTostmassage(
          txt_variety.tr,
        );
      } else if (CropId != "22" && CropId != "21" && landtype == null) {
        Utils().validationTostmassage(
          jaminprakar.tr,
        );
      } else if (plantingDistance1.text.isEmpty) {
        Utils().validationTostmassage(txt_planting_distance.tr);
      } else if (caluculateareacontroller.text.isEmpty) {
        Utils().validationTostmassage(plotcalculation.tr);
      } else {
        plotRagister(context);
      }
    }
    if (CropId == '23' || CropId == '34' && landtype == null) {
      if (cultivationType == null) {
        Utils().validationTostmassage(
          txt_lagvadiche_prakar.tr,
        );
      } else if (datetimeContoller.text.isEmpty) {
        Utils().validationTostmassage(
          txt_date_of_planting.tr,
        );
      } else if (veriteytype == null) {
        Utils().validationTostmassage(
          txt_variety.tr,
        );
      } else if (CropId != "22" && CropId != "21" && landtype == null) {
        Utils().validationTostmassage(
          jaminprakar.tr,
        );
      } else if (plantingDistance1.text.isEmpty) {
        Utils().validationTostmassage(txt_planting_distance.tr);
      } else if (caluculateareacontroller.text.isEmpty) {
        Utils().validationTostmassage(plotcalculation.tr);
      } else {
        plotRagister(context);
      }
    }
    if (CropId == '19') {
      if (cultivationType == null) {
        Utils().validationTostmassage(
          txt_lagvadiche_prakar.tr,
        );
      } else if (datetimeContoller.text.isEmpty) {
        Utils().validationTostmassage(
          txt_date_of_planting.tr,
        );
      } else if (veriteytype == null) {
        Utils().validationTostmassage(
          txt_variety.tr,
        );
      } else if (CropId != "22" && CropId != "21" && landtype == null) {
        Utils().validationTostmassage(
          jaminprakar.tr,
        );
      } else if (plantingDistance1.text.isEmpty) {
        Utils().validationTostmassage(txt_planting_distance.tr);
      } else if (updaesh == 'null') {
        Utils().validationTostmassage(txt_purpose.tr);
      } else if (caluculateareacontroller.text.isEmpty) {
        Utils().validationTostmassage(plotcalculation.tr);
      } else {
        plotRagister(context);
      }
    }
    if (CropId == '41' || CropId == '24' && landtype == null) {
      if (cultivationType == null) {
        Utils().validationTostmassage(
          txt_lagvadiche_prakar.tr,
        );
      } else if (datetimeContoller.text.isEmpty) {
        Utils().validationTostmassage(
          txt_date_of_planting.tr,
        );
      } else if (veriteytype == null) {
        Utils().validationTostmassage(
          txt_variety.tr,
        );
      } else if (CropId != "22" && CropId != "21" && landtype == null) {
        Utils().validationTostmassage(
          jaminprakar.tr,
        );
      } else if (plantingDistance1.text.isEmpty) {
        Utils().validationTostmassage(txt_planting_distance.tr);
      } else if (caluculateareacontroller.text.isEmpty) {
        Utils().validationTostmassage(plotcalculation.tr);
      } else {
        plotRagister(context);
      }
    } else {
      // plotRagister(context);
    }
    if (CropId == '21' ||
        CropId == '32' ||
        CropId == '40' ||
        CropId == '29' && landtype == null) {
      if (cultivationType == null) {
        Utils().validationTostmassage(
          txt_lagvadiche_prakar.tr,
        );
      } else if (datetimeContoller.text.isEmpty) {
        Utils().validationTostmassage(
          txt_date_of_planting.tr,
        );
      } else if (veriteytype == null) {
        Utils().validationTostmassage(
          txt_variety.tr,
        );
      } else if (CropId != "22" && CropId != "21") {
        Utils().validationTostmassage(
          jaminprakar.tr,
        );
      } else if (caluculateareacontroller.text.isEmpty) {
        Utils().validationTostmassage(plotcalculation.tr);
      } else {
        plotRagister(context);
      }
    }
    if (CropId == '39' || CropId == '30' || CropId == '31') {
      if (cultivationType == null) {
        Utils().validationTostmassage(
          txt_lagvadiche_prakar.tr,
        );
      } else if (datetimeContoller.text.isEmpty) {
        Utils().validationTostmassage(
          txt_date_of_planting.tr,
        );
      } else if (veriteytype == null) {
        Utils().validationTostmassage(
          txt_variety.tr,
        );
      } else if (landtype == null && landtype == null) {
        Utils().validationTostmassage(
          jaminprakar.tr,
        );
      } else if (caluculateareacontroller.text.isEmpty) {
        Utils().validationTostmassage(plotcalculation.tr);
      } else {
        plotRagister(context);
      }
    }
    if (CropId == '22' || CropId == '33' || CropId == '17') {
      if (cultivationType == null) {
        Utils().validationTostmassage(
          txt_lagvadiche_prakar.tr,
        );
      } else if (datetimeContoller.text.isEmpty) {
        Utils().validationTostmassage(
          txt_date_of_planting.tr,
        );
      } else if (veriteytype == null) {
        Utils().validationTostmassage(
          txt_variety.tr,
        );
      } else if (CropId != "22" && CropId != "21" && landtype == null) {
        Utils().validationTostmassage(
          jaminprakar.tr,
        );
      } else if (plantingDistance1.text.isEmpty) {
        Utils().validationTostmassage(txt_planting_distance.tr);
      } else if (caluculateareacontroller.text.isEmpty) {
        Utils().validationTostmassage(plotcalculation.tr);
      } else {
        plotRagister(context);
      }
    }
   

    if (CropId == '4' ||
        CropId == '6' ||
        CropId == '2' ||
        CropId == '11' ||
        CropId == '10' ||
        CropId == '8' ||
        CropId == '30' ||
        CropId == '3') {
      if (cultivationType == null) {
        Utils().validationTostmassage(
          txt_lagvadiche_prakar.tr,
        );
      } else if (datetimeContoller.text.isEmpty) {
        Utils().validationTostmassage(
          txt_date_of_planting.tr,
        );
      } else if (veriteytype == null) {
        Utils().validationTostmassage(
          txt_variety.tr,
        );
      } else if (CropId != "22" && CropId != "21" && landtype == null) {
        Utils().validationTostmassage(
          jaminprakar.tr,
        );
      } else if (waterScorceController.text.isEmpty) {
        Utils().validationTostmassage(select_irrigation_source.tr);
      } else if (caluculateareacontroller.text.isEmpty) {
        Utils().validationTostmassage(plotcalculation.tr);
      } else {
        plotRagister(context);
      }
    }
    if (CropId == '9') {
      if (cultivationType == null) {
        Utils().validationTostmassage(
          txt_lagvadiche_prakar.tr,
        );
      } else if (datetimeContoller.text.isEmpty) {
        Utils().validationTostmassage(
          txt_date_of_planting.tr,
        );
      } else if (veriteytype == null) {
        Utils().validationTostmassage(
          txt_variety.tr,
        );
      } else if (CropId != "22" && CropId != "21" && landtype == null) {
        Utils().validationTostmassage(
          jaminprakar.tr,
        );
      } else if (waterScorceController.text.isEmpty) {
        Utils().validationTostmassage(select_irrigation_source.tr);
      } else if (selectedOption == ' ') {
        Utils().validationTostmassage(
          txt_lagvad_padhat.tr,
        );
      } else if (plantingDistance.text.isEmpty) {
        Utils().validationTostmassage(txt_planting_distance.tr);
      }
      else if (plantingDistance1.text.isEmpty) {
        Utils().validationTostmassage(txt_planting_distance.tr);
      }else if (caluculateareacontroller.text.isEmpty) {
        Utils().validationTostmassage(plotcalculation.tr);
      } else {
        plotRagister(context);
      }
    }

    if (CropId == '24' ||
        CropId == '27' ||
        CropId == '37' ||
        landtype == null) {
      if (cultivationType == null) {
        Utils().validationTostmassage(
          txt_lagvadiche_prakar.tr,
        );
      } else if (datetimeContoller.text.isEmpty) {
        Utils().validationTostmassage(
          txt_date_of_planting.tr,
        );
      } else if (veriteytype == null) {
        Utils().validationTostmassage(
          txt_variety.tr,
        );
      } else if (CropId != "22" && CropId != "21" && landtype == null) {
        Utils().validationTostmassage(
          jaminprakar.tr,
        );
      } else if (plantingDistance1.text.isEmpty) {
        Utils().validationTostmassage(txt_planting_distance.tr);
      } else if (caluculateareacontroller.text.isEmpty) {
        Utils().validationTostmassage(plotcalculation.tr);
      } else if (plantingDistance.text.isEmpty) {
        Utils().validationTostmassage(txt_planting_distance.tr);
      } else {
        print('sussus');
        plotRagister(context);
      }
    }
  }

  // String? cultivationType;
  String? cultivationname;
  Future plotRagister(context) async {
    // print("crop id :${AppPreference().getString(PreferencesKey.uId).toString()}");
    String distance = "${plantingDistance.text} X ${plantingDistance1.text}";
    //    String? cultivationType;
    // String? veriteytype;
    // String? landtype;
    DialogHelper.showLoading("");

    var jsonObject = {
      "PLOT_ID": "",
      "USER_ID": AppPreference().getInt(PreferencesKey.uId),
      "CROP_ID": CropId.toString(),
      "CROPVARIETY_ID": veriteytype.toString(),
      "CHATANI_ID": cultivationType == null ? "" : cultivationType,
      "ST_ID": landtype,
      "WATER_SOURCE": waterScorceController.text,
      "PLOT_SRUCTURE": "",
      "CULTIVATION_TYPE": selectedOption!.replaceAll("-", "null"),
      "METHOD_OF_WATER": waterspplayplot.replaceAll("-", "null"),
      "CROP_DISTANCE": distance,
      "EXPORT_LOCAL": updaesh.toString(),
      "PLOT_AREA": caluculateareacontroller.text,
      "LATITUDE_1": "",
      "LONGITUDE_1": "",
      "LATITUDE_2": "",
      "LONGTUDE_2": "",
      "PREVIOUS_YEAR_PROBLEM": previousController.text,
      "SOWING_DATE": apidateformat,
      "TASK": "ADD",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": ""
    };

    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.addplot,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(jsonObject))
        .then((value) async {
      log('${jsonObject}');
      if (value.data['ResponseCode'] == '0') {
        selectedOptions.remove(option);

        DialogHelper.hideLoading();
        Utils().validationTostmassage(addedsuccessfully.tr);
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade, // Choose your desired animation type
            child: MyHomePage(),
          ),
        );
        cultivationType = null;
        cultivationcontroller.clear();
        varietycontroller.clear();
        datetimeContoller.clear();
        landtypeContoller.clear();
        veriteytype = null;
        landtype = null;
        plantingDistance.clear();
        pastproblemController.clear();
        plantingDistance1.clear();
        newQuetionnController.clear();
        quetionCategoreyController.clear();
        waterScorceController.clear();
        selectedOptions.clear();
        caluculateareacontroller..clear();
        // Navigator.pop(context);
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  String? verityid;
  Future editplot(context, cropverity) async {
    // print("crop id :${AppPreference().getString(PreferencesKey.uId).toString()}");
    String distance = "${plantingDistance.text} X ${plantingDistance1.text}";
    //    String? cultivationType;
    // String? veriteytype;
    // String? landtype;
    DialogHelper.showLoading("");

    var jsonObject = {
      "PLOT_ID": plotId,
      "USER_ID": AppPreference().getInt(PreferencesKey.uId),
      "CROP_ID": CropId,
      "CROPVARIETY_ID": cropverity,
      "CHATANI_ID": cultivationType,
      "ST_ID": landtype,
      "WATER_SOURCE": "null",
      "PLOT_SRUCTURE": "null",
      "CULTIVATION_TYPE": "null",
      "METHOD_OF_WATER": waterScorceController.text,
      "CROP_DISTANCE": updateplantingDistance.text,
      "EXPORT_LOCAL": updaesh,
      "PLOT_AREA": updateplotAreaController.text,
      "LATITUDE_1": "",
      "LONGITUDE_1": "",
      "LATITUDE_2": "",
      "LONGTUDE_2": "",
      "PREVIOUS_YEAR_PROBLEM": previousController.text,
      "SOWING_DATE": apidateformat.toString(),
      "TASK": "EDIT",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1"
    };

    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.addplot,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(jsonObject))
        .then((value) async {
      log('${jsonObject}');
      if (value.data['ResponseCode'] == '0') {
        selectedOptions.remove(option);

        DialogHelper.hideLoading();
        Utils().validationTostmassage(addedsuccessfully.tr);
        // cultivationType = null;
        // cultivationcontroller.clear();
        // varietycontroller.clear();
        // datetimeContoller.clear();
        // landtypeContoller.clear();
        // veriteytype = null;
        // landtype = null;
        // plantingDistance.clear();
        // pastproblemController.clear();
        // plantingDistance1.clear();
        // newQuetionnController.clear();
        // quetionCategoreyController.clear();
        // waterScorceController.clear();
        // selectedOptions.clear();
        // calucu
        // lateareacontroller..clear();
        // Navigator.pop(context);

        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade, // Choose your desired animation type
            child: MyHomePage(),
          ),
        );
      } else {
        DialogHelper.hideLoading();
        // Utils().validationTostmassage(addedsuccessfully.tr);
        //S Utils().validationTostmassage(addedsuccessfully.tr);

        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  AskQuestionModel? askQuestionModel;

  Future askQutionListApi() async {
    log('${ApiRoutes.askqution}');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.askqution,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": "1",
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
                "PLOT_ID": plotId
              }))
          .then((value) {
        askQuestionModel = AskQuestionModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return askQuestionModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  QuestionCategoreyModel? questionCategoreyModel;
  String? cropSelected;
  Future quetionCategoreyListApi() async {
    log('$plotId');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "NONE",
                "GET_DATA": "FarmerQuestionCategory_List",
                "ID1": "",
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        questionCategoreyModel = QuestionCategoreyModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return questionCategoreyModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  TextEditingController newQuetionnController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  void validationPostQuetion(context) {
    if (cropSelected == null) {
      Utils().validationTostmassage(txt_category.tr);
    } else if (newQuetionnController.text.isEmpty) {
      Utils().validationTostmassage(txt_question.tr);
    } else {
      postQuetion(context);
    }
  }

  Future postQuetion(context) async {
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.farmerquetion,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "PLOT_ID": plotId,
              "NEWQUETION": newQuetionnController.text,
              "DESCRIPTION": descriptionController.text,
              "TASK": "ADD",
              "EXTRA1": cropSelected,
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              "IMAGE_URL": imageData?.isEmpty == null ? "" : imageData
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        //Navigator.of(context).pop();
        DialogHelper.hideLoading();
        cropSelected == null;
        cropSelected = null;
        // String id = value.data['DATA1'][0]['Column1'].toString();
        //Utils().validationTostmassage("Aded Successfully${id}");
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: MyHomePage(),
        //   ),
        newQuetionnController.clear();
        descriptionController.clear();
        quetionCategoreyController.clear();

        imageData = "";

        Utils().validationTostmassage(questionsussfully.tr);

        // uploadFile(id, context);

        // );
        // print(value.data['DATA1'][0]['Column1']);

        //  Navigator.pop(context);
        //   uploadFile(id,selectedFilePath.toString());

        // Navigator.pop(context);
        askQutionListApi();
        // Navigator.of(context).pop();
        Navigator.pop(context);
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future<void> uploadFile(String claimId, context) async {
    // API endpoint
    final url = 'http://newgrapemastersnskapi.cropmaster.in/api/UploadPDF';

    // Create a MultipartRequest
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Add fields to the request
    request.fields['ID'] = claimId;
    request.fields['TYPE'] = 'Add_ToDoList_PDF';
    request.fields['EXTRA'] = '';
    request.fields['EXTRA1'] = '';
    request.fields['EXTRA2'] = '';
    request.fields['FILE_NAME'] = selectedFilePath!;

    // File to upload
    var file = File(selectedFilePath!);

    // Add the file to the request
    var fileStream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartFile = http.MultipartFile('file', fileStream, length,
        filename: selectedFilePath);

    // Add the file to the request
    request.files.add(multipartFile);

    // Send the request
    try {
      var response = await request.send();

      // Check the response
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File uploaded successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        print('Error uploading file: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  NutrientManagementModel? nutrientManagementModel;

  Future NetrientManagementList() async {
    log('$plotId');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.reportlist,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
                "PLOT_ID": plotId,
                "START": 0,
                "END": 10000,
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "WORD": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        nutrientManagementModel = NutrientManagementModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return nutrientManagementModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  FaqCategoreyModel? faqCategoreyModel;
  int? catid;

  Future faqCategoreyListApi() async {
    log('$plotId');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 100000,
                "WORD": "",
                "GET_DATA": "Get_FaqCategory",
                "ID1": "",
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": CropId,
                "EXTRA2": plotId,
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        faqCategoreyModel = FaqCategoreyModel.fromJson(value.data);
        _setLoading(false);

        //  log('dssssssssff---${value.data}');
        faqQuetionList(faqCategoreyModel?.data[0].fqcId);
      });
      return faqCategoreyModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  FaqQuetionListModel? faqQuetionListModel;

  Future faqQuetionList(catid) async {
    log(' crop h$plotId');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.faq,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "CROP_ID": CropId,
                "CAT_ID": catid,
                "TASK": "FAQ"
              }))
          .then((value) {
        faqQuetionListModel = FaqQuetionListModel.fromJson(value.data);
        _setLoading(false);

        // log('dssssssssff---${value.data}');
      });
      return faqQuetionListModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  DairyListModel? dairyListModel;

  Future dairyListApi() async {
    log(' crop h$plotId');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.dairy,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
                "PLOT_ID": plotId
              }))
          .then((value) {
        dairyListModel = DairyListModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return dairyListModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  Future DiaryPost(context, title, sheduleId) async {
    log("${imageData.toString()}");
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.postdiary,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "TITLE": titleNameController.text,
              "DESCRIPTION": nameandQuantityofchemicalController.text,
              "SCHEDULE_ID": sheduleId,
              "FUN_PARAMETER": activeCommponetController.text,
              "PHI": phController.text,
              "DISEASE_PEST": purposeController.text,
              "EXTRA1": sheduleId,
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "PLOT_ID": plotId,
              "TASK": "Edit"
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: MyHomePage(),
        //   ),
        // );
        //  Navigator.of(context).pop();
        Utils().Tostmassage();
        Navigator.pop(context);
        dairyListApi();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  DiseasecategoreyModel? diseasecategoreyModel;

  Future deseasecategoreyListApi() async {
    log(' crop h$plotId');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 100000,
                "WORD": "",
                "GET_DATA": "Get_DiseaseCategory",
                "ID1": "",
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) async {
        diseasecategoreyModel = DiseasecategoreyModel.fromJson(value.data);
        _setLoading(false);

        await deseaseinformationListApi(
            diseasecategoreyModel?.data[0].dcId.toString());

        log('dssssssssff---${diseasecategoreyModel?.data[0].dcId}');
      });
      return diseasecategoreyModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  DiseaseInformationModel? diseaseInformationModel;
  Future deseaseinformationListApi(catid) async {
    log(' crop h$CropId');
    log(' crop h$catid');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: "http://newgrapemastersnskapi.cropmaster.in/api/FaqDisease",
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "CROP_ID": CropId,
                "CAT_ID": catid,
                "TASK": "DISEASE"
              }))
          .then((value) {
        diseaseInformationModel = DiseaseInformationModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return diseaseInformationModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  DiseaseDescreptionModel? diseaseDescreptionModel;
  Future deseaseindecriptionApi(catid) async {
    log(' crop h$CropId');
    log(' crop h$catid');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url:
                  "http://newgrapemastersnskapi.cropmaster.in/api/FaqDisease/295",
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": "1",
                "CROP_ID": CropId,
                "CAT_ID": catid,
                "TASK": "DISEASE"
              }))
          .then((value) {
        diseaseDescreptionModel = DiseaseDescreptionModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return diseaseDescreptionModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  SheduleListModel? sheduleListModel;
  Future scheduleListApi(schedule) async {
    var jasondata = {
      "START": 0,
      "END": 10000,
      "WORD": "",
      "EXTRA1": 'Current',
      "EXTRA2": "",
      "EXTRA3": "",
      "PLOT_ID": plotId,
      "CROP_ID": CropId,
      "VERIETY_ID": viriatyId,
      "SCHEDULE_DAY": "",
      "CHATANI_ID": chataniID,
      "ST_ID": StId,
      "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
      "PRUNING_TYPE": "",
      "SCHEDULE_TYPE": scheduleId,
      "IRRIGATION_SOURCE": waterspplayplot,
      "METHOD_OF_WATER": metodwater,
      "PLOT_IMPORT_EXPORT": exportlocal
    };
    log(' crop h$jasondata');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: "${ApiRoutes.plotshcdule}",
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "Current",
                "EXTRA2": "",
                "EXTRA3": "",
                "PLOT_ID": plotId,
                "CROP_ID": CropId,
                "VERIETY_ID": viriatyId,
                "SCHEDULE_DAY": "",
                "CHATANI_ID": chataniID,
                "ST_ID": StId,
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "PRUNING_TYPE": "",
                "SCHEDULE_TYPE": scheduleId,
                "IRRIGATION_SOURCE": waterspplayplot,
                "METHOD_OF_WATER": metodwater,
                "PLOT_IMPORT_EXPORT": exportlocal
              }))
          .then((value) {
        // if (sheduleListModel != null) {
        //   sheduleListModel!.DATA?.clear();
        // }
        // sheduleListModel!.DATA?.clear();
        sheduleListModel = SheduleListModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return sheduleListModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  Future oldsheduleApi(schedule) async {
    var jasondata = {
      "START": 0,
      "END": 10000,
      "WORD": "",
      "EXTRA1": 'Previous',
      "EXTRA2": "",
      "EXTRA3": "",
      "PLOT_ID": plotId,
      "CROP_ID": CropId,
      "VERIETY_ID": viriatyId,
      "SCHEDULE_DAY": "",
      "CHATANI_ID": chataniID,
      "ST_ID": StId,
      "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
      "PRUNING_TYPE": "",
      "SCHEDULE_TYPE": scheduleId,
      "IRRIGATION_SOURCE": waterspplayplot,
      "METHOD_OF_WATER": metodwater,
      "PLOT_IMPORT_EXPORT": exportlocal
    };
    log(' crop h$jasondata');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: "${ApiRoutes.plotshcdule}",
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "Previous",
                "EXTRA2": "",
                "EXTRA3": "",
                "PLOT_ID": plotId,
                "CROP_ID": CropId,
                "VERIETY_ID": viriatyId,
                "SCHEDULE_DAY": "",
                "CHATANI_ID": chataniID,
                "ST_ID": StId,
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "PRUNING_TYPE": "",
                "SCHEDULE_TYPE": scheduleId,
                "IRRIGATION_SOURCE": waterspplayplot,
                "METHOD_OF_WATER": metodwater,
                "PLOT_IMPORT_EXPORT": exportlocal
              }))
          .then((value) {
        // if (sheduleListModel != null) {
        //   sheduleListModel!.DATA?.clear();
        // }
        // sheduleListModel!.DATA?.clear();
        sheduleListModel = SheduleListModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return sheduleListModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  Future ComplitetheScheduleApi(context, shuduleid) async {
    log("${imageData.toString()}");
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: "${ApiRoutes.schedule}/1",
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "PLOT_ID": plotId,
              "SCHEDULE_ID": shuduleid,
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": ""
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: MyHomePage(),
        //   ),
        // );
        //  Navigator.of(context).pop();
        Utils().Tostmassage();
        Navigator.pop(context);
        dairyListApi();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future addDairyScheduleApi(context, title, dscription, shduleID, funparamiter,
      diseasepest, ph) async {
    log("${imageData.toString()}");
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: "${ApiRoutes.postdiary}",
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "TITLE": title,
              "DESCRIPTION": dscription,
              "SCHEDULE_ID": shduleID,
              "FUN_PARAMETER": funparamiter,
              "DISEASE_PEST": diseasepest,
              "PHI": ph,
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "PLOT_ID": plotId,
              "TASK": "ADD"
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: MyHomePage(),
        //   ),
        // );
        //  Navigator.of(context).pop();
        Utils().Tostmassage();
        Navigator.pop(context);
        dairyListApi();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  TextEditingController NirogenController = TextEditingController(text: "");
  TextEditingController calciumCarbonateController =
      TextEditingController(text: "");
  TextEditingController organicCarbonController =
      TextEditingController(text: "");
  TextEditingController phosphourusController = TextEditingController(text: "");
  TextEditingController patassiumController = TextEditingController(text: "");
  TextEditingController calciumController = TextEditingController(text: "");
  TextEditingController manganesemController = TextEditingController(text: "");
  TextEditingController SulphurController = TextEditingController(text: "");
  TextEditingController ferrousController = TextEditingController(text: "");
  TextEditingController manganesecontroller = TextEditingController(text: "");
  TextEditingController zinccontroller = TextEditingController(text: "");
  TextEditingController croppercontroller = TextEditingController(text: "");
  TextEditingController bororncontroller = TextEditingController(text: "");
  TextEditingController molybdenumcontroller = TextEditingController(text: "");
  TextEditingController bicarbonatecontroller = TextEditingController(text: "");
  TextEditingController chlorideController = TextEditingController(text: "");
  TextEditingController sodiumcontroller = TextEditingController(text: "");
  TextEditingController phcontroller = TextEditingController(text: "");
  TextEditingController EcController = TextEditingController(text: "");
  TextEditingController carbonController = TextEditingController(text: "");
  TextEditingController NitrateNitrogencontroller =
      TextEditingController(text: "");
  TextEditingController ammonicalnitrogencontroller =
      TextEditingController(text: "");
  TextEditingController coppercontroller = TextEditingController(text: "");
  TextEditingController chloridecontroller = TextEditingController(text: "");
  TextEditingController calciumcarbonatecontroller =
      TextEditingController(text: "");
  TextEditingController biCarbonatecontroller = TextEditingController(text: "");
  TextEditingController carbonatecontroller = TextEditingController(text: "");
  TextEditingController mgcacontroller = TextEditingController(text: "");
  TextEditingController sarcontroller = TextEditingController(text: "");
  String? obzervationName;

  void clearalldata() {
    selctedvalue = null;
    obzervationName = null;
    cropNameCntroller.clear();
    importanctContController.clear();
    labortaryNameCntroller.clear();
    SampleDateController.clear();
    descriptionController.clear();
    datetimeContoller.clear();
    NirogenController.clear();
    calciumCarbonateController.clear();
    organicCarbonController.clear();
    phosphourusController.clear();
    patassiumController.clear();
    calciumController.clear();
    manganesemController.clear();
    SulphurController.clear();
    ferrousController.clear();
    manganesecontroller.clear();
    zinccontroller.clear();
    croppercontroller.clear();
    bororncontroller.clear();
    molybdenumcontroller.clear();
    bicarbonatecontroller.clear();
    chlorideController.clear();
    sodiumcontroller.clear();
    phcontroller.clear();
    EcController.clear();
    carbonController.clear();
    NitrateNitrogencontroller.clear();

    ammonicalnitrogencontroller.clear();

    coppercontroller.clear();
    chloridecontroller.clear();
    calciumcarbonatecontroller.clear();

    biCarbonatecontroller.clear();
    carbonatecontroller.clear();
    mgcacontroller.clear();
    sarcontroller.clear();
  }

  void cleardata() {
    NirogenController.clear();
    calciumCarbonateController.clear();
    organicCarbonController.clear();
    phosphourusController.clear();
    patassiumController.clear();
    calciumController.clear();
    manganesemController.clear();
    SulphurController.clear();
    ferrousController.clear();
    manganesecontroller.clear();
    zinccontroller.clear();
    croppercontroller.clear();
    bororncontroller.clear();
    molybdenumcontroller.clear();
    bicarbonatecontroller.clear();
    chlorideController.clear();
    sodiumcontroller.clear();
    phcontroller.clear();
    EcController.clear();
    carbonController.clear();
    NitrateNitrogencontroller.clear();

    ammonicalnitrogencontroller.clear();

    coppercontroller.clear();
    chloridecontroller.clear();
    calciumcarbonatecontroller.clear();

    biCarbonatecontroller.clear();
    carbonatecontroller.clear();
    mgcacontroller.clear();
    sarcontroller.clear();
  }

  void validationReport(context) {
    if (selctedvalue == null) {
      Utils().validationTostmassage(txt_crop_g.tr);
    } else if (reportName == null) {
      Utils().validationTostmassage(txt_report_cat.tr);
    } else if (labortaryNameCntroller.text.isEmpty) {
      Utils().validationTostmassage(txt_lab_name.tr.tr);
    } else if (SampleDateController.text.isEmpty) {
      Utils().validationTostmassage(txt_date_of_sample.tr);
    } else if (importanctContController.text.isEmpty) {
      Utils().validationTostmassage(txt_report_observation.tr);
    } else {
      obzervationPost(context);
    }
  }

  Future obzervationPost(
    context,
  ) async {
    String distance = "${plantingDistance.text} X ${plantingDistance1.text}";
    log(" distance print ${selectedOptions}");
    Map<String, dynamic> requestData = {
      "USER_ID": AppPreference().getInt(PreferencesKey.uId),
      "PLOT_ID": plotId.toString(),
      "CROP_ID": selctedvalue.toString(),
      "SAMPLE_DATE": apidateformat,
      "RR_ID": "",
      "REPORT_ID": reportId,
      "LAB_NAME": labortaryNameCntroller.text,
      "DESCRIPTION": importanctContController.text,
      "NITROGEN": NirogenController.text,
      "PHOSFORUS": phosphourusController.text,
      "POTASIUM": patassiumController.text,
      "CALSIUM": calciumController.text,
      "SALPHUR": SulphurController.text,
      "MAGNESIUM": manganesecontroller.text,
      "FEROUS": ferrousController.text,
      "MANGNISE": ferrousController.text,
      "ZINK": zinccontroller.text,
      "BORON": bororncontroller.text,
      "MOLIBHEBAM": bororncontroller.text,
      "PH": bororncontroller.text,
      "EC": EcController.text,
      "CARBON": carbonController.text,
      "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
      "EXTRA1": apidateformat,
      "EXTRA2": "",
      "NitrateNitrogen": NitrateNitrogencontroller.text,
      "AmmonicalNitrogen": ammonicalnitrogencontroller.text,
      "Copper": coppercontroller.text,
      "Chloride": chlorideController.text,
      "Sodium": sodiumcontroller.text,
      "CalciumCarbonate": calciumCarbonateController.text,
      "OrganicCarbon": organicCarbonController.text,
      "BiCarbonate": bicarbonatecontroller.text,
      "Carbonate": carbonatecontroller.text,
      "Mgca": mgcacontroller.text,
      "SAR": sarcontroller.text,
      "EXTRA3": "",
      "TASK": "ADD",
      "REPORT_PHOTO": imageData.toString() == null ? "" : imageData.toString()
    };

    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: 'http://newgrapemastersnskapi.cropmaster.in/api/ReportMaster',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(requestData))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        NetrientManagementList();
        DialogHelper.hideLoading();

        Navigator.of(context).pop();
        ObservationReportPostApi(context);
        Utils().validationTostmassage(reportmsg.tr);
        clearalldata();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${requestData}");
      }
    });
  }

  Future ObservationReportPostApi(context) async {
    log("${imageData.toString()}");
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url:
                "http://newgrapemastersnskapi.cropmaster.in/api/ObservationCart/1",
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "CROP_ID": CropId,
              "PLOT_ID": plotId,
              "TASK": "ADD",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": ""
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();

        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: MyHomePage(),
        //   ),
        // );
        //  Navigator.of(context).pop();

        Navigator.pop(context);
        dairyListApi();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future answerchoose(context, qid, codid) async {
    log(" USER_ID:${AppPreference().getInt(PreferencesKey.uId)} , CROP_ID ${CropId}, PLOT_ID: ${plotId},");
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url:
                "http://newgrapemastersnskapi.cropmaster.in/api/ObservationCart",
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "CROP_ID": CropId,
              "COD_ID": codid,
              "Q_ID": qid,
              "QA_ID": updaesh,
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "PLOT_ID": plotId
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: MyHomePage(),
        //   ),
        // );
        //  Navigator.of(context).pop();
        Utils().Tostmassage();
        observationApiList();

        updaesh = 'null';
        Navigator.pop(context);
        dairyListApi();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  SubScriptionListModel? scriptionListModel;
  Future subcriptionListListApi() async {
    log(' crop h$plotId');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: "${ApiRoutes.getdata}",
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 100000,
                "WORD": "",
                "GET_DATA": "Get_PackageMaster",
                "ID1": CropId,
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        scriptionListModel = SubScriptionListModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return scriptionListModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  String? PakageName;

  PakageListModel? pakageListModel;
  Future pakageListApi() async {
    log(' crop h$plotId');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: "${ApiRoutes.pakagelist}",
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 100,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
                "PLOT_ID": plotId
              }))
          .then((value) {
        pakageListModel = PakageListModel.fromJson(value.data);
        _setLoading(false);
        PakageName = pakageListModel?.DATA?[0]?.PACKAGE_NAME;
        log('dssssssssff---${value.data}');
      });
      return scriptionListModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }
}

class RatingDialog extends StatefulWidget {
  RatingDialog();
  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<plotcnt>(builder: (context, ePv, child) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(12),
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Your header and close button code here

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      h10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Text(txt_erigation_source.tr,
                              style: TextStyle(
                                  color: kgreen,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400)),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.close, color: kgreen, size: 30))
                        ],
                      ),
                      h10,
                      for (String option in ePv.options)
                        Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: CheckboxListTile(
                                selectedTileColor: klime,
                                checkColor: kwhite,
                                activeColor: klime,
                                title: Text(
                                  option,
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 14),
                                ),
                                value: ePv.selectedOptions.contains(option),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value != null) {
                                      if (value) {
                                        ePv.selectedOptions.add(option);
                                      } else {
                                        ePv.option = option;
                                        ePv.selectedOptions.remove(option);
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                            Divider(
                              color: Colors.grey[800],
                              thickness: 0.75,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: LargeButton(
                      onPress: () {
                        Navigator.pop(context);

                        if (ePv.selectedOptions.isEmpty) {
                          ePv.waterScorceController.text = "";
                        } else {
                          ePv.waterScorceController.text =
                              ePv.selectedOptions.toString();
                          // Optionally, remove the square brackets
                          ePv.waterScorceController.text = ePv
                              .waterScorceController.text
                              .replaceFirst('[', '')
                              .replaceFirst(']', '');
                        }

                        print("Selected Options: ${ePv.selectedOptions}");
                      },
                      text: Text(
                        txt_submit.tr,
                        style: TextStyle(fontSize: 18, color: kwhite),
                      ),
                    ),
                  ),
                ),
                h5
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CommanCheckbox extends StatefulWidget {
  CommanCheckbox(
      {Key? key, this.text, required this.selectedOptions, required this.value})
      : super(key: key);

  final Widget? text;
  String selectedOptions;
  final String value;

  @override
  State<CommanCheckbox> createState() => _CommanCheckboxState();
}

class _CommanCheckboxState extends State<CommanCheckbox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: CheckboxListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        title: widget.text,
        value: widget.selectedOptions.contains(widget.value),
        onChanged: (bool? value) {
          setState(() {
            if (value != null) {
              if (value) {
                widget.selectedOptions += widget.value;

                print(widget.selectedOptions);
              } else {
                widget.selectedOptions =
                    widget.selectedOptions.replaceAll(widget.value, '');
              }
              List<String> selectedValues = widget.selectedOptions.split("");

              // Print the list of selected values
              log("Selected values: $selectedValues");
            }
          });
        },
      ),
    );
  }
}
