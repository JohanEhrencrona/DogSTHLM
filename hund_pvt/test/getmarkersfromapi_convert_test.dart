import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:hund_pvt/Services/getmarkersfromapi.dart';

void main() {
  test('Test to ensure that the convert of points are accurate', () async {
    //Using opendatas own method to convert.
    http.Response response = await http.get(Uri.parse(
        'https://openstreetws.stockholm.se/LvWS-3.0/Lv.svc/json/TransformGeometry?apikey=9f0bd873-30d2-40ad-99f3-7a32f115717f&wkt=POINT(140909.798+6582563.2503)&fromSrid=3011&toSrid=900913'));

    String openDataConvertCoordinate = response.body.toString();

    String openDataConvertlongitude =
        openDataConvertCoordinate.substring(8, 18);
    String openDataConvertlatitude =
        openDataConvertCoordinate.substring(19, 29);

    //own method
    await getTrashCan();
    String ownConversionLatitude = trashCanList.first.wgs84.yLatitude
        .toStringAsFixed(
            7); //because of how many decimals open datas own method returns.
    String ownConversionLongitude =
        trashCanList.first.wgs84.xLongitude.toStringAsFixed(7);
    expect(ownConversionLatitude, openDataConvertlatitude);
    expect(ownConversionLongitude, openDataConvertlongitude);
  });
}
