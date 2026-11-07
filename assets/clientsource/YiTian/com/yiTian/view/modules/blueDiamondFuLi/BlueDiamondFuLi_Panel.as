package com.yiTian.view.modules.blueDiamondFuLi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class BlueDiamondFuLi_Panel extends Panel123
   {
      
      private static var _instance:BlueDiamondFuLi_Panel;
      
      public static var data_arr:Array = [];
      
      public static var _awardNum:int = 0;
      
      public static var getNum:int = 0;
      
      public static var unReach:int = 0;
      
      public static var INDEX:int = 0;
      
      private var closeBtn:Button;
      
      private var con:Sprite;
      
      private var itemVec:Vector.<blueDia_Item> = new Vector.<blueDia_Item>(4);
      
      private var _isUpdated:Boolean = false;
      
      private var Button_Open:Button;
      
      private var Button_OpenYear:Button;
      
      private var _init:Boolean = false;
      
      private var vo:Vo_blueDia;
      
      public function BlueDiamondFuLi_Panel()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/lanzuanfuli.swf","LZFLdm");
      }
      
      public static function get instance() : BlueDiamondFuLi_Panel
      {
         if(!_instance)
         {
            _instance = new BlueDiamondFuLi_Panel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var des:MyTextField;
         var str:String;
         var itemDic:DictionaryTabel;
         var len:int;
         var i:int;
         var btnStr1:String = null;
         var btnStr2:String = null;
         var discountId:String = null;
         var item:blueDia_Item = null;
         var itemStr:String = null;
         var count:int = 0;
         var itemArr:Array = null;
         var allArr:Array = null;
         var j:int = 0;
         var sArr:Array = null;
         move = new Rectangle(0,0,682,38);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":688,
            "height":477
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":638,
            "height":427
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":50,
            "width":614,
            "height":139
         },Global.LZFLdm);
         ComponentUtil.getBitmap("Title_LZFL",this,{
            "x":264,
            "y":5
         },Global.LZFLdm);
         ComponentUtil.getBitmap("Back_LZJLD",this,{
            "x":35,
            "y":196
         },Global.LZFLdm);
         ComponentUtil.getBitmap("Back_LZWZD",this,{
            "x":44,
            "y":59
         },Global.LZFLdm);
         ComponentUtil.getBitmap("Text_LZJX",this,{
            "x":126,
            "y":75
         },Global.LZFLdm);
         ComponentUtil.getTextField("全服限领：",this,{
            "x":59,
            "y":114,
            "color":16777215,
            "size":14,
            "leading":4
         });
         ComponentUtil.getTextField("活动规则：",this,{
            "x":59,
            "y":137,
            "color":16777215,
            "size":14,
            "leading":4
         });
         des = ComponentUtil.getTextField("",this,{
            "x":130,
            "y":137,
            "color":16777215,
            "size":12,
            "leading":5
         });
         str = "<font color=\'#ffffff\'>仅在&nbsp;<font color=\'#ff0000\' size=\'14\' style=\'font-weight:normal\'>本页面开通或续费蓝钻</font>&nbsp;达到满足一定次数，可以领取对应奖励一份，每个奖励只能领" + "\n一次，<font color=\'#ff0000\' size=\'14\' style=\'font-weight:normal\'>此活动不计入其他蓝钻活动。注：续费12次之后，再续费不会获得奖励。<font></font>";
         des.htmlText = str;
         ComponentUtil.getTextField("全服限领36000次",this,{
            "x":129,
            "y":114,
            "color":327424,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField("条件",this,{
            "x":105,
            "y":199,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("奖励",this,{
            "x":345,
            "y":199,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("操作",this,{
            "x":567,
            "y":199,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.con = new Sprite();
         addChild(this.con);
         itemDic = Data_lib.lanzuanfuli;
         len = int(itemDic.getLength());
         i = 0;
         while(i < len)
         {
            item = new blueDia_Item();
            ComponentUtil.setPropertie(item,{
               "x":68,
               "y":224 + i * 50
            });
            itemStr = itemDic[i + 1][1];
            count = int(itemDic[i + 1][0]);
            itemArr = itemStr.split(",");
            allArr = [];
            j = 0;
            while(j < itemArr.length)
            {
               sArr = itemArr[j].split("_");
               allArr.push(sArr);
               j++;
            }
            item.initData(allArr,count,i);
            this.con.addChild(item);
            this.itemVec[i] = item;
            i++;
         }
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":635,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn.callBack = this.closeMenu;
         if(GameUnitManager.hero.ylDiaLvl > 0)
         {
            btnStr1 = "Button_BuleXF";
            btnStr2 = "Button_GHYKT";
         }
         else
         {
            btnStr1 = "Button_BuleKT";
            btnStr2 = "Button_GHYKT";
         }
         this.Button_Open = ComponentUtil.getButton("",btnStr1,this,{
            "x":131,
            "y":426,
            "textColor":16771436
         },Global.LZFLdm);
         this.Button_OpenYear = ComponentUtil.getButton("",btnStr2,this,{
            "x":368,
            "y":426,
            "textColor":16771436
         },Global.LZFLdm);
         this.setMouseOverOut(this.Button_Open);
         this.setMouseOverOut(this.Button_OpenYear);
         discountId = "UM140414114125393";
         this.Button_Open.addEventListener(MouseEvent.CLICK,function():void
         {
            if(Global.pf == "qqgame")
            {
               View_hzTribute.sendType = "self";
               YellowDiaManager.buy(false,true,discountId);
            }
         });
         this.Button_OpenYear.addEventListener(MouseEvent.CLICK,function():void
         {
            if(Global.pf == "qqgame")
            {
               View_hzTribute.sendType = "send";
               YellowDiaManager.buy(false,true,discountId);
            }
         });
         this._init = true;
         if(this._init && Boolean(this.vo))
         {
            this.update(this.vo.time,this.vo.statusArr);
         }
      }
      
      public function setMouseOverOut(btn:Button) : void
      {
         btn.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
         {
            e.target.filters = Util.glowFFFFFF;
         });
         btn.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
         {
            e.target.filters = [];
         });
      }
      
      public function getPanelItem() : void
      {
         var tempItem:blueDia_Item = this.itemVec[BlueDiamondFuLi_Panel.INDEX];
         tempItem.getAwards();
      }
      
      public function update(time:int, statusArr:Array) : void
      {
         var getIndex:int = 0;
         this.vo = new Vo_blueDia();
         this.vo.time = time;
         this.vo.statusArr = statusArr.concat();
         if(!this._init)
         {
            return;
         }
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            this.itemVec[i].checkStatus(time);
            i++;
         }
         var j:int = 0;
         while(j < statusArr.length)
         {
            getIndex = statusArr[j] - 1;
            this.itemVec[getIndex].updateStatus(2);
            j++;
         }
         if(statusArr.length == this.itemVec.length)
         {
            UIManager.mainUiBtnContainer.removeBTN(View_BlueDiamondFuLi_icon.instance);
         }
      }
      
      private function closeMenu(e:*) : void
      {
         visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

