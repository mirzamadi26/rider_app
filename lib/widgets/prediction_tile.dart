import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:riders/helpers/requestHelper.dart';
import 'package:riders/model/address_model.dart';
import 'package:riders/widgets/progress_dialog.dart';
import '../../model/prediction_model.dart';
import '../provider/appdata.dart';
import '../utils/global_variables.dart';

class PredictionTile extends StatelessWidget {
  Prediction? prediction;
  PredictionTile({
    this.prediction,
    super.key,
  });

  void getPlaceDetails(String placeID, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            ProgressDialog(status: 'Please wait...'));
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$mapKey';
    var response = await RequestHelper.getRequest(url);
    Navigator.pop(context);
    if (response == 'failed') {
      return;
    }
    if (response['status'] == 'OK') {
      AddressModel thisPlace = AddressModel();
      thisPlace.placeName = response['result']['name'];
      thisPlace.placeId = placeID;
      thisPlace.latitude = response['result']['geometry']['location']['lat'];
      thisPlace.longitude = response['result']['geometry']['location']['lng'];
      Provider.of<AppData>(context, listen: false)
          .updateDestinationAddress(thisPlace);
      print(thisPlace.placeName);
      Navigator.pop(context, 'getDirection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        getPlaceDetails(prediction!.placeId!, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Row(children: [
              Icon(
                Icons.location_on_outlined,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prediction!.mainText!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      prediction?.secondaryText ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )
                  ],
                ),
              )
            ]),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
