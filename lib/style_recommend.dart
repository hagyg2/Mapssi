import 'dart:math';

import 'package:get/get.dart';
import 'main.dart';

var curTemp = Get.find<WeatherJasonData>().getData()[0];
var perCol = Get.find<UserDataFromServer>().getUserPerCol();

//남자
getItemMale(int index) {
  List result = [];
  List<String> coordi = [];
  //['캐주얼', '스트릿', '아메카지', '스포츠', '클래식', '고프코어']
  switch (index) {
    case 0: // 캐주얼
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF272727/cotton_0xFFebebeb/sports/coat_0xFF2c3755");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sports/jumper_0xFF2c3755");
            coordi.add("tshirts_0xFF2c3755/cotton_0xFFd2c19b/sports/coat_0xFF272727");
            coordi.add("tshirts_0xFF272727/sports_0xFF5e5e5e/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFF3ec04e/cargo_0xFF272727/sports/jumper_0xFFebebeb");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF727272/denim_0xFFb0c3d0/sneakers/filed_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF7c6375/sports/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFFebebeb/sneakers/cardigan_0xFF966f5b");
            coordi.add("tshirts_0xFF2c3755/cotton_0xFF566556/sports/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFF272727/cotton_0xFF5e5e5e/sports/jacket_0xFFebebeb");
          } else if (curTemp>14 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF272727/cotton_0xFFebebeb/sports/coat_0xFF1e2a4a");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sports/jumper_0xFF1e2a4a");
            coordi.add("tshirts_0xFF1e2a4a/cotton_0xFFd2c19b/sports/coat_0xFF272727");
            coordi.add("tshirts_0xFF272727/sports_0xFF5e5e5e/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFF79b4ad/cargo_0xFF272727/sports/jumper_0xFFebebeb");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF6d6d6d/denim_0xFFb0c3d0/sneakers/filed_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF7c6375/sports/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFFebebeb/sneakers/cardigan_0xFF8aa0ce");
            coordi.add("tshirts_0xFF1e2a4a/cotton_0xFF566556/sports/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFF272727/cotton_0xFF5e5e5e/sports/jacket_0xFFebebeb");
          } else if (curTemp>14 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF272727/cotton_0xFFebebeb/sports/coat_0xFF272f5d");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sports/jumper_0xFF272f5d");
            coordi.add("tshirts_0xFF272f5d/cotton_0xFFd2c19b/sports/coat_0xFF272727");
            coordi.add("tshirts_0xFF272727/sports_0xFF5e5e5e/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFF4b570b/cargo_0xFF272727/sports/jumper_0xFFebebeb");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF727272/denim_0xFFb0c3d0/sneakers/filed_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF7c6375/sports/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFFebebeb/sneakers/cardigan_0xFF6e4942");
            coordi.add("tshirts_0xFF272f5d/cotton_0xFF566556/sports/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFF272727/cotton_0xFF5e5e5e/sports/jacket_0xFFebebeb");
          } else if (curTemp>14 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF272727/cotton_0xFFebebeb/sports/coat_0xFF1e2a4a");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sports/jumper_0xFF1e2a4a");
            coordi.add("tshirts_0xFF1e2a4a/cotton_0xFFd2c19b/sports/coat_0xFF272727");
            coordi.add("tshirts_0xFF272727/sports_0xFF5e5e5e/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFF0b655a/cargo_0xFF272727/sports/jumper_0xFFebebeb");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF3b3b3b/denim_0xFFb0c3d0/sneakers/filed_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF7c6375/sports/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFFebebeb/sneakers/cardigan_0xFF1810c8");
            coordi.add("tshirts_0xFF1e2a4a/cotton_0xFF566556/sports/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFF272727/cotton_0xFF5e5e5e/sports/jacket_0xFFebebeb");
          } else if (curTemp>14 && curTemp<=16) {

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
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/jumper_0xFF566556");
            coordi.add("tshirts_0xFF272727/cargo_0xFF574e46/sneakers/jumper_0xFF966f5b");
            coordi.add("tshirts_0xFF727272/cargo_0xFF566556/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sports/jumper_0xFFebebeb");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFFebebeb/denim_0xFF272727/sports/cardigan_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/sports/jacket_0xFF727272");
            coordi.add("tshirts_0xFF2c3755/cotton_0xFF7c6375/sneakers/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/jogger_0xFF122b5a/sports/windshield_0xFFac76ac");
            coordi.add("tshirts_0xFF272727/cargo_0xFF566556/sports/jacket_0xFFfa223b");

          } else if (curTemp>14 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/jumper_0xFF566556");
            coordi.add("tshirts_0xFF272727/cargo_0xFF574e46/sneakers/jumper_0xFF272727");
            coordi.add("tshirts_0xFF6d6d6d/cargo_0xFF566556/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sports/jumper_0xFFebebeb");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFFebebeb/denim_0xFF272727/sports/cardigan_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/sports/jacket_0xFF6d6d6d");
            coordi.add("tshirts_0xFF1e2a4a/cotton_0xFF7c6375/sneakers/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/jogger_0xFF122b5a/sports/windshield_0xFF8aa0ce");
            coordi.add("tshirts_0xFF272727/cargo_0xFF566556/sports/jacket_0xFFa43636");
          } else if (curTemp>14 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/jumper_0xFF566556");
            coordi.add("tshirts_0xFF272727/cargo_0xFF574e46/sneakers/jumper_0xFF6e4942");
            coordi.add("tshirts_0xFF727272/cargo_0xFF566556/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sports/jumper_0xFFebebeb");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFFebebeb/denim_0xFF272727/sports/cardigan_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/sports/jacket_0xFF727272");
            coordi.add("tshirts_0xFF272f5d/cotton_0xFF7c6375/sneakers/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/jogger_0xFF122b5a/sports/windshield_0xFF5a3f5e");
            coordi.add("tshirts_0xFF272727/cargo_0xFF566556/sports/jacket_0xFFcc4533");
          } else if (curTemp>14 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/jumper_0xFF566556");
            coordi.add("tshirts_0xFF272727/cargo_0xFF574e46/sneakers/jumper_0xFF272727");
            coordi.add("tshirts_0xFF3b3b3b/cargo_0xFF566556/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sports/jumper_0xFFebebeb");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFFebebeb/denim_0xFF272727/sports/cardigan_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/sports/jacket_0xFF3b3b3b");
            coordi.add("tshirts_0xFF1e2a4a/cotton_0xFF7c6375/sneakers/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/jogger_0xFF122b5a/sports/windshield_0xFF1810c8");
            coordi.add("tshirts_0xFF272727/cargo_0xFF566556/sports/jacket_0xFF7c0000");
          } else if (curTemp>14 && curTemp<=16) {

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
            coordi.add("tshirts_0xFF272727/cotton_0xFF272727/sneakers/field_0xFF566556");
            coordi.add("tshirts_0xFF272727/denim_0xFF272727/dress/jacket_0xFF966f5b");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFFd2c19b/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFFd2c19b/dress/jumper_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF122b5a/sports/field_0xFF566556");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF2c3755/cotton_0xFFd2c19b/sports/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sports/windshield_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sneakers/jacket_0xFFd2c19b");
            coordi.add("tshirts_0xFF2c3755/denim_0xFFebebeb/sports/jacket_0xFFebebeb");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFd2c19b/sneakers/cardigan_0xFFebebeb");
          } else if (curTemp>14 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF272727/cotton_0xFF272727/sneakers/field_0xFF566556");
            coordi.add("tshirts_0xFF272727/denim_0xFF272727/dress/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFFd2c19b/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFFd2c19b/dress/jumper_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF122b5a/sports/field_0xFF566556");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF1e2a4a/cotton_0xFFd2c19b/sports/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sports/windshield_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sneakers/jacket_0xFFd2c19b");
            coordi.add("tshirts_0xFF1e2a4a/denim_0xFFebebeb/sports/jacket_0xFFebebeb");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFd2c19b/sneakers/cardigan_0xFFebebeb");
          } else if (curTemp>14 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("sweatshirts_0xFF272727/cotton_0xFF272727/sneakers/field_0xFF566556");
            coordi.add("tshirts_0xFF272727/denim_0xFF272727/dress/jacket_0xFF574e46");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFFd2c19b/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFFd2c19b/dress/jumper_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF122b5a/sports/field_0xFF566556");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF272f5d/cotton_0xFFd2c19b/sports/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sports/windshield_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sneakers/jacket_0xFFd2c19b");
            coordi.add("tshirts_0xFF272f5d/denim_0xFFebebeb/sports/jacket_0xFFebebeb");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFd2c19b/sneakers/cardigan_0xFFebebeb");
          } else if (curTemp>14 && curTemp<=16) {

          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF272727/cotton_0xFF272727/sneakers/field_0xFF566556");
            coordi.add("tshirts_0xFF272727/denim_0xFF272727/dress/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFFd2c19b/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFFd2c19b/dress/jumper_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF122b5a/sports/field_0xFF566556");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF1e2a4a/cotton_0xFFd2c19b/sports/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sports/windshield_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/cotton_0xFF272727/sneakers/jacket_0xFFd2c19b");
            coordi.add("tshirts_0xFF1e2a4a/denim_0xFFebebeb/sports/jacket_0xFFebebeb");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFd2c19b/sneakers/cardigan_0xFFebebeb");
          } else if (curTemp>14 && curTemp<=16) {

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
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF566556/sports/jumper_0xFFb7b4a6");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF7e8085/sports/jumper_0xFFfed9ce");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF373737/sports/field_0xFFac76ac");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFFebebeb/sports/jumper_0xFF966f5b");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF5B6265/sports/jacket_0xFFd2c19b");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF5B6265/sports/windshield_0xFFebebeb");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF373737/sports/jacket_0xFFac76ac");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF7e8085/sports/field_0xFFfed9ce");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFFebebeb/sports/jacket_0xFF966f5b");
          } else if (curTemp>15) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("sleeveless_0xFFebebeb/sports_0xFFd2c19b/sports/jumper_0xFFfed3dc");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFFebebeb/sports/field_0xFFcfcca4");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF7e8085/sports/jumper_0xFFa4b4cf");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF272727/sports/field_0xFFa4cfbe");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFFebebeb/sports/jumper_0xFFd82727");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF5e5e5e/sports/jacket_0xFFfed3dc");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF5e5e5e/sports/windshield_0xFFebebeb");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF32353E/sports/jacket_0xFFa4b4cf");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFFF4EEDD/sports/field_0xFFddc6f4");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFFF4EEDD/sports/jacket_0xFFd82727");

          } else if (curTemp>15) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF566556/sports/jumper_0xFFb7b4a6");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF7e8085/sports/jumper_0xFF65634c");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF373737/sports/field_0xFFa9819d");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFFebebeb/sports/jumper_0xFF6e4942");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF5B6265/sports/jacket_0xFF65634c");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF5B6265/sports/windshield_0xFFebebeb");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF32353E/sports/jacket_0xFFa9819d");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFFF4EEDD/sports/field_0xFF6e4942");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFFF4EEDD/sports/jacket_0xFFcc4533");

          } else if (curTemp>15) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF566556/sports/jumper_0xFFb7b4a6");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF7e8085/sports/jumper_0xFF255ac5");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF373737/sports/field_0xFFa1d2c9");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFFebebeb/sports/jumper_0xFFDB2F45");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF5e5e5e/sports/jacket_0xFFb7b4a6");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF5e5e5e/sports/windshield_0xFFebebeb");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFF32353E/sports/jacket_0xFF255ac5");
            coordi.add("sleeveless_0xFFebebeb/sports_0xFFF4EEDD/sports/field_0xFFa1d2c9");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFFF4EEDD/sports/jacket_0xFFDB2F45");

          } else if (curTemp>15) {

          }
          break;
      }
      break;



    case 4: // 클래식
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("sweatshirts_0xFF272727/cotton_0xFFebebeb/dress/coat_0xFFd2c19b");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFebebeb/sports/coat_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFF272727/dress/jacket_0xFF727272");
            coordi.add("tshirts_0xFF272727/denim_0xFFebebeb/dress/coat_0xFF727272");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFF727272/dress/coat_0xFF966f5b");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF272727/cotton_0xFFebebeb/dress/jacket_0xFF727272");
            coordi.add("shirts_0xFFebebeb/trouser_0xFF272727/dress/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/dress/jacket_0xFF272727");
            coordi.add("tshirts_0xFF272727/trouser_0xFF272727/dress/coat_0xFFd2c19b");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFebebeb/dress/coat_0xFF2c3755");
          } else if (curTemp>15) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("sweatshirts_0xFF272727/cotton_0xFFebebeb/dress/coat_0xFF1e2a4a");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFebebeb/sports/coat_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFF272727/dress/jacket_0xFF6d6d6d");
            coordi.add("tshirts_0xFF272727/denim_0xFFebebeb/dress/coat_0xFF6d6d6d");
            coordi.add("tshirts_0xFFebebeb/trouser_gray/dress/coat_0xFF1e2a4a");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF272727/cotton_0xFFebebeb/dress/jacket_0xFF6d6d6d");
            coordi.add("shirts_0xFFebebeb/trouser_0xFF272727/dress/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/dress/jacket_0xFF272727");
            coordi.add("tshirts_0xFF272727/trouser_0xFF272727/dress/coat_0xFF1e2a4a");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFebebeb/dress/coat_0xFF1e2a4a");
          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("sweatshirts_0xFF272727/cotton_0xFFebebeb/dress/coat_0xFFd2c19b");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFebebeb/sports/coat_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFF272727/dress/jacket_0xFF727272");
            coordi.add("tshirts_0xFF272727/denim_0xFFebebeb/dress/coat_0xFF727272");
            coordi.add("tshirts_0xFFebebeb/trouser_gray/dress/coat_0xFF6e4942");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF272727/cotton_0xFFebebeb/dress/jacket_0xFF727272");
            coordi.add("shirts_0xFFebebeb/trouser_0xFF272727/dress/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/dress/jacket_0xFF272727");
            coordi.add("tshirts_0xFF272727/trouser_0xFF272727/dress/coat_0xFFd2c19b");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFebebeb/dress/coat_0xFF272f5d");
          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("sweatshirts_0xFF272727/cotton_0xFFebebeb/dress/coat_0xFF1e2a4a");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFebebeb/sports/coat_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFF272727/dress/jacket_0xFF3b3b3b");
            coordi.add("tshirts_0xFF272727/denim_0xFFebebeb/dress/coat_0xFF3b3b3b");
            coordi.add("tshirts_0xFFebebeb/trouser_gray/dress/coat_0xFF1e2a4a");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("tshirts_0xFF272727/cotton_0xFFebebeb/dress/jacket_0xFF3b3b3b");
            coordi.add("shirts_0xFFebebeb/trouser_0xFF272727/dress/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/denim_0xFFebebeb/dress/jacket_0xFF272727");
            coordi.add("tshirts_0xFF272727/trouser_0xFF272727/dress/coat_0xFF1e2a4a");
            coordi.add("shirts_0xFFebebeb/cotton_0xFFebebeb/dress/coat_0xFF1e2a4a");
          } else if (curTemp>27) {

          }
          break;
      }
      break;

    case 5: // 고프코어
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("hoodie_0xFFa5936c/denim_0xFF5B6265/sports/jumper_0xFF3ec04e");
            coordi.add("hoodie_0xFFb7b4a6/jogger_0xFF566556/sports/field_0xFFd2c19b");
            coordi.add("sleeveless_0xFFb7b4a6/jogger_0xFFebebeb/sports/jumper_0xFFac76ac");
            coordi.add("sleeveless_0xFFb7b4a6/sports_0xFF574e46/sports/jumper_0xFFfed9ce");
            coordi.add("sweatshirts_0xFF2c2c2c/cotton_0xFF323b32/sports/field_0xFF727272");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("sleeveless_0xFFb7b4a6/cargo_0xFF4b570b/sports/windshield_0xFFd2c19b");
            coordi.add("sleeveless_0xFFb7b4a6/jogger_0xFFcc4533/sports/windshield_0xFF727272");
            coordi.add("sleeveless_0xFFb7b4a6/sports_0xFF5e5e5e/sports/windshield_0xFFfed9ce");
            coordi.add("shirts_0xFF272727/denim_0xFF272727/sneakers/jacket_0xFFac76ac");
            coordi.add("tshirts_0xFF2c2c2c/cargo_0xFF566556/sneakers/jacket_0xFF966f5b");
          } else if (curTemp>15) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("sleeveless_0xFFb7b4a6/denim_0xFF5e5e5e/sports/jumper_0xFFa4b4cf");
            coordi.add("sleeveless_0xFFebebeb/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("sleeveless_0xFFb7b4a6/jogger_0xFFd2c19b/sports/jumper_0xFF2e2e2e");
            coordi.add("sleeveless_0xFFb7b4a6/sports_0xFFd82727/sports/jumper_0xFFcbcbcb");
            coordi.add("sweatshirts_0xFFb7b4a6/cotton_0xFF566556/sports/field_0xFFfcffff");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("sleeveless_0xFFb7b4a6/cargo_0xFF566556/sports/windshield_0xFFebebeb");
            coordi.add("sleeveless_0xFFb7b4a6/jogger_0xFFd82727/sports/windshield_0xFFcbcbcb");
            coordi.add("sleeveless_0xFFb7b4a6/sports_0xFF5e5e5e/sports/windshield_0xFFcfcca4");
            coordi.add("shirts_0xFF272727/denim_0xFF2e2e2e/sneakers/jacket_0xFFddc6f4");
            coordi.add("tshirts_0xFFb7b4a6/cargo_0xFF566556/sneakers/jacket_0xFFfcffff");
          } else if (curTemp>15) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("sleeveless_0xFFb7b4a6/denim_0xFF5e5e5e/sports/jumper_0xFF574e46");
            coordi.add("sleeveless_0xFFb7b4a6/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("sleeveless_0xFFb7b4a6/jogger_0xFFd2c19b/sports/jumper_0xFF272727");
            coordi.add("sleeveless_0xFFb7b4a6/sports_0xFFcc4533/sports/jumper_0xFF5e5e5e");
            coordi.add("sweatshirts_0xFF2c2c2c/cotton_0xFF566556/sports/field_0xFF727272");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("sleeveless_0xFFb7b4a6/cargo_0xFF4b570b/sports/windshield_0xFFd2c19b");
            coordi.add("sleeveless_0xFFb7b4a6/jogger_0xFFcc4533/sports/windshield_0xFF727272");
            coordi.add("sleeveless_0xFFb7b4a6/sports_0xFF5e5e5e/sports/windshield_0xFF65634c");
            coordi.add("shirts_0xFF272727/denim_0xFF272727/sneakers/jacket_0xFF5a3f5e");
            coordi.add("tshirts_0xFFa5936c/cargo_0xFF566556/sneakers/jacket_0xFF6e4942");
          } else if (curTemp>15) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("sleeveless_0xFFb7b4a6/denim_0xFF5e5e5e/sports/jumper_0xFF255ac5");
            coordi.add("sleeveless_0xFFb7b4a6/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("sleeveless_0xFFb7b4a6/jogger_0xFFd2c19b/sports/jumper_0xFF2e2e2e");
            coordi.add("sleeveless_0xFFb7b4a6/sports_0xFFd82727/sports/jumper_0xFFcbcbcb");
            coordi.add("sweatshirts_0xFF2c2c2c/cotton_0xFF566556/sports/field_0xFFfcffff");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("sleeveless_0xFFb7b4a6/cargo_0xFF566556/sports/windshield_0xFFebebeb");
            coordi.add("sleeveless_0xFFb7b4a6/jogger_0xFF7c0000/sports/windshield_0xFFcbcbcb");
            coordi.add("sleeveless_0xFFb7b4a6/sports_0xFF5e5e5e/sports/windshield_0xFFa1d2c9");
            coordi.add("shirts_0xFF272727/denim_0xFF2e2e2e/sneakers/jacket_0xFFb23d9d");
            coordi.add("tshirts_0xFFb7b4a6/cargo_0xFF566556/sneakers/jacket_0xFFfcffff");
          } else if (curTemp>15) {

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

//여자
getItemFemale(int index) {
  List result = [];
  List<String> coordi = [];
  //['캐주얼', '스트릿', '아메카지', '스포츠', '클래식', '러블리', '고프코어']
  switch (index) {
    case 0: // 캐주얼
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sneakers/jumper_0xFFebebeb");
            coordi.add("tshirts_0xFFd2c19b/denim_0xFF1d1d1e/sports/coat_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/sports_0xFF122b5a/sports/jumper_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d2a44/sneakers/jumper_0xFFfed9ce");
            coordi.add("sweatshirts_0xFFebebeb/trouser_0xFFebebeb/sports/coat_0xFF272727");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF272727/boots/jacket_0xFF272727");
            coordi.add("sweatshirts_0xFFebebeb/trouser_0xFFebebeb/sneakers/jacket_0xFF966f5b");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d1d1e/sports/cardigan_0xFFebebeb");
            coordi.add("hoodie_0xFFebebeb/skirt_0xFFebebeb/sneakers/jacket_0xFF2c3755");
            coordi.add("sweatshirts_0xFFebebeb/skirt_0xFF574e46/sports/jacket_0xFFebebeb");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFF272727/denim_0xFFb0c3d0/sneakers/jacket_0xFF727272");
            coordi.add("hoodie_0xFF727272/trouser_0xFF272727/sneakers");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF566556/sports/windshield_0xFF2c3755");
            coordi.add("croptop_0xFFebebeb/denim_0xFF1d2a44/sneakers/jacket_0xFF966f5b");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFFebebeb/sports/cardigan_0xFF2c3755");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sneakers/jumper_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d1d1e/sports/coat_0xFFcbcbcb");
            coordi.add("tshirts_0xFFebebeb/sports_0xFF122b5a/sports/jumper_0xFF06544a");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d2a44/sneakers/jumper_0xFFa4b4cf");
            coordi.add("sweatshirts_0xFFebebeb/trouser_0xFFebebeb/sports/coat_0xFF272727");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF272727/boots/jacket_0xFF272727");
            coordi.add("sweatshirts_0xFFebebeb/trouser_0xFFebebeb/sneakers/jacket_0xFF2c3346");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d1d1e/sports/cardigan_0xFFcbcbcb");
            coordi.add("hoodie_0xFFebebeb/skirt_0xFFebebeb/sneakers/jacket_0xFF2c3346");
            coordi.add("sweatshirts_0xFFebebeb/skirt_0xFF574e46/sports/jacket_0xFFebebeb");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFF272727/denim_0xFFb0c3d0/sneakers/jacket_0xFFcbcbcb");
            coordi.add("hoodie_0xFFcbcbcb/trouser_0xFF272727/sneakers");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF566556/sports/windshield_0xFF2c3346");
            coordi.add("croptop_0xFFebebeb/denim_0xFF1d2a44/sneakers/jacket_0xFF574e46");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFFebebeb/sports/cardigan_0xFF2c3346");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sneakers/jumper_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d1d1e/sports/coat_0xFF6e4942");
            coordi.add("tshirts_0xFFebebeb/sports_0xFF122b5a/sports/jumper_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d2a44/sneakers/jumper_0xFFbc7baa");
            coordi.add("sweatshirts_0xFFebebeb/trouser_0xFFebebeb/sports/coat_0xFF272727");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF272727/boots/jacket_0xFF272727");
            coordi.add("sweatshirts_0xFFebebeb/trouser_0xFFebebeb/sneakers/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d1d1e/sports/cardigan_0xFFebebeb");
            coordi.add("hoodie_0xFFebebeb/skirt_0xFFebebeb/sneakers/jacket_0xFF272f5d");
            coordi.add("sweatshirts_0xFFebebeb/skirt_0xFF574e46/sports/jacket_0xFFebebeb");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFF272727/denim_0xFFb0c3d0/sneakers/jacket_0xFF727272");
            coordi.add("hoodie_0xFF727272/trouser_0xFF272727/sneakers");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF566556/sports/windshield_0xFF272f5d");
            coordi.add("croptop_0xFFebebeb/denim_0xFF1d2a44/sneakers/jacket_0xFF6e4942");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFFebebeb/sports/cardigan_0xFF272f5d");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sneakers/jumper_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d1d1e/sports/coat_0xFFcbcbcb");
            coordi.add("tshirts_0xFFebebeb/sports_0xFF122b5a/sports/jumper_0xFF01322b");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d2a44/sneakers/jumper_0xFF8ad8ea");
            coordi.add("sweatshirts_0xFFebebeb/trouser_0xFFebebeb/sports/coat_0xFF272727");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF272727/boots/jacket_0xFF272727");
            coordi.add("sweatshirts_0xFFebebeb/trouser_0xFFebebeb/sneakers/jacket_0xFF1e2a4a");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d1d1e/sports/cardigan_0xFF01322b");
            coordi.add("hoodie_0xFFebebeb/skirt_0xFFebebeb/sneakers/jacket_0xFF1e2a4a");
            coordi.add("sweatshirts_0xFFebebeb/skirt_0xFF574e46/sports/jacket_0xFFebebeb");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFF272727/denim_0xFFb0c3d0/sneakers/jacket_0xFFcbcbcb");
            coordi.add("hoodie_0xFFcbcbcb/trouser_0xFF272727/sneakers");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF566556/sports/windshield_0xFF1e2a4a");
            coordi.add("croptop_0xFFebebeb/denim_0xFF1d2a44/sneakers/jacket_0xFF413c38");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFFebebeb/sports/cardigan_0xFF1e2a4a");
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
            coordi.add("tshirts_0xFF272727/cargo_0xFF5e5e5e/sports/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFFac76ac/sports_0xFFac76ac/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF1d1d1e/boots/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFF3ec04e/trouser_0xFF5e5e5e/sneakers/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFFd2c19b/sports/jumper_0xFF272727");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF5e5e5e/boots/jacket_0xFF966f5b");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/cardigan_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFFebebeb/sports/coat_0xFF2c3755");
            coordi.add("hoodie_0xFF727272/sports_0xFF5e5e5e/sports/field_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF1d1d1e/boots/jacket_0xFF272727");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFFb0c3d0/boots/jacket_0xFF413c38");
            coordi.add("hoodie_0xFF727272/denim_0xFF1d2a44/sports/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/cardigan_0xFF272727");
            coordi.add("sweatshirts_0xFFebebeb/shorts_0xFF5e5e5e/boots");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d1d1e/sports/jacket_0xFFebebeb");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF272727/cargo_0xFF5e5e5e/sports/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFFcbcbcb/sports_0xFF5e5e5e/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF1d1d1e/boots/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFFa4cfbe/trouser_0xFF5e5e5e/sneakers/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sports/jumper_0xFF272727");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF5e5e5e/boots/jacket_0xFFebebeb");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/cardigan_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFFebebeb/sports/coat_0xFF2c3346");
            coordi.add("hoodie_0xFFcbcbcb/sports_0xFF5e5e5e/sports/field_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF1d1d1e/boots/jacket_0xFF272727");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFFb0c3d0/boots/jacket_0xFFcbcbcb");
            coordi.add("hoodie_0xFFcbcbcb/denim_0xFF1d2a44/sports/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/cardigan_0xFF272727");
            coordi.add("sweatshirts_0xFFa4b4cf/shorts_0xFF5e5e5e/boots");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d1d1e/sports/jacket_0xFFa4b4cf");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF272727/cargo_0xFF5e5e5e/sports/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFF5a3f5e/sports_0xFF5a3f5e/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF1d1d1e/boots/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFF4b570b/trouser_0xFF5e5e5e/sneakers/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFFd2c19b/sports/jumper_0xFF272727");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF5e5e5e/boots/jacket_0xFF6e4942");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/cardigan_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFFebebeb/sports/coat_0xFF272f5d");
            coordi.add("hoodie_0xFF727272/sports_0xFF5e5e5e/sports/field_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF1d1d1e/boots/jacket_0xFF272727");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFFb0c3d0/boots/jacket_0xFF413c38");
            coordi.add("hoodie_0xFF727272/denim_0xFF1d2a44/sports/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/cardigan_0xFF272727");
            coordi.add("sweatshirts_0xFFebebeb/shorts_0xFF5e5e5e/boots");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF1d1d1e/sports/jacket_0xFFebebeb");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("tshirts_0xFF272727/cargo_0xFF5e5e5e/sports/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFF5d0dcd/sports_0xFF5d0dcd/sports/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF272727/boots/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFF0b655a/trouser_0xFF5e5e5e/sneakers/jumper_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sports/jumper_0xFF272727");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF5e5e5e/boots/jacket_0xFF413c38");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/cardigan_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/trouser_0xFFebebeb/sports/coat_0xFF1e2a4a");
            coordi.add("hoodie_0xFFcbcbcb/sports_0xFF5e5e5e/sports/field_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF272727/boots/jacket_0xFF272727");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFFebebeb/skirt_0xFFb0c3d0/boots/jacket_0xFF2e2e2e");
            coordi.add("hoodie_0xFFcbcbcb/denim_0xFFb0c3d0/sports/jacket_0xFF272727");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF272727/sports/cardigan_0xFF272727");
            coordi.add("sweatshirts_0xFF8ad8ea/shorts_0xFF5e5e5e/boots");
            coordi.add("tshirts_0xFFebebeb/denim_0xFF272727/sports/jacket_0xFF1810c8");
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
            coordi.add("sweatshirts_0xFFebebeb/cargo_0xFFebebeb/sneakers/jacket_0xFF966f5b");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFFd2c19b/sneakers/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFFebebeb/cargo_0xFFd2c19b/sports/jumper_0xFF566556");
            coordi.add("sweatshirts_0xFF272727/skirt_0xFF574e46/boots/jumper_0xFFebebeb");
            coordi.add("sweatshirts_0xFFebebeb/skirt_0xFFb0c3d0/sneakers/field_0xFF566556");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFebebeb/skirt_0xFF272727/sneakers/jumper_0xFFebebeb");
            coordi.add("sweatshirts_0xFFebebeb/denim_0xFF272727/sports/field_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF413c38/sneakers/cardigan_0xFFebebeb");
            coordi.add("sweatshirts_0xFFebebeb/denim_0xFFb0c3d0/sports/jacket_0xFF966f5b");
            coordi.add("tshirts_0xFF566556/skirt_0xFF272727/sports/jumper_0xFF272727");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFFebebeb/cargo_0xFFd2c19b/sneakers/cardigan_0xFF2c3755");
            coordi.add("shirts_0xFFebebeb/cargo_0xFFd2c19b/sports/vest_0xFF272727");
            coordi.add("sweatshirts_0xFF3ec04e/skirt_0xFFd2c19b/sneakers");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sports/jacket_0xFF2c3755");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF574e46/sports/jacket_0xFF2c3755");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("sweatshirts_0xFFebebeb/cargo_0xFFebebeb/sneakers/jacket_0xFF574e46");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF5e5e5e/sneakers/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFF566556/cargo_0xFFd2c19b/sports/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFF272727/skirt_0xFF574e46/boots/jumper_0xFFcbcbcb");
            coordi.add("sweatshirts_0xFFebebeb/skirt_0xFFb0c3d0/sneakers/field_0xFF566556");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFebebeb/skirt_0xFF272727/sneakers/jumper_0xFFebebeb");
            coordi.add("sweatshirts_0xFFebebeb/denim_0xFF272727/sports/field_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF5e5e5e/sneakers/cardigan_0xFFebebeb");
            coordi.add("sweatshirts_0xFFebebeb/denim_0xFFb0c3d0/sports/jacket_0xFF574e46");
            coordi.add("tshirts_0xFF566556/skirt_0xFF272727/sports/jumper_0xFF272727");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFFebebeb/cargo_0xFFd2c19b/sneakers/cardigan_0xFF2c3346");
            coordi.add("shirts_0xFFebebeb/cargo_0xFFd2c19b/sports/vest_0xFF272727");
            coordi.add("sweatshirts_0xFFa4cfbe/skirt_0xFFd2c19b/sneakers");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sports/jacket_0xFF2c3346");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF574e46/sports/jacket_0xFF050d24");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("sweatshirts_0xFFebebeb/cargo_0xFFebebeb/sneakers/jacket_0xFF6e4942");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF413c38/sneakers/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFFebebeb/cargo_0xFFd2c19b/sports/jumper_0xFF566556");
            coordi.add("sweatshirts_0xFF272727/skirt_0xFF574e46/boots/jumper_0xFFebebeb");
            coordi.add("sweatshirts_0xFFebebeb/skirt_0xFFb0c3d0/sneakers/field_0xFF566556");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFebebeb/skirt_0xFF272727/sneakers/jumper_0xFFebebeb");
            coordi.add("sweatshirts_0xFFebebeb/denim_0xFF272727/sports/field_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF574e46/sneakers/cardigan_0xFFebebeb");
            coordi.add("sweatshirts_0xFFebebeb/denim_0xFFb0c3d0/sports/jacket_0xFF6e4942");
            coordi.add("tshirts_0xFF566556/skirt_0xFF272727/sports/jumper_0xFF272727");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFFebebeb/cargo_0xFFd2c19b/sneakers/cardigan_0xFF272f5d");
            coordi.add("shirts_0xFFebebeb/cargo_0xFFd2c19b/sports/vest_0xFF272727");
            coordi.add("sweatshirts_0xFF4b570b/skirt_0xFFd2c19b/sneakers");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sports/jacket_0xFF272f5d");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF574e46/sports/jacket_0xFF050d24");
          } else if (curTemp>16 && curTemp<=22) {

          } else if (curTemp>22 && curTemp<=27) {

          } else if (curTemp>27) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("sweatshirts_0xFFebebeb/cargo_0xFFebebeb/sneakers/jacket_0xFF413c38");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF5e5e5e/sneakers/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFF566556/cargo_0xFFd2c19b/sports/jumper_0xFF272727");
            coordi.add("sweatshirts_0xFF272727/skirt_0xFF574e46/boots/jumper_0xFFcbcbcb");
            coordi.add("sweatshirts_0xFFebebeb/skirt_0xFFb0c3d0/sneakers/field_0xFF566556");
          } else if (curTemp>4 && curTemp<=11) {
            coordi.add("shirts_0xFFebebeb/skirt_0xFF272727/sneakers/jumper_0xFFebebeb");
            coordi.add("sweatshirts_0xFFebebeb/denim_0xFF272727/sports/field_0xFF566556");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF5e5e5e/sneakers/cardigan_0xFFebebeb");
            coordi.add("sweatshirts_0xFFebebeb/denim_0xFFb0c3d0/sports/jacket_0xFF574e46");
            coordi.add(" tshirts_0xFF566556/skirt_0xFF272727/sports/jumper_0xFF272727");
          } else if (curTemp>11 && curTemp<=16) {
            coordi.add("tshirts_0xFFebebeb/cargo_0xFFd2c19b/sneakers/cardigan_0xFF1e2a4a");
            coordi.add("shirts_0xFFebebeb/cargo_0xFFd2c19b/sports/vest_0xFF272727");
            coordi.add("sweatshirts_0xFF0b655a/skirt_0xFFd2c19b/sneakers");
            coordi.add("tshirts_0xFFebebeb/cargo_0xFF566556/sports/jacket_0xFF1e2a4a");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF574e46/sports/jacket_0xFF050d24");
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
            coordi.add("croptop_0xFFebebeb/sports_0xFF566556/sports/jumper_0xFFb7b4a6");
            coordi.add("croptop_0xFFebebeb/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("croptop_0xFFebebeb/sports_0xFF7e8085/sports/jumper_0xFFfed9ce");
            coordi.add("croptop_0xFFebebeb/sports_0xFF373737/sports/field_0xFFac76ac");
            coordi.add("croptop_0xFFebebeb/jogger_0xFFebebeb/sports/jumper_0xFF966f5b");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("croptop_0xFFebebeb/sports_0xFF5B6265/sports/jacket_0xFFd2c19b");
            coordi.add("croptop_0xFFebebeb/sports_0xFF5B6265/sports/windshield_0xFFebebeb");
            coordi.add("croptop_0xFFebebeb/sports_0xFF373737/sports/jacket_0xFFac76ac");
            coordi.add("croptop_0xFFebebeb/sports_0xFF7e8085/sports/field_0xFFfed9ce");
            coordi.add("croptop_0xFFebebeb/jogger_0xFFebebeb/sports/jacket_0xFF966f5b");
          } else if (curTemp>15) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("croptop_0xFFebebeb/sports_0xFFd2c19b/sports/jumper_0xFFfed3dc");
            coordi.add("croptop_0xFFebebeb/jogger_0xFFebebeb/sports/field_0xFFcfcca4");
            coordi.add("croptop_0xFFebebeb/sports_0xFF7e8085/sports/jumper_0xFFa4b4cf");
            coordi.add("croptop_0xFFebebeb/sports_0xFF272727/sports/field_0xFFa4cfbe");
            coordi.add("croptop_0xFFebebeb/jogger_0xFFebebeb/sports/jumper_0xFFd82727");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("croptop_0xFFebebeb/sports_0xFF5e5e5e/sports/jacket_0xFFfed3dc");
            coordi.add("croptop_0xFFebebeb/sports_0xFF5e5e5e/sports/windshield_0xFFebebeb");
            coordi.add("croptop_0xFFebebeb/sports_0xFF32353E/sports/jacket_0xFFa4b4cf");
            coordi.add("croptop_0xFFebebeb/sports_0xFFF4EEDD/sports/field_0xFFddc6f4");
            coordi.add("croptop_0xFFebebeb/jogger_0xFFF4EEDD/sports/jacket_0xFFd82727");
          } else if (curTemp>15) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("croptop_0xFFebebeb/sports_0xFF566556/sports/jumper_0xFFb7b4a6");
            coordi.add("croptop_0xFFebebeb/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("croptop_0xFFebebeb/sports_0xFF7e8085/sports/jumper_0xFF65634c");
            coordi.add("croptop_0xFFebebeb/sports_0xFF373737/sports/field_0xFFa9819d");
            coordi.add("croptop_0xFFebebeb/jogger_0xFFebebeb/sports/jumper_0xFF6e4942");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("croptop_0xFFebebeb/sports_0xFF5B6265/sports/jacket_0xFF65634c");
            coordi.add("croptop_0xFFebebeb/sports_0xFF5B6265/sports/windshield_0xFFebebeb");
            coordi.add("croptop_0xFFebebeb/sports_0xFF32353E/sports/jacket_0xFFa9819d");
            coordi.add("croptop_0xFFebebeb/sports_0xFFF4EEDD/sports/field_0xFF6e4942");
            coordi.add("croptop_0xFFebebeb/jogger_0xFFF4EEDD/sports/jacket_0xFFcc4533");
          } else if (curTemp>15) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("croptop_0xFFebebeb/sports_0xFF566556/sports/jumper_0xFFb7b4a6");
            coordi.add("croptop_0xFFebebeb/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("croptop_0xFFebebeb/sports_0xFF7e8085/sports/jumper_0xFF255ac5");
            coordi.add("croptop_0xFFebebeb/sports_0xFF373737/sports/field_0xFFa1d2c9");
            coordi.add("croptop_0xFFebebeb/jogger_0xFFebebeb/sports/jumper_0xFFDB2F45");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("croptop_0xFFebebeb/sports_0xFF5e5e5e/sports/jacket_0xFFb7b4a6");
            coordi.add("croptop_0xFFebebeb/sports_0xFF5e5e5e/sports/windshield_0xFFebebeb");
            coordi.add("croptop_0xFFebebeb/sports_0xFF32353E/sports/jacket_0xFF255ac5");
            coordi.add("croptop_0xFFebebeb/sports_0xFFF4EEDD/sports/field_0xFFa1d2c9");
            coordi.add("croptop_0xFFebebeb/jogger_0xFFF4EEDD/sports/jacket_0xFFDB2F45");
          } else if (curTemp>15) {

          }
          break;
      }
      break;


    case 4: // 클래식
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("shirts_0xFFebebeb/trouser_0xFF272727/sneakers/coat_0xFFebebeb");
            coordi.add("shirts_0xFFebebeb/trouser_0xFF272727/boots/coat_0xFF966f5b");
            coordi.add("croptop_0xFFebebeb/denim_0xFF5e5e5e/boots/jumper_0xFFfed9ce");
            coordi.add("croptop_0xFFebebeb/trouser_0xFFebebeb/boots/coat_0xFF966f5b");
            coordi.add("croptop_0xFFd2c19b/denim_0xFF272727/sneakers/coat_0xFF727272");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("shirts_0xFFebebeb/denim_0xFF272727/sneakers/cardigan_0xFFfed9ce");
            coordi.add("croptop_0xFFebebeb/trouser_0xFFF4EEDD/boots/jacket_0xFF966f5b");
            coordi.add("onepiece_0xFFebebeb/skirt_0xFFebebeb/sneakers/cardigan_0xFFac76ac");
            coordi.add("croptop_0xFFebebeb/denim_0xFFb0c3d0/sneakers/jacket_0xFFd2c19b");
            coordi.add("onepiece_0xFFb7b4a6/trouser_0xFF272727/sneakers/cardigan_0xFF3ec04e");
          } else if (curTemp>15) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("shirts_0xFFa4cfbe/trouser_0xFF5e5e5e/sneakers/coat_0xFFfcffff");
            coordi.add("croptop_0xFFebebeb/trouser_0xFFebebeb/boots/coat_0xFFa4cfbe");
            coordi.add("croptop_0xFFebebeb/denim_0xFFb0c3d0/boots/jumper_0xFFfcffff");
            coordi.add("croptop_0xFFd2c19b/trouser_0xFFebebeb/boots/coat_0xFFfed3dc");
            coordi.add("croptop_0xFFddc6f4/denim_0xFFb0c3d0/sneakers/coat_0xFFcbcbcb");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("shirts_0xFFfcffff/denim_0xFFb0c3d0/sneakers/cardigan_0xFF2e2e2e");
            coordi.add("croptop_0xFFebebeb/trouser_0xFFebebeb/boots/jacket_0xFFa4cfbe");
            coordi.add("shirts_0xFFa4b4cf/skirt_0xFF272727/sneakers/cardigan_0xFF5e5e5e");
            coordi.add("croptop_0xFFfcffff/denim_0xFF5e5e5e/sneakers/jacket_0xFFfed3dc");
            coordi.add("onepiece_0xFFfcffff/skirt_0xFF2c2c2c/boots/cardigan_0xFFa4b4cf");
          } else if (curTemp>15) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("shirts_0xFFebebeb/trouser_0xFF272727/sneakers/coat_0xFF4b570b");
            coordi.add("shirts_0xFFebebeb/trouser_0xFF272727/boots/coat_0xFF6e4942");
            coordi.add("croptop_0xFFebebeb/denim_0xFF5e5e5e/boots/jumper_0xFFa9819d");
            coordi.add("croptop_0xFFebebeb/trouser_0xFFebebeb/boots/coat_0xFF574e46");
            coordi.add("croptop_0xFFd2c19b/denim_0xFF272727/sneakers/coat_0xFF727272");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("shirts_0xFF5e5e5e/denim_0xFF272727/sneakers/cardigan_0xFF65634c");
            coordi.add("croptop_0xFFebebeb/trouser_0xFFF4EEDD/boots/jacket_0xFF6e4942");
            coordi.add("onepiece_0xFFebebeb/skirt_0xFFebebeb/sneakers/cardigan_0xFFa9819d");
            coordi.add("croptop_0xFFebebeb/denim_0xFF5e5e5e/sneakers/jacket_0xFF574e46");
            coordi.add("onepiece_0xFFb7b4a6/skirt_0xFF272727/sneakers/cardigan_0xFF727272");
          } else if (curTemp>15){

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("croptop_0xFFa1d2c9/trouser_0xFF373737/sneakers/coat_0xFFfcffff");
            coordi.add("croptop_0xFFebebeb/trouser_0xFFebebeb/boots/coat_0xFF255ac5");
            coordi.add("croptop_0xFFebebeb/denim_0xFFb0c3d0/boots/jumper_0xFFfcffff");
            coordi.add("croptop_0xFFd2c19b/trouser_0xFFebebeb/boots/coat_0xFFd55a96");
            coordi.add("croptop_0xFFd2c19b/denim_0xFFb0c3d0/sneakers/coat_0xFF7e8085");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("shirts_0xFFfcffff/denim_0xFFb0c3d0/sneakers/cardigan_0xFF2e2e2e");
            coordi.add("croptop_0xFFebebeb/trouser_0xFFebebeb/boots/jacket_0xFFa1d2c9");
            coordi.add("croptop_0xFFd2c19b/skirt_0xFF272727/sneakers/cardigan_0xFF7e8085");
            coordi.add("croptop_0xFFd2c19b/denim_0xFF5e5e5e/sneakers/jacket_0xFFb23d9d");
            coordi.add("onepiece_0xFFfcffff/skirt_0xFF2c2c2c/boots/cardigan_0xFF255ac5");
          } else if (curTemp>15) {

          }
          break;
      }
      break;


    case 5: // 고프코어
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("hoodie_0xFFa5936c/denim_0xFF5B6265/sports/jumper_0xFF3ec04e");
            coordi.add("hoodie_0xFFb7b4a6/jogger_0xFF566556/sports/field_0xFFd2c19b");
            coordi.add("croptop_0xFFb7b4a6/jogger_0xFFebebeb/sports/jumper_0xFFac76ac");
            coordi.add("croptop_0xFFb7b4a6/sports_0xFF574e46/sports/jumper_0xFFfed9ce");
            coordi.add("croptop_0xFFb7b4a6/skirt_0xFF566556/sports/field_0xFF727272");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("croptop_0xFFb7b4a6/cargo_0xFF4b570b/sports/windshield_0xFFd2c19b");
            coordi.add("croptop_0xFFb7b4a6/jogger_0xFFcc4533/sports/windshield_0xFF727272");
            coordi.add("croptop_0xFFb7b4a6/sports_0xFF5e5e5e/sports/windshield_0xFFfed9ce");
            coordi.add("shirts_0xFF272727/denim_0xFF272727/sneakers/jacket_0xFFac76ac");
            coordi.add("croptop_0xFFb7b4a6/skirt_0xFF566556/sneakers/jacket_0xFF966f5b");
          } else if (curTemp>15) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("croptop_0xFFb7b4a6/denim_0xFF5e5e5e/sports/jumper_0xFFa4b4cf");
            coordi.add("croptop_0xFFebebeb/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("croptop_0xFFb7b4a6/jogger_0xFFd2c19b/sports/jumper_0xFF2e2e2e");
            coordi.add("croptop_0xFFb7b4a6/sports_0xFFd82727/sports/jumper_0xFFcbcbcb");
            coordi.add("croptop_0xFFb7b4a6/skirt_0xFF566556/sports/field_0xFFfcffff");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("croptop_0xFFb7b4a6/cargo_0xFF566556/sports/windshield_0xFFebebeb");
            coordi.add("croptop_0xFFb7b4a6/jogger_0xFFd82727/sports/windshield_0xFFcbcbcb");
            coordi.add("croptop_0xFFb7b4a6/sports_0xFF5e5e5e/sports/windshield_0xFFcfcca4");
            coordi.add("shirts_0xFF272727/denim_0xFF2e2e2e/sneakers/jacket_0xFFddc6f4");
            coordi.add("croptop_0xFFb7b4a6/skirt_0xFF566556/sneakers/jacket_0xFFfcffff");
          } else if (curTemp>15) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("croptop_0xFFb7b4a6/denim_0xFF5e5e5e/sports/jumper_0xFF574e46");
            coordi.add("croptop_0xFFb7b4a6/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("croptop_0xFFb7b4a6/jogger_0xFFd2c19b/sports/jumper_0xFF272727");
            coordi.add("croptop_0xFFb7b4a6/sports_0xFFcc4533/sports/jumper_0xFF5e5e5e");
            coordi.add("croptop_0xFFb7b4a6/skirt_0xFF566556/sports/field_0xFF727272");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("croptop_0xFFb7b4a6/cargo_0xFF4b570b/sports/windshield_0xFFd2c19b");
            coordi.add("croptop_0xFFb7b4a6/jogger_0xFFcc4533/sports/windshield_0xFF727272");
            coordi.add("croptop_0xFFb7b4a6/sports_0xFF5e5e5e/sports/windshield_0xFF65634c");
            coordi.add("shirts_0xFF272727/denim_0xFF272727/sneakers/jacket_0xFF5a3f5e");
            coordi.add("croptop_0xFFb7b4a6/skirt_0xFF566556/sneakers/jacket_0xFF6e4942");
          } else if (curTemp>15) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("croptop_0xFFb7b4a6/denim_0xFF5e5e5e/sports/jumper_0xFF255ac5");
            coordi.add("croptop_0xFFebebeb/jogger_0xFF7c6375/sports/field_0xFFebebeb");
            coordi.add("croptop_0xFFb7b4a6/jogger_0xFFd2c19b/sports/jumper_0xFF2e2e2e");
            coordi.add("croptop_0xFFb7b4a6/sports_0xFFd82727/sports/jumper_0xFFcbcbcb");
            coordi.add("croptop_0xFFb7b4a6/skirt_0xFF566556/sports/field_0xFFfcffff");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("croptop_0xFFb7b4a6/cargo_0xFF566556/sports/windshield_0xFFebebeb");
            coordi.add("croptop_0xFFb7b4a6/jogger_0xFF7c0000/sports/windshield_0xFFcbcbcb");
            coordi.add("croptop_0xFFb7b4a6/sports_0xFF5e5e5e/sports/windshield_0xFFa1d2c9");
            coordi.add("shirts_0xFF272727/denim_0xFF2e2e2e/sneakers/jacket_0xFFb23d9d");
            coordi.add("croptop_0xFFfcffff/skirt_0xFF566556/sneakers/jacket_0xFFfcffff");
          } else if (curTemp>15) {

          }
          break;
      }
      break;

    case 6: // 러블리
      switch (perCol) {
        case "Spring Warm": // 봄웜
          if (curTemp<=4) {
            coordi.add("shirts_0xFFebebeb/trouser_0xFF5e5e5e/boots/coat_0xFFd2c19b");
            coordi.add("sweatshirts_0xFFa5936c/denim_0xFFb0c3d0/boots/coat_0xFF65634c");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF272727/boots/coat_0xFFa5936c");
            coordi.add("croptop_0xFFd2c19b/denim_0xFFb0c3d0/boots/jacket_0xFFcc4533");
            coordi.add("sweatshirts_0xFFd2c19b/skirt_0xFF272727/boots/coat_0xFF6e4942");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("onepiece_0xFFebebeb/skirt_0xFFebebe/boots/cardigan_0xFFcc4533");
            coordi.add("shirts_0xFFfcffff/skirt_0xFF272727/sneakers/cardigan_0xFF6e4942");
            coordi.add("shirts_0xFFfcffff/skirt_0xFF574e46/boots/jacket_0xFF65634c");
            coordi.add("shirts_0xFFbcb9b9/denim_0xFFb0c3d0/boots/jacket_0xFF727272");
            coordi.add("sweatshirts_0xFFa5936c/skirt_0xFF323b32/sneakers");
          } else if (curTemp>15) {

          }
          break;

        case "Summer Cool": // 여쿨
          if (curTemp<=4) {
            coordi.add("onepiece_0xFFfcffff/skirt_0xFFbcb9b9/boots/coat_0xFFfed3dc");
            coordi.add("croptop_0xFFfcffff/denim_0xFFb0c3d0/boots/coat_0xFFcfcca4");
            coordi.add("croptop_0xFFfcffff/trouser_0xFFebebeb/boots/coat_0xFFfcffff");
            coordi.add("croptop_0xFFfcffff/denim_0xFFb0c3d0/boots/jacket_0xFF2c3346");
            coordi.add("sweatshirts_0xFFbcb9b9/skirt_0xFFcbcbcb/boots/coat_0xFFebebeb");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("onepiece_0xFFebebeb/skirt_0xFFebebe/boots/cardigan_0xFFcfcca4");
            coordi.add("shirts_0xFFfcffff/skirt_0xFF2e2e2e/sneakers/cardigan_0xFFcbcbcb");
            coordi.add("shirts_0xFFebebeb/skirt_0xFF574e46/boots/jacket_0xFFfed3dc");
            coordi.add("croptop_0xFFbcb9b9/denim_0xFFb0c3d0/boots/jacket_0xFFa4cfbe");
            coordi.add("sweatshirts_0xFFa4b4cf/skirt_0xFFebebeb/sneakers");
          }  else if (curTemp>15) {

          }
          break;

        case "Autumn Warm": // 가웜
          if (curTemp<=4) {
            coordi.add("shirts_0xFFebebeb/trouser_0xFF5e5e5e/boots/coat_0xFF5a3f5e");
            coordi.add("sweatshirts_0xFFa5936c/denim_0xFFb0c3d0/boots/coat_0xFF65634c");
            coordi.add("tshirts_0xFFebebeb/skirt_0xFF272727/boots/coat_0xFFa5936c");
            coordi.add("croptop_0xFFd2c19b/denim_0xFFb0c3d0/boots/jacket_0xFFcc4533");
            coordi.add("sweatshirts_0xFFd2c19b/skirt_0xFF272727/boots/coat_0xFF6e4942");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("onepiece_0xFFebebeb/skirt_0xFFebebe/boots/cardigan_0xFFcc4533");
            coordi.add("shirts_0xFFfcffff/skirt_0xFF272727/sneakers/cardigan_0xFF6e4942");
            coordi.add("shirts_0xFFfcffff/skirt_0xFF574e46/boots/jacket_0xFF65634c");
            coordi.add("shirts_0xFFbcb9b9/denim_0xFFb0c3d0/boots/jacket_0xFF727272");
            coordi.add("sweatshirts_0xFFa5936c/skirt_0xFF323b32/sneakers");
          } else if (curTemp>15) {

          }
          break;

        case "Winter Cool": // 겨쿨
          if (curTemp<=4) {
            coordi.add("onepiece_0xFFfcffff/skirt_0xFFbcb9b9/boots/coat_0xFFd55a96");
            coordi.add("croptop_0xFFfcffff/denim_0xFFb0c3d0/boots/coat_0xFFd0ca7c");
            coordi.add("croptop_0xFFfcffff/trouser_0xFFebebeb/boots/coat_0xFFfcffff");
            coordi.add("croptop_0xFFfcffff/denim_0xFFb0c3d0/boots/jacket_0xFF2c3346");
            coordi.add("sweatshirts_0xFFbcb9b9/skirt_0xFFbcb9b9/boots/coat_0xFF272727");
          } else if (curTemp>4 && curTemp<=14) {
            coordi.add("onepiece_0xFFebebeb/skirt_0xFFebebe/boots/cardigan_0xFFd0ca7c");
            coordi.add("shirts_0xFFfcffff/skirt_0xFF272727/sneakers/cardigan_0xFF7e8085");
            coordi.add("shirts_0xFFfcffff/skirt_0xFF2c3346/boots/jacket_0xFFebebeb");
            coordi.add("shirts_0xFFbcb9b9/denim_0xFFb0c3d0/boots/jacket_0xFFa1d2c9");
            coordi.add("sweatshirts_0xFF255ac5/skirt_0xFFebebeb/sneakers");
          } else if (curTemp>15) {

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


