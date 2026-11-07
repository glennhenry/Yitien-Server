package com.yiTian.view.modules.activityGuide
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   
   public class Model_ActivityGuide
   {
      
      public static var isWashActivity:Boolean;
      
      public static var petEquipVo:ActivityGuideVo;
      
      public static var stoneVo:ActivityGuideVo;
      
      public static var strengthenVo:ActivityGuideVo;
      
      public static var rewardIndex:int;
      
      public static var isShowIcon:Boolean;
      
      public static var chibangtiaojian:Array;
      
      public static var chongwujingxiu:Array;
      
      public static var activityData:Array = [];
      
      public static var activityVoData:Array = [];
      
      public static var activityVoDataById:Array = [];
      
      public function Model_ActivityGuide()
      {
         super();
      }
      
      public static function setActivityData() : void
      {
         var arr:Array = null;
         var i:String = null;
         for(i in Data_lib.hd)
         {
            if(int(Data_lib.hd[i][18]) == 1 || Data_lib.hd[i][18] == Global.pf)
            {
               arr = new Array();
               arr.push(i);
               arr.push(Data_lib.hd[i][0]);
               arr.push(Data_lib.hd[i][1]);
               arr.push(Data_lib.hd[i][2]);
               arr.push(Data_lib.hd[i][3]);
               arr.push(Data_lib.hd[i][4]);
               arr.push(Data_lib.hd[i][5]);
               arr.push(Data_lib.hd[i][6]);
               arr.push(Data_lib.hd[i][7]);
               arr.push(Data_lib.hd[i][8]);
               arr.push(Data_lib.hd[i][9]);
               arr.push(Data_lib.hd[i][10]);
               arr.push(Data_lib.hd[i][11]);
               arr.push(Data_lib.hd[i][12]);
               arr.push(Data_lib.hd[i][13]);
               arr.push(Data_lib.hd[i][14]);
               arr.push(Data_lib.hd[i][15]);
               arr.push(Data_lib.hd[i][16]);
               arr.push(Data_lib.hd[i][17]);
               arr.push(Data_lib.hd[i][18]);
               arr.push(Data_lib.hd[i][19]);
               arr.push(Data_lib.hd[i][20]);
               arr.push(Data_lib.hd[i][21]);
               arr.push(Data_lib.hd[i][22]);
               activityData.push(arr);
            }
         }
      }
      
      public static function setActivityVoData() : void
      {
         var i:int = 0;
         var vo:ActivityGuideVo = null;
         var len:int = int(activityData.length);
         i = 0;
         while(i < len)
         {
            vo = new ActivityGuideVo();
            vo.init(activityData[i]);
            activityVoData.push(vo);
            activityVoDataById[vo.id] = vo;
            if(vo.id == Enum_ActivityGuide.CHIBANG_ZHUTI)
            {
               addChibangConfig();
            }
            else if(vo.id == Enum_ActivityGuide.JINGXIU)
            {
               addJXConfig();
            }
            i++;
         }
      }
      
      private static function addChibangConfig() : void
      {
         var vo:ActivityGuideVo = null;
         var i:int = 0;
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.CHIBANG_ZHUTI] as ActivityGuideVo;
         chibangtiaojian = [];
         vo.allConditionReward = [];
         var arrs:Array = Data_lib.chibangzhuti.toArray();
         var len:int = int(arrs.length);
         var j:int = 0;
         while(j < len)
         {
            vo.getArr(arrs[j][2]);
            chibangtiaojian.push(arrs[j][1]);
            j++;
         }
         if(Boolean(vo))
         {
            vo.allConditionDes = [];
            i = 0;
            while(i < len)
            {
               vo.allConditionDes.push("翅膀等阶达到" + chibangtiaojian[i] + "阶");
               i++;
            }
         }
      }
      
      private static function addJXConfig() : void
      {
         var vo:ActivityGuideVo = null;
         var i:int = 0;
         vo = activityVoDataById[Enum_ActivityGuide.JINGXIU] as ActivityGuideVo;
         chongwujingxiu = [];
         vo.allConditionReward = [];
         var arrs:Array = Data_lib.chongwujingxiu.toArray();
         var len:int = int(arrs.length);
         var j:int = 0;
         while(j < len)
         {
            vo.getArr(arrs[j][2]);
            chongwujingxiu.push(arrs[j][1]);
            j++;
         }
         if(Boolean(vo))
         {
            vo.allConditionDes = [];
            i = 0;
            while(i < len)
            {
               vo.allConditionDes.push("提升精修值<font color=\"#f9ff00\">" + chongwujingxiu[i] + "</font>点");
               i++;
            }
         }
      }
      
      public static function getConsumeRewardStaticData() : Array
      {
         return Data_lib.xiaofeifanli.toArray();
      }
      
      public static function getStartTimeById(id:int) : Array
      {
         var i:String = null;
         var str:String = null;
         var vo:ActivityGuideVo = Model_ActivityGuide.activityVoDataById[id] as ActivityGuideVo;
         if(!vo)
         {
            for(i in Data_lib.hd)
            {
               if(Data_lib.hd[i][21] == id)
               {
                  str = Data_lib.hd[i][4];
                  break;
               }
            }
         }
         else
         {
            str = vo.time;
         }
         var p:RegExp = /\d{4}[Α-￥]\d{1,2}[Α-￥]\d{1,2}[Α-￥]\d{1,2}:\d{2}/ig;
         var result:Object = p.exec(str);
         var temp:Array = [];
         while(result != null)
         {
            temp.push(result);
            result = p.exec(str);
         }
         return temp;
      }
   }
}

