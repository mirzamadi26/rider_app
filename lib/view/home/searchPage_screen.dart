import 'package:flutter/material.dart';
import 'package:riders/helpers/requestHelper.dart';

import '../../model/prediction_model.dart';
import '../../provider/appdata.dart';
import '../../utils/global_variables.dart';
import '../../widgets/prediction_tile.dart';
import '../../widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  TextEditingController pickUpController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  var focusDestination = FocusNode();
  List<Prediction> destinationPredictionList = [];
  bool focused = false;
  void setFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusDestination);
      focused = true;
    }
  }

  void searchPlace(String placeName) async {
    if (placeName.length > 1) {
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${placeName}&key=${mapKey}';
      var response = await RequestHelper.getRequest(url);
      if (response == 'failed') {
        return;
      }

      if (response['status'] == 'OK') {
        var predictionJson = response['predictions'];
        var precictionList = (predictionJson as List)
            .map((e) => Prediction.fromJson(e))
            .toList();
        setState(() {
          destinationPredictionList = precictionList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setFocus();
    String address =
        Provider.of<AppData>(context).pickUpAddress?.placeName ?? "";
    pickUpController.text = address;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: h / 3,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 40, right: 20, bottom: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back)),
                        Center(
                          child: Text("Set Destination",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/pick.png', height: 16, width: 16),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            controllerName: pickUpController,
                            klabelText: "Pick up Location",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/destination.png',
                            height: 16, width: 16),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFieldWidget(
                              onChanged: (value) {
                                searchPlace(value);
                              },
                              focus: focusDestination,
                              controllerName: destinationController,
                              klabelText: "Where to?"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            (destinationPredictionList.length > 0)
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return PredictionTile(
                          prediction: destinationPredictionList[index],
                        );
                      },
                      separatorBuilder: (context, int index) {
                        return Divider(
                          thickness: 3,
                        );
                      },
                      itemCount: destinationPredictionList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
