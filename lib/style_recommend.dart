import 'dart:math';

import 'package:get/get.dart';
import 'main.dart';

var curTemp = Get.find<WeatherJasonData>().getData()[0];
var perCol = Get.find<UserDataFromServer>().getUserPerCol();

getItem(int index) {
  List result = [];
  List<String> coordi = [];
  //['캐주얼', '스트릿', '아메카지', '스포츠', '클래식', '러블리 or 댄디', '고프코어']
  switch (index) {
    case 1: // 캐주얼
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFb7b4a6/cargo_0xFF323b32/sneakers/jumper_0xFFbcb9b9");
            coordi.add("tshirts_0xFFa5936c/denim_0xFF1d1d1e/sports/coat_0xFFb7b4a6");
            coordi.add("tshirts_0xFFbcb9b9/sports_0xFF050d24/sports/jumper_0xFFb7b4a6");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d2a44/sneakers/jumper_0xFF866360");
            coordi.add("sweatshirts_0xFFb7b4a6/trouser_0xFFbcb9b9/sports/coat_0xFF151514");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF151514/boots/jacket_0xFF151514");
            coordi.add("sweatshirts_0xFFb7b4a6/trouser_0xFFc4c4c4/sneakers/jacket_0xFF3a2b22");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/cardigan_0xFFa5936c");
            coordi.add("hoodie_0xFFbcb9b9/skirt_0xFFc4c4c4/sneakers/jacket_0xFF050d24");
            coordi.add("sweatshirts_0xFFb7b4a6/skirt_0xFF3a2b22/sports/jacket_0xFFa5936c");
          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFb7b4a6/cargo_0xFF323b32/sneakers/jumper_0xFFbcb9b9");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/coat_0xFF383838");
            coordi.add("tshirts_0xFFbcb9b9/sports_0xFF051a36/sports/jumper_0xFF06544a");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d2a44/sneakers/jumper_0xFF87b9c9");
            coordi.add("sweatshirts_0xFFb7b4a6/trouser_0xFFbcb9b9/sports/coat_0xFF151514");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF151514/boots/jacket_0xFF151514");
            coordi.add("sweatshirts_0xFFb7b4a6/trouser_0xFFc4c4c4/sneakers/jacket_0xFF051a36");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/cardigan_0xFF595959");
            coordi.add("hoodie_0xFFbcb9b9/skirt_0xFFc4c4c4/sneakers/jacket_0xFF101421");
            coordi.add("sweatshirts_0xFFb7b4a6/skirt_0xFF21191b/sports/jacket_0xFFa5936c");
          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFb7b4a6/cargo_0xFF323b32/sneakers/jumper_0xFFbcb9b9");
            coordi.add("tshirts_0xFFb7b4a6/denim_0xFF1d1d1e/sports/coat_0xFF201716");
            coordi.add("tshirts_0xFFbcb9b9/sports_0xFF051a36/sports/jumper_0xFFb7b4a6");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d2a44/sneakers/jumper_0xFFbc7baa");
            coordi.add("sweatshirts_0xFFb7b4a6/trouser_0xFFbcb9b9/sports/coat_0xFF151514");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF151514/boots/jacket_0xFF151514");
            coordi.add("sweatshirts_0xFFb7b4a6/trouser_0xFFc4c4c4/sneakers/jacket_0xFFa5936c");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/cardigan_0xFFa5936c");
            coordi.add("hoodie_0xFFbcb9b9/skirt_0xFFc4c4c4/sneakers/jacket_0xFF000123");
            coordi.add("sweatshirts_0xFFb7b4a6/skirt_0xFF201716/sports/jacket_0xFFa5936c");
          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFb7b4a6/cargo_0xFF323b32/sneakers/jumper_0xFFbcb9b9");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/coat_0xFF383838");
            coordi.add("tshirts_0xFFbcb9b9/sports_0xFF051a36/sports/jumper_0xFF01322b");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d2a44/sneakers/jumper_0xFF8ad8ea");
            coordi.add("sweatshirts_0xFFb7b4a6/trouser_0xFFbcb9b9/sports/coat_0xFF151514");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF151514/boots/jacket_0xFF151514");
            coordi.add("sweatshirts_0xFFb7b4a6/trouser_0xFFc4c4c4/sneakers/jacket_0xFF000123");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/cardigan_0xFF01322b");
            coordi.add("hoodie_0xFFbcb9b9/skirt_0xFFc4c4c4/sneakers/jacket_0xFF101421");
            coordi.add("sweatshirts_0xFFb7b4a6/skirt_0xFF261e23/sports/jacket_0xFFa5936c");
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
            coordi.add("tshirts_0xFF151514/cargo_0xFF383838/sports/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFFab80c6/sports_0xFFab80c6/sports/jumper_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF1d1d1e/boots/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFF0d4e08/trouser_0xFF383838/sneakers/jumper_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFFa5936c/sports/jumper_0xFF151514");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF383838/boots/jacket_0xFF3a2b22");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF151514/sports/cardigan_0xFF151514");
            coordi.add("tshirts_0xFFb7b4a6/trouser_0xFFbcb9b9/sports/coat_0xFF050d24");
            coordi.add("hoodie_0xFF6e6e6e/sports_0xFF6e6e6e/sports/field_0xFF323b32");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF1d1d1e/boots/jacket_0xFF151514");
          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF151514/cargo_0xFF383838/sports/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFF383838/sports_0xFF383838/sports/jumper_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF1d1d1e/boots/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFF06544a/trouser_0xFF383838/sneakers/jumper_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF323b32/sports/jumper_0xFF151514");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF383838/boots/jacket_0xFF21191b");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF151514/sports/cardigan_0xFF151514");
            coordi.add("tshirts_0xFFb7b4a6/trouser_0xFFbcb9b9/sports/coat_0xFF051a36");
            coordi.add("hoodie_0xFF6e6e6e/sports_0xFF6e6e6e/sports/field_0xFF323b32");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF1d1d1e/boots/jacket_0xFF151514");
          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF151514/cargo_0xFF383838/sports/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFF351b32/sports_0xFF351b32/sports/jumper_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF1d1d1e/boots/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFF203513/trouser_0xFF383838/sneakers/jumper_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFFa5936c/sports/jumper_0xFF151514");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF383838/boots/jacket_0xFF201716");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF151514/sports/cardigan_0xFF151514");
            coordi.add("tshirts_0xFFb7b4a6/trouser_0xFFbcb9b9/sports/coat_0xFF101421");
            coordi.add("hoodie_0xFF6e6e6e/sports_0xFF6e6e6e/sports/field_0xFF323b32");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF1d1d1e/boots/jacket_0xFF151514");
          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF151514/cargo_0xFF383838/sports/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFF3a0a3e/sports_0xFF3a0a3e/sports/jumper_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF1d1d1e/boots/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFF01322b/trouser_0xFF383838/sneakers/jumper_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF323b32/sports/jumper_0xFF151514");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF383838/boots/jacket_0xFF261e23");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF151514/sports/cardigan_0xFF151514");
            coordi.add("tshirts_0xFFb7b4a6/trouser_0xFFbcb9b9/sports/coat_0xFF000123");
            coordi.add("hoodie_0xFF6e6e6e/sports_0xFF6e6e6e/sports/field_0xFF323b32");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF1d1d1e/boots/jacket_0xFF151514");
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
            coordi.add("sweatshirts_0xFFbcb9b9/cargo_0xFFbeb6a9/sneakers/jacket_0xFF3a2b22");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF978868/sneakers/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFFb7b4a6/cargo_0xFF978868/sports/jumper_0xFF323b32");
            coordi.add("sweatshirts_0xFF151514/skirt_0xFF3a2b22/boots/jumper_0xFFb7b4a6");
            coordi.add("sweatshirts_0xFFb7b4a6/skirt_0xFF1d2a44/sneakers/field_0xFF323b32");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFbcb9b9/skirt_0xFF151514/sneakers/jumper_0xFFa5936c");
            coordi.add("sweatshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/field_0xFF323b32");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF413c38/sneakers/cardigan_0xFFb7b4a6");
            coordi.add("sweatshirts_0xFFb7b4a6/denim_0xFF1d2a44/sports/jacket_0xFF3a2b22");
            coordi.add("tshirts_0xFF323b32/skirt_0xFF1d1d1e/sports/jumper_0xFF151514");
          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("sweatshirts_0xFFbcb9b9/cargo_0xFFbeb6a9/sneakers/jacket_0xFF21191b");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF383838/sneakers/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFF323b32/cargo_0xFF978868/sports/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFF151514/skirt_0xFF21191b/boots/jumper_0xFF757575");
            coordi.add("sweatshirts_0xFFb7b4a6/skirt_0xFF1d2a44/sneakers/field_0xFF323b32");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFbcb9b9/skirt_0xFF151514/sneakers/jumper_0xFFa5936c");
            coordi.add("sweatshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/field_0xFF323b32");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF383838/sneakers/cardigan_0xFFb7b4a6");
            coordi.add("sweatshirts_0xFFb7b4a6/denim_0xFF1d2a44/sports/jacket_0xFF21191b");
            coordi.add("tshirts_0xFF323b32/skirt_0xFF1d1d1e/sports/jumper_0xFF151514");
          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("sweatshirts_0xFFbcb9b9/cargo_0xFFbeb6a9/sneakers/jacket_0xFF201716");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF413c38/sneakers/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFFb7b4a6/cargo_0xFF978868/sports/jumper_0xFF323b32");
            coordi.add("sweatshirts_0xFF151514/skirt_0xFF201716/boots/jumper_0xFFb7b4a6");
            coordi.add("sweatshirts_0xFFb7b4a6/skirt_0xFF1d2a44/sneakers/field_0xFF323b32");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFbcb9b9/skirt_0xFF151514/sneakers/jumper_0xFFa5936c");
            coordi.add("sweatshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/field_0xFF323b32");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF201716/sneakers/cardigan_0xFFb7b4a6");
            coordi.add("sweatshirts_0xFFb7b4a6/denim_0xFF1d2a44/sports/jacket_0xFF201716");
            coordi.add("tshirts_0xFF323b32/skirt_0xFF1d1d1e/sports/jumper_0xFF151514");
          } else if (curTemp>11 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("sweatshirts_0xFFbcb9b9/cargo_0xFFbeb6a9/sneakers/jacket_0xFF261e23");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF383838/sneakers/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFF323b32/cargo_0xFF978868/sports/jumper_0xFF151514");
            coordi.add("sweatshirts_0xFF151514/skirt_0xFF261e23/boots/jumper_0xFF757575");
            coordi.add("sweatshirts_0xFFb7b4a6/skirt_0xFF1d2a44/sneakers/field_0xFF323b32");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFbcb9b9/skirt_0xFF151514/sneakers/jumper_0xFFa5936c");
            coordi.add("sweatshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/field_0xFF323b32");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF383838/sneakers/cardigan_0xFFb7b4a6");
            coordi.add("sweatshirts_0xFFb7b4a6/denim_0xFF1d2a44/sports/jacket_0xFF21191b");
            coordi.add(" tshirts_0xFF323b32/skirt_0xFF1d1d1e/sports/jumper_0xFF151514");
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
  //coordi = "hoodie_0x00000000/denim_0x00000000/sports_0x00000000";
  var random = Random();
  String randomcoordi = "";
  randomcoordi = coordi[random.nextInt(coordi.length)];
  var temp = randomcoordi.split("/").toList();
  var top = temp[0].split("_").toList();
  var bot = temp[1].split("_").toList();
  var shoe = temp[2];
  var out = ["없음","0x00000000"];
  if (temp.length>3) {
    out = temp[3].split("_").toList();
  }
  result = [top, bot, shoe, out];
  return result;
}