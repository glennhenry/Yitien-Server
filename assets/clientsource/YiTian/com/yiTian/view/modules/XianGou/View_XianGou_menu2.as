package com.yiTian.view.modules.XianGou
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_XianGou;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_XianGou;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Sprite;
   
   public class View_XianGou_menu2 extends Sprite
   {
      
      private static var _instance:View_XianGou_menu2;
      
      private var listItem0:View_XianGou_listItem2;
      
      private var listItem1:View_XianGou_listItem2;
      
      private var listItem2:View_XianGou_listItem2;
      
      private var isInit:Boolean;
      
      private var duringTime:MyTextField;
      
      public function View_XianGou_menu2()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         var arr:Array = [];
         arr.push(["lang/ch/BagBuy_Imgs.swf",this.loadCom,LangConfig.getWord("10550",1),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr);
      }
      
      public static function get instance() : View_XianGou_menu2
      {
         if(!_instance)
         {
            _instance = new View_XianGou_menu2();
         }
         return _instance;
      }
      
      private function loadCom(e:*) : void
      {
         Global.BagBuy_Imgsdm = e.applicationDomain;
         this.initUI2();
      }
      
      private function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back_HeiShi",[270,28,1,1],this,{
            "x":0,
            "y":0,
            "width":276,
            "height":389
         },Global.BagBuy_Imgsdm);
         ComponentUtil.getTextField("活动时间：",this,{
            "x":16,
            "y":349,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.duringTime = ComponentUtil.getTextField("",this,{
            "x":45,
            "y":364,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.listItem0 = new View_XianGou_listItem2();
         this.listItem0.x = 7;
         this.listItem0.y = 29;
         addChild(this.listItem0);
         this.listItem1 = new View_XianGou_listItem2();
         this.listItem1.x = 7;
         this.listItem1.y = 136;
         addChild(this.listItem1);
         this.listItem2 = new View_XianGou_listItem2();
         this.listItem2.x = 7;
         this.listItem2.y = 243;
         addChild(this.listItem2);
         this.isInit = true;
         Global.control.sendNotification(Enum_XianGou.INIT,null);
      }
      
      public function SetItem() : void
      {
         var i:int = 0;
         if(!this.isInit)
         {
            Global.control.registerCallBack(Enum_XianGou.INIT,this.SetItem);
            return;
         }
         Global.control.removeCallBack(Enum_XianGou.INIT,this.SetItem);
         if(this.duringTime.text != Model_XianGou.duringTime)
         {
            this.duringTime.htmlText = Model_XianGou.duringTime;
         }
         i = 0;
         while(i < 3)
         {
            if(Boolean(Model_XianGou.ItemArr[i]) && Model_XianGou.ItemArr[i][0] != 0)
            {
               View_XianGou_listItem2(this["listItem" + i]).visible = true;
               this.setListItem(i);
            }
            else
            {
               View_XianGou_listItem2(this["listItem" + i]).visible = false;
            }
            i++;
         }
      }
      
      private function setListItem(_listID:int) : void
      {
         var id:int = int(Model_XianGou.ItemArr[_listID][0]);
         View_XianGou_listItem2(this["listItem" + _listID]).id = id;
         View_XianGou_listItem2(this["listItem" + _listID]).xiangou = Data_lib.xiangou[id][22] - Model_XianGou.ItemArr[_listID][1];
         View_XianGou_listItem2(this["listItem" + _listID]).yuanjia = Data_lib.xiangou[id][20];
         View_XianGou_listItem2(this["listItem" + _listID]).heishijia = Data_lib.xiangou[id][21];
         View_XianGou_listItem2(this["listItem" + _listID]).kucun = Model_XianGou.ItemArr[_listID][2];
         View_XianGou_listItem2(this["listItem" + _listID]).item = [[Data_lib.xiangou[id][1],Data_lib.xiangou[id][2],Data_lib.xiangou[id][3]],[Data_lib.xiangou[id][4],Data_lib.xiangou[id][5],Data_lib.xiangou[id][6]],[Data_lib.xiangou[id][7],Data_lib.xiangou[id][8],Data_lib.xiangou[id][9]]];
      }
      
      public function FlyToBag(_id:int) : void
      {
         if(!this.isInit)
         {
            return;
         }
         var i:int = 0;
         while(i < 3)
         {
            if(this["listItem" + i].id == _id)
            {
               this["listItem" + i].FlyToBag();
            }
            i++;
         }
      }
   }
}

