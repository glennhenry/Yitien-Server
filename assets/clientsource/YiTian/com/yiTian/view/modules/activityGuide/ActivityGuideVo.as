package com.yiTian.view.modules.activityGuide
{
   import com.yiTian.data.vo.Vo_store;
   
   public class ActivityGuideVo
   {
      
      public var id:int;
      
      public var type:int;
      
      public var name:String;
      
      public var title:String;
      
      public var des:String;
      
      public var time:String;
      
      public var conditionOneDes:String;
      
      public var conditionOneReward:Array;
      
      public var conditionOneStatus:String;
      
      public var conditionTwoDes:String;
      
      public var conditionTwoReward:Array;
      
      public var conditionTwoStatus:String;
      
      public var conditionThreeDes:String;
      
      public var conditionThreeReward:Array;
      
      public var conditionThreeStatus:String;
      
      public var icon:String;
      
      public var themeOne:String;
      
      public var themeTwo:String;
      
      public var themeThree:String;
      
      public var shopArr:Array;
      
      public var isShowHot:int;
      
      public var allConditionDes:Array = [];
      
      public var allConditionReward:Array = [];
      
      public var allConditionStatus:Array = [];
      
      public var allConditionStatus2:Array = [[0,0],[0,0],[0,0]];
      
      public function ActivityGuideVo()
      {
         super();
      }
      
      public function init(data:Array) : void
      {
         this.id = data[22];
         this.type = data[1];
         this.name = data[2];
         this.title = data[3];
         this.des = data[4];
         this.time = data[5];
         this.conditionOneDes = this.getStr(data[6]);
         this.conditionOneReward = this.getArr(data[7]);
         this.conditionOneStatus = this.getStr(data[8]);
         this.conditionTwoDes = this.getStr(data[9]);
         this.conditionTwoReward = this.getArr(data[10]);
         this.conditionTwoStatus = this.getStr(data[11]);
         this.conditionThreeDes = this.getStr(data[12]);
         this.conditionThreeReward = this.getArr(data[13]);
         this.conditionThreeStatus = this.getStr(data[14]);
         this.icon = data[15];
         this.themeOne = this.getStr(data[16]);
         this.themeTwo = this.getStr(data[17]);
         this.themeThree = this.getStr(data[18]);
         this.shopArr = this.getShopArr(data[20]);
         this.isShowHot = data[21];
         this.allConditionDes = [this.conditionOneDes,this.conditionTwoDes,this.conditionThreeDes];
         this.allConditionStatus = [this.conditionOneStatus,this.conditionTwoStatus,this.conditionThreeStatus];
      }
      
      private function getShopArr(data:String) : Array
      {
         var i:int = 0;
         var vo_store:Vo_store = null;
         var temArr:Array = null;
         if(!data)
         {
            return [];
         }
         var arr:Array = this.getArr(data);
         if(!arr || !arr.length)
         {
            return [];
         }
         var len:int = int(arr.length);
         var storeArr:Array = [];
         i = 0;
         while(i < len)
         {
            temArr = [];
            vo_store = new Vo_store();
            vo_store.sign = 3;
            vo_store.position = 1;
            vo_store.wpid = arr[i][1];
            vo_store.type = arr[i][0];
            vo_store.sold_num = 1;
            vo_store.pre_price = arr[i][2];
            vo_store.now_price = arr[i][3];
            vo_store.price_type = 16000;
            vo_store.job = 0;
            vo_store.left_time = 21;
            vo_store.isHot = 1;
            vo_store.init_store();
            storeArr.push(vo_store);
            i++;
         }
         return storeArr;
      }
      
      private function getStr(data:String) : String
      {
         var str:String = null;
         var tempCache:Array = null;
         tempCache = data.split("_");
         if(tempCache[0] != "0")
         {
            if(Boolean(tempCache[1]))
            {
               str = tempCache[1];
            }
            else
            {
               str = tempCache[0];
            }
         }
         else
         {
            str = "";
         }
         return str;
      }
      
      public function getArr(data:String) : Array
      {
         var i:int = 0;
         var dataCache:Array = null;
         var tempCache:Array = null;
         var rewardArr:Array = [];
         tempCache = data.split(",");
         if(tempCache[0] != "0")
         {
            i = 0;
            while(i < tempCache.length)
            {
               dataCache = tempCache[i].toString().split("_");
               rewardArr.push(dataCache);
               i++;
            }
            this.allConditionReward.push(rewardArr);
            return rewardArr;
         }
         return [];
      }
   }
}

