package com.yiTian.view.modules.horse
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   
   public class HorseConfig
   {
      
      private static var _duanZaoRep:String;
      
      private static var _sequenceLib:Array;
      
      private static var _partNames:Array;
      
      private static var _partAtbsLabel:Array;
      
      private static var _convertsDic:Dictionary;
      
      public static const PART_EXP:int = 0;
      
      public static const PART_DATAINTERVAL:int = 2;
      
      public static const PART_FIRST_OFFSET:int = 1;
      
      public static const PART_PER_EXP:int = 0;
      
      public static const PART_PER_ATB:int = 1;
      
      public static const QIANGHUA_SUCCESS:int = 0;
      
      public static const QIANGHUA_SILVER_REQUIRE:int = 1;
      
      public static const QIANGHUA_ITEMID_REQUIRE:int = 2;
      
      public static const QIANGHUA_NUMITEM_REQUIRE:int = 3;
      
      public static const QIANGHUA_MULTIPLE:int = 4;
      
      public static const QIANGHUA_EXTRAATB:int = 5;
      
      public static const LIB_HORSE_TYPE:int = 0;
      
      public static const LIB_LIBENABLED_ATB:int = 1;
      
      public static const LIB_ELEVATING_ID:int = 2;
      
      public static const LIB_BASE_ATB:int = 3;
      
      public static const LIB_ELEVATE_ITEMID_REQUIRE:int = 4;
      
      public static const LIB_ELEVATE_NUMITEM_REQUIRE:int = 5;
      
      public static const LIB_ELEVATE_SILVER_REQUIRE:int = 6;
      
      public static const LIB_MODELID:int = 7;
      
      public static const LIB_ENABLE_ITEMID_REQUIRE:int = 8;
      
      public static const LIB_HORSE_NAME:int = 9;
      
      public static const LIB_YAXISAMENDMENT:int = 10;
      
      public static const LIB_JUMPPIXEL:int = 11;
      
      public static const LIB_DISCTIPTION:int = 13;
      
      public static const LV_REQUIRED:int = 15;
      
      public static const FORGESTONE_ID:int = 44529;
      
      public static const QIANGHUASTONE_ID:int = 44530;
      
      public static const HORSE_SWFURL:String = "lang/ch/ZuoQi_c01_Imgs.swf";
      
      public static const STARSIGN_SWFURL:String = "lang/ch/XingZuo.swf";
      
      public static const HorsePanelFrame:String = "horsePanelFrame";
      
      public static const HorseLibPanelFrame:String = "horseLibPanelFrame";
      
      public static const MAXQIANGHUALV:int = 10;
      
      public static const MAXPARTLV:int = 150;
      
      public static const LIBBTN_ID:String = "15001";
      
      public static const LIBNUMPAGEITEM:int = 6;
      
      public static const LIB_FINAL_TOKEN:int = 0;
      
      private static var _tfA:Array = [];
      
      public function HorseConfig()
      {
         super();
      }
      
      public static function getAtbStr(dic:Dictionary, id:String, index:int = 3, insertChar1:String = "+", valueConverter:Function = null, c1:String = "#ffffff", c2:String = "#33ff33", c3:String = "#ffffff") : Array
      {
         var a:Array = null;
         var type:int = 0;
         var num:int = 0;
         var extraValue:Object = null;
         var str:String = null;
         var info:Array = dic[id];
         if(!info || info[index] == 0 || info[index] == "0")
         {
            return [""];
         }
         var splices:Array = Util.splicObj(info[index] as String,",_") as Array;
         var rs:Array = [];
         for each(a in splices)
         {
            type = int(a[0]);
            num = int(a[1]);
            extraValue = valueConverter != null ? valueConverter(num) : 0;
            str = "<font color=\'" + c1 + "\'>" + Data_lib.attribute[type][0] + "</font>" + "<font color=\'" + c3 + "\'>: " + "</font><font color=\'" + c2 + "\'>" + insertChar1 + (num + extraValue) + "</font>";
            if(num != 0)
            {
               rs.push(str);
            }
         }
         return rs;
      }
      
      public static function getTffs(dic:Dictionary, id:String, index:int = 3, insertChar1:String = "+", valueConverter:Function = null, c1:String = "#ffffff", c2:String = "#33ff33", c3:String = "#ffffff") : Array
      {
         var txt:String = null;
         var tf:MyTextField = null;
         var tfs:Array = [];
         var txts:Array = getAtbStr(dic,id,index,insertChar1,valueConverter,c1,c2,c3);
         for each(txt in txts)
         {
            tf = Boolean(_tfA.length) ? _tfA.pop() : ComponentUtil.getTextField("",null);
            tf.htmlText = txt;
            tfs.push(tf);
         }
         return tfs;
      }
      
      public static function clearTffs(a:Array) : void
      {
         var tf:MyTextField = null;
         if(Boolean(a))
         {
            for each(tf in a)
            {
               if(Boolean(tf.parent))
               {
                  tf.parent.removeChild(tf);
               }
               tf.autoSize = TextFieldAutoSize.LEFT;
               if(_tfA.indexOf(tf) == -1)
               {
                  _tfA.push(tf);
               }
            }
         }
      }
      
      public static function getDuanZaoRep() : String
      {
         return _duanZaoRep = _duanZaoRep || LangConfig.getWord("29459",2);
      }
      
      public static function sequenceLib() : Array
      {
         var k:String = null;
         if(!_sequenceLib)
         {
            _sequenceLib = [];
            for(k in Data_lib.zqtj)
            {
               _sequenceLib.push(k);
            }
            _sequenceLib.sort(sortFun);
         }
         return _sequenceLib;
      }
      
      private static function sortFun(a:int, b:int) : Number
      {
         return a - b;
      }
      
      public static function getPartNames() : Array
      {
         if(!_partNames)
         {
            _partNames = [LangConfig.getWord("29461",2),LangConfig.getWord("29462",2),LangConfig.getWord("29463",2)];
         }
         return _partNames;
      }
      
      public static function getPartAtbsLabel() : Array
      {
         if(!_partAtbsLabel)
         {
            _partAtbsLabel = [Data_lib.attribute[1][0],Data_lib.attribute[3][0],Data_lib.attribute[2][0]];
         }
         return _partAtbsLabel;
      }
      
      public static function getConvertsDic() : Dictionary
      {
         var k:String = null;
         var k2:int = 0;
         if(!_convertsDic)
         {
            _convertsDic = new Dictionary();
            for(k in Data_lib.zqtj)
            {
               k2 = int(Data_lib.zqtj[k][7]);
               _convertsDic[k2] = k;
            }
         }
         return _convertsDic;
      }
   }
}

