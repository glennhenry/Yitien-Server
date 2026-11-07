package com.yiTian.view.modules.actions.jiJin
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.actions.jiJin.chongzhi.View_chongzhi;
   import flash.utils.Dictionary;
   
   public class FundMter
   {
      
      public static var czPan:ChongZhi;
      
      public static var _index:int;
      
      public static var _chongZhiIndex:int;
      
      public static var getJiJing:int;
      
      public static var baiJinLvl:int;
      
      public static var fundOwn:int;
      
      public static var chongZhiPan:View_chongzhi;
      
      public static var isShowChongzhiIng:Boolean;
      
      public static var jiJinArr:Array = ["初级基金","中级基金","高级基金"];
      
      public static var fanLiArr:Array = [[500,600],[2000,3000],[5000,10000]];
      
      public static var colorArr:Array = ["#04ffff","#04ff00","#33CCFF","#de45c7"];
      
      public static var colorArrX:Array = ["0x04ff00","0x33CCFF","0xde45c7"];
      
      public static var daysArr:Array = [7,15,21,30,45,60];
      
      public static var EnumDays:Array = [0,1,2,4,7];
      
      public static var yuanArr:Array = [10,100,1000,10000];
      
      public static var sendArr:Array = [0,2,5,12];
      
      public static var idArrData:Array = [{
         "id":0,
         "count":0
      },{
         "id":1,
         "count":2
      },{
         "id":2,
         "count":5
      },{
         "id":3,
         "count":12
      }];
      
      public static var zeRoArr:Array = ["0","00","000","0000"];
      
      public static var chongZhiId:Array = [];
      
      public static var wuHunArr:Array = ["1级白金武魂","2级白金武魂","3级白金武魂"];
      
      public static var moneyArr:Array = [100000,200000,1000000];
      
      public static var perArr:Array = ["0%","10%","30%","50%"];
      
      public static var dataArrSave:int = 0;
      
      private static var _typeArr:Array = [];
      
      public static var isOpenPan:Boolean = false;
      
      public static var isOpenFundStore:Boolean = false;
      
      public static var isOpenChongZhi:Boolean = false;
      
      public static var desCripJJ:String = HtmlUtil.font("1级白金武魂","#04ff00") + "购买基金可额外获得" + HtmlUtil.font("5%","#ff7700") + "返利\n" + HtmlUtil.font("2级白金武魂","#33CCFF") + "购买基金可额外获得" + HtmlUtil.font("10%","#ff7700") + "返利\n" + HtmlUtil.font("3级白金武魂","#de45c7") + "购买基金可额外获得" + HtmlUtil.font("15%","#ff7700") + "返利";
      
      public function FundMter()
      {
         super();
      }
      
      public static function getVoArr(_index:int) : Vo_item
      {
         var i:int = 0;
         var _vo:Vo_item = null;
         if(!_typeArr || !_typeArr.length)
         {
            i = 0;
            while(i < 3)
            {
               _vo = new Vo_item();
               _vo.id = 44526 + i;
               _vo.Init_lib();
               _typeArr.push(_vo);
               i++;
            }
         }
         return _typeArr[_index - 1] as Vo_item;
      }
      
      public static function getDicItem(jj:int, _type:int, _lvl:int) : String
      {
         var dic:Dictionary = Data_lib.jijinbiao;
         var ss:String = Data_lib.jijinbiao[2][_lvl - 1];
         var _arr:Array = ss.split("_");
         var per:int = int(_arr[_type - 1]);
         return per.toString();
      }
      
      public static function initChongZhi() : void
      {
         var pan:View_chongzhi = null;
         pan = Singleton.getInstance(View_chongzhi) as View_chongzhi;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
         {
            chongZhiPan = pan;
         });
      }
   }
}

