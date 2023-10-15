import 'package:get/get.dart';
import 'main.dart';

var curTemp = Get.find<WeatherJasonData>().getData()[0];
var perCol = Get.find<UserDataFromServer>().getUserPerCol();

getItem(int index) {
  List result = [];
  String coordi = "";
  //['캐주얼', '스트릿', '아메카지', '스포츠', '클래식', '러블리 or 댄디', '고프코어']
  switch (index) {
    case 1: // 캐주얼
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;
      }
      break;


    case 2: // 스트릿
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;
      }
      break;


    case 3: // 아메카지
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;
      }
      break;


    case 4: // 스포츠
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;
      }
      break;


    case 5: // 클래식
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;
      }
      break;


    case 6: // 러블리 or 댄디
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;
      }
      break;


    case 7: // 고프코어
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {

          } else if (curTemp>4 && curTemp<=11) {

          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;
      }
      break;
  }
  coordi = "hoodie_0x00000000/denim_0x00000000/sports_0x00000000";
  var temp = coordi.split("/").toList();
  var top = temp[0].split("_").toList();
  var bot = temp[1].split("_").toList();
  var shoe = temp[2].split("_").toList();
  var out = ["없음","0x00000000"];
  if (temp.length>3) {
    out = temp[3].split("_").toList();
  }
  result = [top, bot, shoe, out];
  return result;
}