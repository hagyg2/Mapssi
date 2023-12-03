import 'dart:math';

import 'package:get/get.dart';
import 'main.dart';

var curTemp = Get.find<WeatherJasonData>().getData()[0];
//var curTemp = 10;
var perCol = Get.find<UserDataFromServer>().getUserPerCol();

//여자
getItem(int index) {
  List result = [];
  List<String> coordi = [];
  //['캐주얼', '스트릿', '아메카지', '스포츠', '클래식', '러블리 or 댄디', '고프코어']
  switch (index) {
    case 0: // 캐주얼
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
            coordi.add("tshirts_0xFF151514/denim_0xFF4e5e70/sneakers/jacket_0xFF595959");
            coordi.add("hoodie_0xFF595959/trouser_0xFF151514/sneakers");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF323b32/sports/windshield_0xFF050d24");
            coordi.add("croptop_0xFFbcb9b9/denim_0xFF1d2a44/sneakers/jacket_0xFF3a2b22");
            coordi.add("tshirts_0xFFbcb9b9/trouser_0xFFb7b4a6/sports/cardigan_0xFF050d24");
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
            coordi.add("tshirts_0xFF151514/denim_0xFF4e5e70/sneakers/jacket_0xFF595959");
            coordi.add("hoodie_0xFF595959/trouser_0xFF151514/sneakers");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF323b32/sports/windshield_0xFF051a36");
            coordi.add("croptop_0xFFbcb9b9/denim_0xFF1d2a44/sneakers/jacket_0xFF21191b");
            coordi.add("tshirts_0xFFbcb9b9/trouser_0xFFb7b4a6/sports/cardigan_0xFF051a36");
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
            coordi.add("tshirts_0xFF151514/denim_0xFF4e5e70/sneakers/jacket_0xFF595959");
            coordi.add("hoodie_0xFF595959/trouser_0xFF151514/sneakers");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF323b32/sports/windshield_0xFF000123");
            coordi.add("croptop_0xFFbcb9b9/denim_0xFF1d2a44/sneakers/jacket_0xFF201716");
            coordi.add("tshirts_0xFFbcb9b9/trouser_0xFFb7b4a6/sports/cardigan_0xFF101421");
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
            coordi.add("tshirts_0xFF151514/denim_0xFF4e5e70/sneakers/jacket_0xFF595959");
            coordi.add("hoodie_0xFF595959/trouser_0xFF151514/sneakers");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF323b32/sports/windshield_0xFF051a36");
            coordi.add("croptop_0xFFbcb9b9/denim_0xFF1d2a44/sneakers/jacket_0xFF261e23");
            coordi.add("tshirts_0xFFbcb9b9/trouser_0xFFb7b4a6/sports/cardigan_0xFF000123");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;
      }
      break;


    case 1: // 스트릿
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
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF4e5e70/boots/jacket_0xFF413c38");
            coordi.add("hoodie_0xFF595959/denim_0xFF1d2a44/sports/jacket_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF151514/sports/cardigan_0xFF151514");
            coordi.add("sweatshirts_0xFFb7b4a6/shorts_0xFF383838/boots");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/jacket_0xFFb7b4a6");
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
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF4e5e70/boots/jacket_0xFF383838");
            coordi.add("hoodie_0xFF595959/denim_0xFF1d2a44/sports/jacket_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF151514/sports/cardigan_0xFF151514");
            coordi.add("sweatshirts_0xFF87b9c9/shorts_0xFF383838/boots");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/jacket_0xFF294f79");
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
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF4e5e70/boots/jacket_0xFF261e23");
            coordi.add("hoodie_0xFF595959/denim_0xFF1d2a44/sports/jacket_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF151514/sports/cardigan_0xFF151514");
            coordi.add("sweatshirts_0xFFb7b4a6/shorts_0xFF383838/boots");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/jacket_0xFFb7b4a6");
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
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF4e5e70/boots/jacket_0xFF2e2e2e");
            coordi.add("hoodie_0xFF595959/denim_0xFF1d2a44/sports/jacket_0xFF151514");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF151514/sports/cardigan_0xFF151514");
            coordi.add("sweatshirts_0xFF8ad8ea/shorts_0xFF383838/boots");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF1d1d1e/sports/jacket_0xFF1d366d");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;
      }
      break;


    case 2: // 아메카지
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
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF978868/sneakers/cardigan_0xFF050d24");
            coordi.add("shirts_0xFFbcb9b9/cargo_0xFF978868/sports/vest_0xFF151514");
            coordi.add("sweatshirts_0xFF0d4e08/skirt_0xFF978868/sneakers");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF323b32/sports/jacket_0xFF050d24");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF3a2b22/sports/jacket_0xFF050d24");
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
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF978868/sneakers/cardigan_0xFF051a36");
            coordi.add("shirts_0xFFbcb9b9/cargo_0xFF978868/sports/vest_0xFF151514");
            coordi.add("sweatshirts_0xFF06544a/skirt_0xFF978868/sneakers");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF323b32/sports/jacket_0xFF051a36");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF21191b/sports/jacket_0xFF050d24");
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
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF978868/sneakers/cardigan_0xFF101421");
            coordi.add("shirts_0xFFbcb9b9/cargo_0xFF978868/sports/vest_0xFF151514");
            coordi.add("sweatshirts_0xFF203513/skirt_0xFF978868/sneakers");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF323b32/sports/jacket_0xFF101421");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF201716/sports/jacket_0xFF050d24");
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
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF978868/sneakers/cardigan_0xFF000123");
            coordi.add("shirts_0xFFbcb9b9/cargo_0xFF978868/sports/vest_0xFF151514");
            coordi.add("sweatshirts_0xFF01322b/skirt_0xFF978868/sneakers");
            coordi.add("tshirts_0xFFbcb9b9/cargo_0xFF323b32/sports/jacket_0xFF000123");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF261e23/sports/jacket_0xFF050d24");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;
      }
      break;


    case 3: // 스포츠
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFa5936c/sports_0xFF323b32/sports/jumper_0xFF5BB575");
            coordi.add("tshirts_0xFFa5936c/jogger_0xFFFBB1B2/sports/field_0xFF5B6265");
            coordi.add("hoodie_0xFFa5936c/sports_0xFF3F5688/sports/jumper_0xFFbcb9b9");
            coordi.add("hoodie_0xFF2c2c2c/sports_0xFF2c2c2c/sports/field_0xFFa5936c");
            coordi.add("tshirts_0xFFa5936c/jogger_0xFF9C731B/sports/jumper_0xFFD82E17");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("hoodie_0xFFa5936c/sports_0xFF323b32/sports/jacket_0xFFFBB1B2");
            coordi.add("tshirts_0xFFa5936c/sports_0xFF5B6265/sports/windshield_0xFFE98352");
            coordi.add("sweatshirts_0xFF2c2c2c/sports_0xFFa5936c/sports/jacket_0xFFD82E17");
            coordi.add("tshirts_0xFFa5936c/sports_0xFF3F5688/sports/field_0xFFa5936c");
            coordi.add("sweatshirts_0xFFa5936c/jogger_0xFFEEF3B1/sports/jacket_0xFFEEF3B1");
          } else if (curTemp>12) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF5B6265/sports_0xFF5B6265/sports/jumper_0xFFCDDDF7");
            coordi.add("tshirts_0xFF5B6265/jogger_0xFF5B6265/sports/field_0xFFbcb9b9");
            coordi.add("hoodie_0xFF2c2c2c/sports_0xFF2c2c2c/sports/jumper_0xFFE19EB9");
            coordi.add("hoodie_0xFF2c2c2c/sports_0xFF323b32/sports/field_0xFF2c2c2c");
            coordi.add("tshirts_0xFFF4EEDD/jogger_0xFFF4EEDD/sports/jumper_0xFF456CBB");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("hoodie_0xFF5B6265/sports_0xFF5B6265/sports/jacket_0xFFE19EB9");
            coordi.add("tshirts_0xFF5B6265/sports_0xFFb7b4a6/sports/windshield_0xFFCDDDF7");
            coordi.add("sweatshirts_0xFF2c2c2c/sports_0xFF2c2c2c/sports/jacket_0xFF456CBB");
            coordi.add("tshirts_0xFFb7b4a6/sports_0xFF32353E/sports/field_0xFFBBWAD6");
            coordi.add("sweatshirts_0xFF2c2c2c/jogger_0xFF2c2c2c/sports/jacket_0xFFC4ADD9");
          } else if (curTemp>12) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFb7b4a6/sports_0xFF9C731B/sports/jumper_0xFF2c2c2c");
            coordi.add("tshirts_0xFFb7b4a6/jogger_0xFF5B6265/sports/field_0xFFDCB404");
            coordi.add("hoodie_0xFFb7b4a6/sports_0xFF3F5688/sports/jumper_0xFF4F7214");
            coordi.add("hoodie_0xFFb7b4a6/sports_0xFF323b32/sports/field_0xFFEE8050");
            coordi.add("tshirts_0xFFb7b4a6/jogger_0xFF5B6265/sports/jumper_0xFF932D1F");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("hoodie_0xFFa5936c/sports_0xFFa5936c/sports/jacket_0xFF4F7214");
            coordi.add("tshirts_0xFFa5936c/sports_0xFF5B6265/sports/windshield_0xFF932D1F");
            coordi.add("sweatshirts_0xFF2c2c2c/sports_0xFF2c2c2c/sports/jacket_0xFF9C731B");
            coordi.add("tshirts_0xFF9C731B/sports_0xFF9C731B/sports/field_0xFF323b32");
            coordi.add("sweatshirts_0xFF4F7214/jogger_0xFFF4EEDD/sports/jacket_0xFF2c2c2c");
          } else if (curTemp>12) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF2c2c2c/sports_0xFF2c2c2c/sports/jumper_0xFFb7b4a6");
            coordi.add("tshirts_0xFF2c2c2c/jogger_0xFF5B6265/sports/field_0xFF2c2c2c");
            coordi.add("hoodie_0xFF5B6265/sports_0xFF5B6265/sports/jumper_0xFF1039B5");
            coordi.add("hoodie_0xFF5B6265/sports_0xFF5B6265/sports/field_0xFF3F5688");
            coordi.add("tshirts_0xFFF4EEDD/jogger_0xFFF4EEDD/sports/jumper_0xFFDB2F45");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("hoodie_0xFFb7b4a6/sports_0xFF5B6265/sports/jacket_0xFF899DBE");
            coordi.add("tshirts_0xFF5B6265/sports_0xFF5B6265/sports/windshield_0xFF301157");
            coordi.add("sweatshirts_0xFF32353E/sports_0xFF32353E/sports/jacket_0xFF1039B5");
            coordi.add("tshirts_0xFF2c2c2c/sports_0xFFF4EEDD/sports/field_0xFF862B56");
            coordi.add("sweatshirts_0xFFbcb9b9/jogger_0xFFF4EEDD/sports/jacket_0xFF1039B5");
          } else if (curTemp>12) {

          }
          break;
      }
      break;


    case 4: // 클래식
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFb7b4a6/trouser_0xFF5B6265/sneakers/coat_0xFFFBB1B2");
            coordi.add("tshirts_0xFFb7b4a6/trouser_0xFF62BECD/boots/coat_0xFFa5936c");
            coordi.add("sweatshirts_0xFFb7b4a6/denim_0xFF899DBE/boots/jumper_0xFF5BB575");
            coordi.add("sweatshirts_0xFFF4EEDD/trouser_0xFFF4EEDD/boots/coat_0xFF2c2c2c");
            coordi.add("sweatshirts_0xFFa5936c/denim_0xFF2A314B/sneakers/coat_0xFFa5936c");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFb7b4a6/denim_0xFF3F5688/sneakers/cardigan_0xFFa5936c");
            coordi.add("tshirts_0xFFF4EEDD/trouser_0xFFF4EEDD/boots/jacket_0xFFFBB1B2");
            coordi.add("tshirts_0xFFb7b4a6/skirt_0xFFb7b4a6/sneakers/cardigan_0xFFFBB1B2");
            coordi.add("tshirts_0xFFb7b4a6/denim_0xFF5B6265/sneakers/jacket_0xFF5BB575");
            coordi.add("onepiece_0xFFb7b4a6/boots/jacket_0xFFD82E17");
          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFF4EEDD/trouser_0xFFF4EEDD/sneakers/coat_0xFFC4ADD9");
            coordi.add("tshirts_0xFFbcb9b9/trouser_0xFF2c2c2c/boots/coat_0xFFCDDDF7");
            coordi.add("sweatshirts_0xFFbcb9b9/denim_0xFF899DBE/boots/jumper_0xFFbcb9b9");
            coordi.add("sweatshirts_0xFFbcb9b9/trouser_0xFFE19EB9/boots/coat_0xFF5B6265");
            coordi.add("sweatshirts_0xFFbcb9b9/denim_0xFF5B6265/sneakers/coat_0xFFBBWAD6");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFbcb9b9/denim_0xFF32353E/sneakers/cardigan_0xFF456CBB");
            coordi.add("tshirts_0xFFb7b4a6/trouser_0xFF32353E/boots/jacket_0xFFE19EB9");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF2c2c2c/sneakers/cardigan_0xFFC4ADD9");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF899DBE/sneakers/jacket_0xFFBBWAD6");
            coordi.add("onepiece_0xFFbcb9b9/boots/jacket_0xFF32353E");
          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF2c2c2c/trouser_0xFF2c2c2c/sneakers/coat_0xFF9C731B");
            coordi.add("tshirts_0xFF2c2c2c/trouser_0xFF2c2c2c/boots/coat_0xFF4F7214");
            coordi.add("sweatshirts_0xFFb7b4a6/denim_0xFF5B6265/boots/jumper_0xFFEE8050");
            coordi.add("sweatshirts_0xFFF4EEDD/trouser_0xFFF4EEDD/boots/coat_0xFFa5936c");
            coordi.add("sweatshirts_0xFF5B6265/denim_0xFF5B6265/sneakers/coat_0xFFDCB404");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFb7b4a6/denim_0xFF32353E/sneakers/cardigan_0xFF4F7214");
            coordi.add("tshirts_0xFFF4EEDD/trouser_0xFFF4EEDD/boots/jacket_0xFF932D1F");
            coordi.add("tshirts_0xFFa5936c/skirt_0xFF2c2c2c/sneakers/cardigan_0xFF9C731B");
            coordi.add("tshirts_0xFFa5936c/denim_0xFF5B6265/sneakers/jacket_0xFF648C8C");
            coordi.add("onepiece_0xFFb7b4a6/boots/jacket_0xFFa5936c");
          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFbcb9b9/trouser_0xFF2c2c2c/sneakers/coat_0xFFbcb9b9");
            coordi.add("tshirts_0xFFbcb9b9/trouser_0xFFF4EEDD/boots/coat_0xFFDB2F45");
            coordi.add("sweatshirts_0xFFbcb9b9/denim_0xFF5B6265/boots/jumper_0xFF14546D");
            coordi.add("sweatshirts_0xFFbcb9b9/trouser_0xFF32353E/boots/coat_0xFF1039B5");
            coordi.add("sweatshirts_0xFFbcb9b9/denim_0xFF899DBE/sneakers/coat_0xFFD586A6");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFbcb9b9/denim_0xFF32353E/sneakers/cardigan_0xFF301157");
            coordi.add("tshirts_0xFFbcb9b9/trouser_0xFF2c2c2c/boots/jacket_0xFFD586A6");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF2c2c2c/sneakers/cardigan_0xFF1039B5");
            coordi.add("tshirts_0xFFbcb9b9/denim_0xFF5B6265/sneakers/jacket_0xFF862B56");
            coordi.add("onepiece_0xFFbcb9b9/boots/jacket_0xFF1039B5");
          } else if (curTemp>27) {

          }
          break;
      }
      break;


    case 5: // 러블리 or 댄디
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("onepiece_0xFFb7b4a6/boots/coat_0xFFFBB1B2");
            coordi.add("sweatshirts_0xFFFBB1B2/denim_0xFF899DBE/boots/coat_0xFF2c2c2c");
            coordi.add("tshirts_0xFFD82E17/skirt_0xFFbcb9b9/boots/coat_0xFF62BECD");
            coordi.add("sweatshirts_0xFFa5936c/denim_0xFF2A314B/boots/jacket_0xFFEEF3B1");
            coordi.add("sweatshirts_0xFFFBB1B2/skirt_0xFF899DBE/boots/coat_0xFFbcb9b9");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("onepiece_0xFFbcb9b9/boots/cardigan_0xFFa5936c");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF2c2c2c/sneakers/cardigan_0xFFE98352");
            coordi.add("tshirts_0xFFb7b4a6/skirt_0xFFb7b4a6/boots/jacket_0xFF9C731B");
            coordi.add("onepiece_0xFFb7b4a6/boots/jacket_0xFFFBB1B2");
            coordi.add("sweatshirts_0xFFEEF3B1/skirt_0xFF5B6265/sneakers");
          } else if (curTemp>12) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("onepiece_0xFFbcb9b9/boots/coat_0xFFE1729D");
            coordi.add("sweatshirts_0xFFC4ADD9/denim_0xFF3F5688/boots/coat_0xFFb7b4a6");
            coordi.add("tshirts_0xFFb7b4a6/skirt_0xFFb7b4a6/boots/coat_0xFFC4ADD9");
            coordi.add("sweatshirts_0xFFb7b4a6/denim_0xFF5B6265/boots/jacket_0xFFCDDDF7");
            coordi.add("sweatshirts_0xFFb7b4a6/skirt_0xFF2c2c2c/boots/coat_0xFFBBWAD6");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("onepiece_0xFFbcb9b9/boots/cardigan_0xFFC4ADD9");
            coordi.add("tshirts_0xFF2c2c2c/skirt_0xFFb7b4a6/sneakers/cardigan_0xFF456CBB");
            coordi.add("tshirts_0xFF2c2c2c/skirt_0xFFE1729D/boots/jacket_0xFF2c2c2c");
            coordi.add("onepiece_0xFFbcb9b9/boots/jacket_0xFF2c2c2c");
            coordi.add("sweatshirts_0xFFE19EB9/skirt_0xFFbcb9b9/sneakers");
          }  else if (curTemp>12) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("onepiece_0xFFa5936c/boots/coat_0xFF9C731B");
            coordi.add("sweatshirts_0xFFa5936c/denim_0xFF32353E/boots/coat_0xFFDCB404");
            coordi.add("tshirts_0xFFb7b4a6/skirt_0xFF932D1F/boots/coat_0xFFa5936c");
            coordi.add("sweatshirts_0xFFa5936c/denim_0xFF5B6265/boots/jacket_0xFF4F7214");
            coordi.add("sweatshirts_0xFFa5936c/skirt_0xFF2c2c2c/boots/coat_0xFF648C8C");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("onepiece_0xFFb7b4a6/boots/cardigan_0xFF648C8C");
            coordi.add("tshirts_0xFFa5936c/skirt_0xFF2c2c2c/sneakers/cardigan_0xFF9C731B");
            coordi.add("tshirts_0xFFb7b4a6/skirt_0xFFb7b4a6/boots/jacket_0xFFEE8050");
            coordi.add("onepiece_0xFF2c2c2c/boots/jacket_0xFF932D1F");
            coordi.add("sweatshirts_0xFFa5936c/skirt_0xFF323b32/sneakers");
          } else if (curTemp>12) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("onepiece_0xFFb7b4a6/boots/coat_0xFF14546D");
            coordi.add("sweatshirts_0xFF14546D/denim_0xFF5B6265/boots/coat_0xFFD586A6");
            coordi.add("tshirts_0xFF2c2c2c/skirt_0xFF2c2c2c/boots/coat_0xFFb7b4a6");
            coordi.add("sweatshirts_0xFFb7b4a6/denim_0xFF32353E/boots/jacket_0xFF301157");
            coordi.add("sweatshirts_0xFFbcb9b9/skirt_0xFFbcb9b9/boots/coat_0xFF2c2c2c");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("onepiece_0xFFbcb9b9/boots/cardigan_0xFF301157");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF862B56/sneakers/cardigan_0xFF5B6265");
            coordi.add("tshirts_0xFFbcb9b9/skirt_0xFF2A314B/boots/jacket_0xFF1039B5");
            coordi.add("onepiece_0xFFbcb9b9/boots/jacket_0xFFD586A6");
            coordi.add("sweatshirts_0xFF14546D/skirt_0xFFbcb9b9/sneakers");
          } else if (curTemp>12) {

          }
          break;
      }
      break;


    case 6: // 고프코어
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("hoodie_0xFFa5936c/denim_0xFF5B6265/sports/jumper_0xFF5BB575");
            coordi.add("hoodie_0xFFb7b4a6/jogger_0xFF323b32/sports/field_0xFFa5936c");
            coordi.add("sweatshirts_0xFFb7b4a6/jogger_0xFFD82E17/sports/jumper_0xFF5B6265");
            coordi.add("sweatshirts_0xFFF4EEDD/sports_0xFFFBB1B2/sports/jumper_0xFFF4EEDD");
            coordi.add("sweatshirts_0xFF2c2c2c/skirt_0xFF323b32/sports/field_0xFFb7b4a6");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFa5936c/cargo_0xFF323b32/sports/windshield_0xFF5B6265");
            coordi.add("sweatshirts_0xFF2c2c2c/jogger_0xFFa5936c/sports/windshield_0xFFE98352");
            coordi.add("sweatshirts_0xFFb7b4a6/sports_0xFFFBB1B2/sports/windshield_0xFF5B6265");
            coordi.add("shirts_0xFFa5936c/denim_0xFF32353E/sneakers/jacket_0xFFb7b4a6");
            coordi.add("tshirts_0xFF2c2c2c/skirt_0xFF323b32/sneakers/jacket_0xFFb7b4a6");
          } else if (curTemp>12) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("hoodie_0xFFa5936c/denim_0xFFa5936c/sports/jumper_0xFFE19EB9");
            coordi.add("hoodie_0xFFa5936c/jogger_0xFF323b32/sports/field_0xFF5B6265");
            coordi.add("sweatshirts_0xFFF4EEDD/jogger_0xFFF4EEDD/sports/jumper_0xFFBBWAD6");
            coordi.add("sweatshirts_0xFFb7b4a6/sports_0xFFE19EB9/sports/jumper_0xFF2c2c2c");
            coordi.add("sweatshirts_0xFFb7b4a6/skirt_0xFF5B6265/sports/field_0xFFC4ADD9");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFb7b4a6/cargo_0xFF323b32/sports/windshield_0xFFb7b4a6");
            coordi.add("sweatshirts_0xFFb7b4a6/jogger_0xFF323b32/sports/windshield_0xFF5B6265");
            coordi.add("sweatshirts_0xFFa5936c/sports_0xFFa5936c/sports/windshield_0xFFC4ADD9");
            coordi.add("shirts_0xFF456CBB/denim_0xFF3F5688/sneakers/jacket_0xFFE1729D");
            coordi.add("tshirts_0xFFb7b4a6/skirt_0xFF32353E/sneakers/jacket_0xFFCDDDF7");
          } else if (curTemp>12) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("hoodie_0xFFa5936c/denim_0xFF648C8C/sports/jumper_0xFFa5936c");
            coordi.add("hoodie_0xFFa5936c/jogger_0xFF932D1F/sports/field_0xFFa5936c");
            coordi.add("sweatshirts_0xFFa5936c/jogger_0xFF4F7214/sports/jumper_0xFF5B6265");
            coordi.add("sweatshirts_0xFFa5936c/sports_0xFF9C731B/sports/jumper_0xFF323b32");
            coordi.add("sweatshirts_0xFF2c2c2c/skirt_0xFF323b32/sports/field_0xFF2c2c2c");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFa5936c/cargo_0xFF323b32/sports/windshield_0xFF932D1F");
            coordi.add("sweatshirts_0xFFa5936c/jogger_0xFF9C731B/sports/windshield_0xFFa5936c");
            coordi.add("sweatshirts_0xFFa5936c/sports_0xFF5B6265/sports/windshield_0xFF648C8C");
            coordi.add("shirts_0xFF2c2c2c/denim_0xFF2c2c2c/sneakers/jacket_0xFF9C731B");
            coordi.add("tshirts_0xFFa5936c/skirt_0xFF9C731B/sneakers/jacket_0xFF323b32");
          } else if (curTemp>12) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("hoodie_0xFFb7b4a6/denim_0xFF5B6265/sports/jumper_0xFF14546D");
            coordi.add("hoodie_0xFFb7b4a6/jogger_0xFFD586A6/sports/field_0xFFb7b4a6");
            coordi.add("sweatshirts_0xFFb7b4a6/jogger_0xFF5B6265/sports/jumper_0xFFDB2F45");
            coordi.add("sweatshirts_0xFFF4EEDD/sports_0xFFF4EEDD/sports/jumper_0xFF1039B5");
            coordi.add("sweatshirts_0xFF2c2c2c/skirt_0xFF323b32/sports/field_0xFF2c2c2c");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFb7b4a6/cargo_0xFF1039B5/sports/windshield_0xFF5B6265");
            coordi.add("sweatshirts_0xFFb7b4a6/jogger_0xFFD586A6/sports/windshield_0xFFb7b4a6");
            coordi.add("sweatshirts_0xFFb7b4a6/sports_0xFFF4EEDD/sports/windshield_0xFF1039B5");
            coordi.add("shirts_0xFFb7b4a6/denim_0xFF5B6265/sneakers/jacket_0xFF862B56");
            coordi.add("tshirts_0xFFb7b4a6/skirt_0xFF323b32/sneakers/jacket_0xFF2c2c2c");
          } else if (curTemp>12) {

          }
          break;
      }
      break;
  }

  //print(coordi);
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