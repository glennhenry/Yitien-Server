package com.yiTian.view.modules.newRolePan
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import flash.display.Stage;
   import flash.utils.Dictionary;
   
   public class PaiHangRoleMter
   {
      
      private static var _levelTen:int;
      
      private static var _levelSix:int;
      
      private static var _levelSixNums:int;
      
      private static var _level:int;
      
      private static var _nums:int;
      
      public static const V1:int = 5;
      
      public static const V2:int = 7;
      
      public static const V3:int = 9;
      
      public static const V4:int = 11;
      
      public static const EFF:int = 3;
      
      public function PaiHangRoleMter()
      {
         super();
      }
      
      public static function onMouseMove(e:Object) : void
      {
         var data1:Array = null;
         var data2:Array = null;
         var str1:String = null;
         var str2:String = null;
         var color:String = null;
         var strVec:Vector.<String> = new Vector.<String>();
         if(_levelTen == 0 && _levelSix == 0)
         {
            data1 = getData(6,_level);
            data2 = getData(10,_level);
            strVec.push("<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,_level) + "</font><font color=\'#7CCCF2\' size=\'12\'>(" + _nums + "/10)</font>\n" + "<font color=\'#999999\' size=\'12\'>6 " + LangConfig.getWord("10011",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#999999\' size=\'12\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data2[V1] + "   " + Data_lib.attribute[1][0] + "+" + data2[V2] + "   " + Data_lib.attribute[2][0] + "+" + data2[V3] + "</font>\n" + "<font color=\'#999999\' size=\'12\'>　　　" + LangConfig.getWord("10013",1) + "+" + data2[V4] + "%</font>");
         }
         else if(_levelTen == 10)
         {
            data1 = getData(10,10);
            strVec.push("<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,10) + "(10/10)</font><font color=\'#7CCCF2\' size=\'12\'>   " + LangConfig.getWord("10014",1) + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>　　　" + LangConfig.getWord("10013",1) + "+" + data1[V4] + "%</font>");
         }
         else
         {
            str1 = "";
            if(Boolean(_levelTen))
            {
               data1 = getData(10,_levelTen);
               str1 = "<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,_levelTen) + "</font><font color=\'#7CCCF2\' size=\'12\'>   " + LangConfig.getWord("10014",1) + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>　　　" + LangConfig.getWord("10013",1) + "+" + data1[V4] + "%</font>";
            }
            str2 = "";
            color = "";
            if(Boolean(_levelSix))
            {
               color = "9ADA78";
               data1 = getData(6,_levelSix);
               data2 = getData(10,_levelSix);
            }
            else
            {
               color = "999999";
               data1 = getData(6,_levelTen + 2);
               data2 = getData(10,_levelTen + 2);
            }
            str2 = "<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,Boolean(_levelSix) ? _levelSix : _levelTen + 2) + "</font><font color=\'#7CCCF2\' size=\'12\'>   (" + _levelSixNums + "/10)</font>\n" + "<font color=\'#" + color + "\'>6 " + LangConfig.getWord("10011",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#999999\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data2[V1] + "   " + Data_lib.attribute[1][0] + "+" + data2[V2] + "   " + Data_lib.attribute[2][0] + "+" + data2[V3] + "</font>\n" + "<font color=\'#999999\'>　　　" + LangConfig.getWord("10013",1) + "+" + data2[V4] + "%</font>";
            if(Boolean(str2))
            {
               strVec.push(str2);
            }
            if(Boolean(str1))
            {
               strVec.push(str1);
            }
         }
         UIManager.rolePanel.tip.updata(e,strVec);
         var stage:Stage = Global.stage;
         if(stage.mouseX + UIManager.rolePanel.tip.width > stage.stageWidth)
         {
            UIManager.rolePanel.tip.x = stage.mouseX - UIManager.rolePanel.tip.width - 10;
         }
         else
         {
            UIManager.rolePanel.tip.x = stage.mouseX + 10;
         }
         if(stage.mouseY + UIManager.rolePanel.tip.height > stage.stageHeight)
         {
            UIManager.rolePanel.tip.y = stage.stageHeight - UIManager.rolePanel.tip.height;
         }
         else
         {
            UIManager.rolePanel.tip.y = stage.mouseY;
         }
      }
      
      public static function strengthenSet(levelTen:int, levelSix:int, levelSixNums:int, level:int, nums:int) : void
      {
         _levelTen = levelTen;
         _levelSix = levelSix;
         _levelSixNums = levelSixNums;
         _level = level;
         _nums = nums;
      }
      
      private static function getData(type:int, level:int) : Array
      {
         var key:* = undefined;
         var data:Dictionary = Data_lib.equipStrongAddAward;
         for(key in data)
         {
            if(data[key][0] == type && data[key][1] == level)
            {
               return data[key];
            }
         }
         return [];
      }
   }
}

