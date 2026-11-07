package com.yiTian.data.vo
{
   import com.yiTian.data.Data_lib;
   
   public class Vo_petEquip extends Vo_grid
   {
      
      public var level:int;
      
      public var maxLevel:int;
      
      public var strength:int;
      
      public var nextstrength:int;
      
      public var isColor:int;
      
      public var type:int;
      
      public var shuxing1:String;
      
      public var shuxing2:String;
      
      public var shuxingvalue1:int;
      
      public var shuxingvalue2:int;
      
      public var iconUrl:String;
      
      public var nexticonUrl:String;
      
      public var jiexing:String = "";
      
      public function Vo_petEquip()
      {
         super();
      }
      
      public function init(lvl:int, _type:int, _maxlvl:int, _strength:int, _nextstrength:int = 0) : void
      {
         var num:int = 0;
         var num2:int = 0;
         this.jiexing = "";
         this.level = lvl;
         this.type = _type;
         this.maxLevel = _maxlvl;
         this.strength = _strength;
         this.nextstrength = _nextstrength;
         var str:String = Data_lib.chongwuqianghua[lvl][this.type - 1];
         var a:Array = str.split(",");
         var b:Array = a[0].split("_");
         var c:Array = a[1].split("_");
         this.shuxing1 = Data_lib.attribute[int(b[0])][0];
         this.shuxing2 = Data_lib.attribute[int(c[0])][0];
         this.shuxingvalue1 = b[1];
         this.shuxingvalue2 = c[1];
         this.isColor = Math.ceil(this.maxLevel / 20);
         if(this.isColor > 5)
         {
            this.isColor = 5;
         }
         if(this.level == 0)
         {
            num = 1;
            num2 = 0;
            this.jiexing += this.getjiexing(num) + "阶" + this.getjiexing(num2) + "星";
         }
         else if(this.level % 10 == 0)
         {
            num = this.level / 10;
            num2 = 10;
            this.jiexing += this.getjiexing(num) + "阶" + this.getjiexing(num2) + "星";
         }
         else
         {
            num = int(this.level / 10 + 1);
            num2 = int(this.level % 10);
            this.jiexing += this.getjiexing(num) + "阶" + this.getjiexing(num2) + "星";
         }
         var jie:int = this.maxLevel / 10;
         var nextJie:int = num + 1;
         if(jie > 13)
         {
            jie = 13;
         }
         if(nextJie > 13)
         {
            nextJie = 13;
         }
         switch(this.type)
         {
            case 1:
               str_name = "护符";
               this.iconUrl = "resource/image/icon/99600_" + jie + ".png";
               this.nexticonUrl = "resource/image/icon/99600_" + nextJie + ".png";
               break;
            case 2:
               str_name = "护肩";
               this.iconUrl = "resource/image/icon/99601_" + jie + ".png";
               this.nexticonUrl = "resource/image/icon/99601_" + nextJie + ".png";
               break;
            case 3:
               str_name = "头饰";
               this.iconUrl = "resource/image/icon/99602_" + jie + ".png";
               this.nexticonUrl = "resource/image/icon/99602_" + nextJie + ".png";
               break;
            case 4:
               str_name = "项圈";
               this.iconUrl = "resource/image/icon/99603_" + jie + ".png";
               this.nexticonUrl = "resource/image/icon/99603_" + nextJie + ".png";
         }
      }
      
      private function getjiexing(num:int) : String
      {
         var str:String = null;
         switch(num)
         {
            case 0:
               str = "零";
               break;
            case 1:
               str = "一";
               break;
            case 2:
               str = "二";
               break;
            case 3:
               str = "三";
               break;
            case 4:
               str = "四";
               break;
            case 5:
               str = "五";
               break;
            case 6:
               str = "六";
               break;
            case 7:
               str = "七";
               break;
            case 8:
               str = "八";
               break;
            case 9:
               str = "九";
               break;
            case 10:
               str = "十";
               break;
            case 11:
               str = "十一";
               break;
            case 12:
               str = "十二";
               break;
            case 13:
               str = "十三";
               break;
            case 14:
               str = "十四";
               break;
            case 15:
               str = "十五";
               break;
            case 16:
               str = "十六";
               break;
            case 17:
               str = "十七";
         }
         return str;
      }
   }
}

