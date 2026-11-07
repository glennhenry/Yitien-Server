package com.yiTian.view.modules.WuLinMiXin
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_WuLinMiXin;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   
   public class View_WuLinMiXin_MainMenu extends Panel123
   {
      
      private static var _instance:View_WuLinMiXin_MainMenu;
      
      public var card_0:WuLinMiXin_Card;
      
      public var card_1:WuLinMiXin_Card;
      
      public var card_2:WuLinMiXin_Card;
      
      public var card_3:WuLinMiXin_Card;
      
      public var card_4:WuLinMiXin_Card;
      
      public var card_5:WuLinMiXin_Card;
      
      public var card_6:WuLinMiXin_Card;
      
      public var card_7:WuLinMiXin_Card;
      
      public var card_8:WuLinMiXin_Card;
      
      public var card_9:WuLinMiXin_Card;
      
      public var card_10:WuLinMiXin_Card;
      
      public var card_11:WuLinMiXin_Card;
      
      private var prizeOwnerTxt:MyTextField;
      
      private var itemRecord_player:Array;
      
      private var itemRecord_kind:Array;
      
      private var itemRecord_item:Array;
      
      private var itemRecordBtn:TabButton;
      
      private var prizeRecord_player:Array;
      
      private var prizeRecord_kind:Array;
      
      private var prizeRecord_item:Array;
      
      private var prizeRecordBtn:TabButton;
      
      private var recordTxt:MyTextField;
      
      private var openAgainCostTxt:MyTextField;
      
      private var prizePoolTxt:MyTextField;
      
      private var prize0:Bitmap;
      
      private var prize1:Bitmap;
      
      private var prize2:Bitmap;
      
      private var prize3:Bitmap;
      
      private var prize4:Bitmap;
      
      private var prize5:Bitmap;
      
      private var prize6:Bitmap;
      
      public function View_WuLinMiXin_MainMenu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/WLMiXin.swf","WLMiXindm");
      }
      
      public static function get instance() : View_WuLinMiXin_MainMenu
      {
         if(!_instance)
         {
            _instance = new View_WuLinMiXin_MainMenu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var j:int = 0;
         var str:String = null;
         var bitmap:Bitmap = null;
         var spr:Sprite = null;
         move = new Rectangle(0,0,810,36);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":789,
            "height":456
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":39,
            "width":741,
            "height":406
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":27,
            "y":41,
            "width":202,
            "height":402
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_SQZZDJDZ",this,{
            "x":29,
            "y":42
         },Global.WLMiXindm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":231,
            "y":42,
            "width":531,
            "height":400
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_HuaWen01",[19,20,1,1],this,{
            "x":28,
            "y":42,
            "width":200,
            "height":188
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("Title_WLMiXin",this,{
            "x":354,
            "y":2
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("BG_BaoXiang",this,{
            "x":85,
            "y":89
         },Global.WLMiXindm);
         this.prizeOwnerTxt = ComponentUtil.getTextField("",this,{
            "x":46,
            "y":180,
            "color":13882321,
            "size":12,
            "leading":4,
            "realWidth":165,
            "multiline":true
         });
         this.prizeOwnerTxt.align = "center";
         ComponentUtil.getScaleBitmap("Back_DJJiLu",[102,1,1,1],this,{
            "x":28,
            "y":230,
            "width":200,
            "height":24
         },Global.WLMiXindm);
         this.itemRecordBtn = ComponentUtil.getTabButton("翻牌记录","TabButton_Four",this,{
            "x":35,
            "y":231,
            "textColor":16772813,
            "chooseColor":16771436
         },Global.Img_Cdm);
         this.itemRecordBtn.addEventListener(MouseEvent.CLICK,this.onSelectRecord);
         this.prizeRecordBtn = ComponentUtil.getTabButton("大奖记录","TabButton_Four",this,{
            "x":113,
            "y":231,
            "textColor":16772813,
            "chooseColor":16771436
         },Global.Img_Cdm);
         this.prizeRecordBtn.addEventListener(MouseEvent.CLICK,this.onSelectRecord);
         this.recordTxt = ComponentUtil.getTextField("",this,{
            "x":34,
            "y":263,
            "color":16776960,
            "size":12,
            "leading":2
         });
         this.recordTxt.multiline = true;
         ComponentUtil.getBitmap("BG_FaGuang",this,{
            "x":28,
            "y":397
         },Global.WLMiXindm);
         ComponentUtil.getScaleBitmap("Back_Light",[50,1,1,1],this,{
            "x":559,
            "y":44,
            "width":202,
            "height":329
         },Global.WLMiXindm);
         ComponentUtil.getScaleBitmap("Back_GiftBg",[246,1,1,1],this,{
            "x":243,
            "y":377,
            "width":506,
            "height":55
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("BG_JiangJinChi",this,{
            "x":554,
            "y":265
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("MuBu_Riht",this,{
            "x":674,
            "y":44
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("MuBu_Left",this,{
            "x":232,
            "y":44
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("MuBu_Top2",this,{
            "x":299,
            "y":44
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("MuBu_Top2",this,{
            "x":376,
            "y":44
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("MuBu_Top2",this,{
            "x":620,
            "y":44
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("MuBu_Top2",this,{
            "x":542,
            "y":44
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("MuBu_Top1",this,{
            "x":457,
            "y":44
         },Global.WLMiXindm);
         this.openAgainCostTxt = ComponentUtil.getTextField("",this,{
            "x":582,
            "y":104,
            "color":13882321,
            "size":14,
            "leading":0
         });
         ComponentUtil.getBitmap("Text_DQJJC",this,{
            "x":599,
            "y":173
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("Text_SYJiangPin",this,{
            "x":255,
            "y":347
         },Global.WLMiXindm);
         ComponentUtil.getScaleBitmap("Back_JiangJinChi",[4,5,1,1],this,{
            "x":583,
            "y":204,
            "width":150,
            "height":32
         },Global.WLMiXindm);
         this.prizePoolTxt = ComponentUtil.getTextField("0123456789",this,{
            "x":583,
            "y":204,
            "color":16777215,
            "size":22,
            "leading":0,
            "realWidth":150
         });
         this.prizePoolTxt.align = "center";
         this.prizePoolTxt.filters = [new GlowFilter(16711680,1,2,2)];
         this.prize0 = ComponentUtil.getBitmap("Text_WPK",this,{
            "x":255,
            "y":383
         },Global.WLMiXindm);
         this.prize1 = ComponentUtil.getBitmap("Text_WPK",this,{
            "x":300,
            "y":383
         },Global.WLMiXindm);
         this.prize2 = ComponentUtil.getBitmap("Text_WPK",this,{
            "x":345,
            "y":383
         },Global.WLMiXindm);
         this.prize3 = ComponentUtil.getBitmap("Text_WPK",this,{
            "x":390,
            "y":383
         },Global.WLMiXindm);
         this.prize4 = ComponentUtil.getBitmap("Text_WPK",this,{
            "x":435,
            "y":383
         },Global.WLMiXindm);
         this.prize5 = ComponentUtil.getBitmap("Text_WPK",this,{
            "x":480,
            "y":383
         },Global.WLMiXindm);
         this.prize6 = ComponentUtil.getBitmap("Text_WPK",this,{
            "x":525,
            "y":383
         },Global.WLMiXindm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":752,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,this.onClose);
         this.card_0 = new WuLinMiXin_Card(0);
         this.card_0.x = 253;
         this.card_0.y = 61;
         this.card_1 = new WuLinMiXin_Card(1);
         this.card_1.x = 331;
         this.card_1.y = 61;
         this.card_2 = new WuLinMiXin_Card(2);
         this.card_2.x = 409;
         this.card_2.y = 61;
         this.card_3 = new WuLinMiXin_Card(3);
         this.card_3.x = 485;
         this.card_3.y = 61;
         this.card_4 = new WuLinMiXin_Card(4);
         this.card_4.x = 253;
         this.card_4.y = 152;
         this.card_5 = new WuLinMiXin_Card(5);
         this.card_5.x = 331;
         this.card_5.y = 152;
         this.card_6 = new WuLinMiXin_Card(6);
         this.card_6.x = 409;
         this.card_6.y = 152;
         this.card_7 = new WuLinMiXin_Card(7);
         this.card_7.x = 485;
         this.card_7.y = 152;
         this.card_8 = new WuLinMiXin_Card(8);
         this.card_8.x = 253;
         this.card_8.y = 243;
         this.card_9 = new WuLinMiXin_Card(9);
         this.card_9.x = 331;
         this.card_9.y = 243;
         this.card_10 = new WuLinMiXin_Card(10);
         this.card_10.x = 409;
         this.card_10.y = 243;
         this.card_11 = new WuLinMiXin_Card(11);
         this.card_11.x = 485;
         this.card_11.y = 243;
         var i:int = 0;
         while(i < 12)
         {
            this.addChild(this["card_" + i]);
            i++;
         }
         j = 0;
         while(j < 7)
         {
            str = Data_lib.wulinmixin_prize[j + 1][0];
            bitmap = Utils.getLoadBitmap("resource/image/icon/" + str + ".png");
            spr = new Sprite();
            spr.addChild(bitmap);
            this.addChild(spr);
            TipManager.bind(spr,Data_lib.wulinmixin_prize[j + 1][1]);
            bitmap.x = this["prize" + j].x + 5;
            bitmap.y = this["prize" + j].y + 5;
            j++;
         }
      }
      
      public function UpdatePrizeOwner(_name:String, num:int) : void
      {
         trace("****",_name,num);
         if(_name == "" || num == 0)
         {
            return;
         }
         this.prizeOwnerTxt.htmlText = LangConfig.reTxt("恭喜<font color=\'#ffff00\'>{0}</font><font color=\'#ffffff\'>获得至尊大奖</font><br/>" + "共计<font color=\'#34d315\'>{1}</font><font color=\'#ffffff\'>银两</font>",_name,num);
      }
      
      public function UpdateItemRecord(_nameArr:Array, _kindArr:Array, _itemArr:Array) : void
      {
         this.itemRecord_player = _nameArr;
         this.itemRecord_kind = _kindArr;
         this.itemRecord_item = _itemArr;
         this.itemRecordBtn.choose = true;
         this.prizeRecordBtn.choose = false;
         this.updateRecord(this.itemRecord_player,this.itemRecord_kind,this.itemRecord_item);
      }
      
      public function UpdatePrizeRecord(_nameArr:Array, _kindArr:Array, _moneyArr:Array) : void
      {
         this.prizeRecord_player = _nameArr;
         this.prizeRecord_kind = _kindArr;
         this.prizeRecord_item = _moneyArr;
      }
      
      private function onSelectRecord(e:MouseEvent) : void
      {
         if(this.itemRecordBtn == e.currentTarget)
         {
            this.itemRecordBtn.choose = true;
            this.prizeRecordBtn.choose = false;
            this.updateRecord(this.itemRecord_player,this.itemRecord_kind,this.itemRecord_item);
         }
         else if(this.prizeRecordBtn == e.currentTarget)
         {
            this.itemRecordBtn.choose = false;
            this.prizeRecordBtn.choose = true;
            this.updateRecord(this.prizeRecord_player,this.prizeRecord_kind,this.prizeRecord_item);
         }
      }
      
      private function updateRecord(arr1:Array, arr2:Array, arr3:Array) : void
      {
         var i:int = 0;
         var key:int = 0;
         var str:String = "";
         var str_kind:String = "";
         var prize:String = "";
         i = 0;
         while(i < arr1.length)
         {
            switch(arr2[i])
            {
               case 2:
                  prize = String(arr3[i]);
                  str_kind = "银子";
                  break;
               case 3:
                  key = int(arr3[i]);
                  prize = Enum_BroadCastTool.instance.getColorStr(Data_lib.item[String(Data_lib.wulinmixin[key][2]).split("_")[1]][1],Data_lib.item[String(Data_lib.wulinmixin[key][2]).split("_")[1]][12]);
                  str_kind = "";
                  break;
               case 4:
                  prize = String(arr3[i]);
                  str_kind = "绑银";
                  break;
               case 5:
                  prize = String(arr3[i]);
                  str_kind = "元宝";
                  break;
               case 1:
            }
            str += LangConfig.reTxt("<font color=\'#ffff00\'>{0}</font><font color=\'#ffffff\'>获得</font>" + "{1}<font color=\'#ffffff\'>{2}</font><br/>",arr1[i],prize,str_kind);
            i++;
         }
         this.recordTxt.htmlText = str;
      }
      
      public function UpdatePrizePool(_num:int) : void
      {
         this.prizePoolTxt.text = String(_num);
      }
      
      public function AddPool(_num:int) : void
      {
         this.prizePoolTxt.text = String(int(this.prizePoolTxt.text) + _num);
      }
      
      public function UpdateOpenTimes() : void
      {
         trace("*@@@",Model_WuLinMiXin.freeOpenTimes,Model_WuLinMiXin.haveOpenTimes);
         if(Model_WuLinMiXin.freeOpenTimes > 0)
         {
            this.openAgainCostTxt.htmlText = LangConfig.reTxt("剩余免费翻牌次数<font color=\'#ffff00\'>{0}次</font>",Model_WuLinMiXin.freeOpenTimes);
         }
         else if(Model_WuLinMiXin.haveOpenTimes < 10)
         {
            this.openAgainCostTxt.htmlText = LangConfig.reTxt("花费<font color=\'#ffff00\'>{0}元宝</font>可再翻一次",Data_lib.wulinmixin_cost[Model_WuLinMiXin.haveOpenTimes + 1][0]);
         }
         else
         {
            this.openAgainCostTxt.htmlText = "<font color=\'#ffff00\'>今日抽取次数已用完</font>";
         }
      }
      
      override public function resetPosition() : void
      {
         this.x = (Global.stage.stageWidth - width) / 2;
         this.y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function setCardStatus(_id:int, _status:int, _isPlay:Boolean = false) : void
      {
         this["card_" + _id].setStatus(_status,_isPlay);
      }
      
      public function OpenAnimation(_id:int, dis:DisplayObject) : void
      {
         this["card_" + _id].flyToBag(dis);
      }
      
      private function onClose(e:MouseEvent) : void
      {
         this.visible = false;
      }
   }
}

