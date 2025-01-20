import 'package:evently_app/custom_widgets/custom_elevated_button.dart';
import 'package:evently_app/custom_widgets/custom_text_field.dart';
import 'package:evently_app/firebase_utils/firebase_utils.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/tabs/home_tab/add_event/custom_row_date_time.dart';
import 'package:evently_app/tabs/home_tab/tab_event_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = "add_event";

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  String? errorDate;
  String? errorTime;
  var titleController = TextEditingController(); //save title
  var descriptionController = TextEditingController(); // save description
  String selectedImage = "";
  String selectedEvent = "Sport";
  DateTime? selectedDate; // save Date
  String formatedDate = "";
  TimeOfDay? selectedTime; //Save Time
  String formatedTime = "";
  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    List<String> eventNamesList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    List<String> imageSelectedNameList = [
      AssetsManager.sport,
      AssetsManager.birthday,
      AssetsManager.meeting,
      AssetsManager.gaming,
      AssetsManager.workshop,
      AssetsManager.bookClub,
      AssetsManager.exhibition,
      AssetsManager.holiday1,
      AssetsManager.eating,
    ];
    // Map<String, String> mapEventList = {
    //   AppLocalizations.of(context)!.sport: AssetsManager.sport,
    //   AppLocalizations.of(context)!.birthday: AssetsManager.birthday,
    //   AppLocalizations.of(context)!.meeting: AssetsManager.meeting,
    //   AppLocalizations.of(context)!.gaming: AssetsManager.gaming,
    //   AppLocalizations.of(context)!.workshop: AssetsManager.workshop,
    //   AppLocalizations.of(context)!.book_club: AssetsManager.bookClub,
    //   AppLocalizations.of(context)!.exhibition: AssetsManager.exhibition,
    //   AppLocalizations.of(context)!.holiday: AssetsManager.holiday1,
    //   AppLocalizations.of(context)!.eating: AssetsManager.eating,
    // };
    selectedImage = imageSelectedNameList[selectedIndex];
    selectedEvent = eventNamesList[selectedIndex];
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Text(AppLocalizations.of(context)!.add_event,
          style: AppStyles.medium20Primary,),
        centerTitle: true,
        iconTheme: IconThemeData(
            color: AppColors.primaryLight),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * .03,
            vertical: height * .01),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width * .9285,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16)
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  selectedImage,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: height * .02),
                  height: height * .05,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {

                            });
                          },
                          child: TabEventWidget(
                            borderColor: AppColors.primaryLight,
                            backgroundColor: AppColors.primaryLight,
                            textSelectedStyle: AppStyles.medium16White,
                            textUnSelectedStyle: AppStyles.medium16Primary,
                            eventName: eventNamesList[index],
                            isSelected: selectedIndex == index,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: width * .02,);
                      },
                      itemCount: eventNamesList.length)
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.title,
                      style: AppStyles.medium16Black,),
                    SizedBox(height: height * .017,),
                    CustomTextField(
                      controller: titleController,
                      hintStyle: AppStyles.medium16Grey,
                      hintText: AppLocalizations.of(context)!.event_title,
                      prefixIcon: Icon(Icons.edit_note_rounded),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_a_title;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * .017,),
                    Text(AppLocalizations.of(context)!.description,
                      style: AppStyles.medium16Black,),
                    SizedBox(height: height * .017,),
                    CustomTextField(
                      controller: descriptionController,
                      maxLines: 4,
                      hintStyle: AppStyles.medium16Grey,
                      hintText: AppLocalizations.of(context)!.event_description,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_a_description;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * .017,),
                    CustomRowDateTime(
                      onPressed: chooseDate,
                      icon: Icon(Icons.calendar_month_outlined),
                      text: AppLocalizations.of(context)!.event_date,
                      textButton: selectedDate == null
                          ? AppLocalizations.of(context)!.choose_date
                            : DateFormat("dd//MM/yyyy").format(selectedDate!)),
                    errorDate == null ? SizedBox() : Text(
                      "$errorDate", style: AppStyles.medium16Red,),
                    CustomRowDateTime(
                        onPressed: chooseTime,
                        icon: Icon(Icons.watch_later_outlined),
                        text: AppLocalizations.of(context)!.event_time,
                        textButton: selectedTime == null
                            ? AppLocalizations.of(context)!.choose_time
                            : formatedTime),
                    errorDate == null ? SizedBox() : Text(
                      "$errorTime", style: AppStyles.medium16Red,),
                    Text(AppLocalizations.of(context)!.location,
                      style: AppStyles.medium16Black,),
                    SizedBox(height: height * .007,),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: height * .008,
                          horizontal: width * .017
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: AppColors.primaryLight
                          )
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * .032,
                                vertical: height * .017
                            ),
                            decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Image.asset(AssetsManager.gpsIcon),
                          ),
                          SizedBox(width: width * .02,),
                          Text(AppLocalizations.of(context)!
                              .choose_event_location,
                            style: AppStyles.medium16Primary,),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_right, color: AppColors
                              .primaryLight,)
                        ],
                      ),
                    ),
                    SizedBox(height: height * .017,),
                    CustomElevatedButton(
                        textStyle: AppStyles.medium20White,
                        text: AppLocalizations.of(context)!.add_event,
                        onTap: () {
                          addEvent();
                        })
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void addEvent() async {
    errorDate = null;
    errorTime = null;
    if (formKey.currentState?.validate() == true) {
      if (selectedDate == null) {
        errorDate = AppLocalizations.of(context)!.please_select_a_date;
      }
      if (selectedTime == null) {
        errorTime = AppLocalizations.of(context)!.please_select_a_time;
      }
      setState(() {

      });
      if (errorDate != null || errorTime != null) {
        return;
      }
    } else {
      return;
    }
    setState(() {
      return;
    });

    //todo: add event to firebase
    Event event = Event(
        title: titleController.text,
        description: descriptionController.text,
        image: selectedImage,
        eventName: selectedEvent,
        dateTime: selectedDate!,
        time: formatedTime);
    await FirebaseUtils.addEventToFireStore(event)
        .timeout(Duration(milliseconds: 500), onTimeout: () {
      //todo: refresh event list to make sure they all will appear in the home screen
      eventListProvider.getAllEvents();
      showSuccessToast();
      Navigator.pop(context);
    });
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chooseDate;
    formatedDate = DateFormat("dd//MM/yyyy").format(selectedDate!);
    setState(() {

    });
  }

  void chooseTime() async {
    var chooseTime =
        await showTimePicker(context: context,
        initialTime: TimeOfDay.now());
    selectedTime = chooseTime;
    formatedTime = selectedTime!.format(context);
    setState(() {

    });
  }

  void showSuccessToast() {
    Fluttertoast.showToast(
      msg: "Added event successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColors.green,
      textColor: Colors.white,
      fontSize: 16.0,
      webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
      webPosition: "center",
      timeInSecForIosWeb: 2,
    );
  }
}
