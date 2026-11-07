package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.utils.getTimer;
   
   public class View_BattleConfirmPanel extends Panel
   {
      
      private static const inputStr:String = "0";
      
      private var bg:DisplayObject;
      
      private var titleBg:DisplayObject;
      
      private var txtCityName:MyTextField;
      
      private var txtClanName:MyTextField;
      
      private var txtTimeName:MyTextField;
      
      private var txtSilverName:MyTextField;
      
      private var btnAuction:Button;
      
      private var container:Sprite;
      
      private var lastTime:uint;
      
      private var itemVec:Vector.<Child_BattleCostItem> = new Vector.<Child_BattleCostItem>();
      
      private var time:int = 3600;
      
      public var nowVo:CityVo;
      
      public function View_BattleConfirmPanel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_BattleConfirmPanel
      {
         return Singleton.getInstance(View_BattleConfirmPanel);
      }
      
      override protected function initStaticView() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":428,
            "height":320
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":380,
            "height":270
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":145,
            "width":360,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("List_BackD",[4,4,2,2],this,{
            "x":39,
            "y":211,
            "width":350,
            "height":29
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("List_BackD",[4,4,2,2],this,{
            "x":39,
            "y":178,
            "width":350,
            "height":29
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":36,
            "y":148,
            "width":356,
            "height":28
         },Global.Img_Cdm);
         ComponentUtil.getTextField("对战时间：",this,{
            "x":144,
            "y":87,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("城池名称：",this,{
            "x":144,
            "y":43,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("当前归属：",this,{
            "x":144,
            "y":65,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("排名",this,{
            "x":62,
            "y":151,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("帮派",this,{
            "x":159,
            "y":151,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("进攻资金",this,{
            "x":300,
            "y":151,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("进攻权争夺剩余时间：",this,{
            "x":170,
            "y":280,
            "color":11523767,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,this.bg.width,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":394,
            "y":6,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getTextField("银两",this,{
            "x":151,
            "y":248,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":181,
            "y":246,
            "width":100,
            "height":24
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.txtCityName = ComponentUtil.getTextField("城池中文名称",this,{
            "x":229,
            "y":43,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.txtClanName = ComponentUtil.getTextField("帮会中文名称",this,{
            "x":229,
            "y":65,
            "color":13424242,
            "size":12,
            "leading":9
         });
         this.txtTimeName = ComponentUtil.getTextField("00小时00分00秒",this,{
            "x":295,
            "y":280,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtSilverName = ComponentUtil.getTextField("0",this,{
            "x":185,
            "y":248,
            "color":16776960,
            "size":12,
            "leading":0,
            "type":TextFieldType.INPUT,
            "realWidth":102,
            "realHeight":18,
            "maxChars":10
         });
         this.txtSilverName.restrict = "0-9";
         this.txtSilverName.addEventListener(FocusEvent.FOCUS_IN,function(e:FocusEvent):void
         {
            var tt:MyTextField = e.target as MyTextField;
            if(tt.text == inputStr)
            {
               tt.text = "";
            }
         });
         this.txtSilverName.addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void
         {
            var tf:MyTextField = e.target as MyTextField;
            if(tf.text == "")
            {
               tf.text = inputStr;
            }
         });
         this.createItem();
      }
      
      private function initT() : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_XuanZhan",this,{
            "x":134,
            "y":5
         },Global.KFBang_CCdm);
         ComponentUtil.getBitmap("Text_ZhengDuo",this,{
            "x":144,
            "y":115
         },Global.KFBang_CCdm);
         this.container = new Sprite();
         addChild(this.container);
         ComponentUtil.getBitmap("Refresh_Img",this.container,{
            "x":353,
            "y":246
         },Global.KFBang_CCdm);
         this.btnAuction = ComponentUtil.getButton("竞拍","Button_GreenTwo",this,{
            "x":285,
            "y":245,
            "textColor":16184781
         },Global.Img_Cdm);
         this.container.buttonMode = true;
         this.container.addEventListener(MouseEvent.CLICK,this.onRefresh);
         this.btnAuction.addEventListener(MouseEvent.CLICK,this.onAuction);
      }
      
      private function createItem() : void
      {
         var i:int = 0;
         var item:Child_BattleCostItem = null;
         i = 0;
         while(i < Enum_CrossClanBattle.MAX_RANK_NUM)
         {
            item = new Child_BattleCostItem();
            addChild(item);
            this.itemVec.push(item);
            item.x = 62;
            item.y = 184 + i * 31;
            i++;
         }
      }
      
      private function onRefresh(e:MouseEvent) : void
      {
         CrossClanBattleCGMessage.CG_BATTLE_CONFIRM(this.nowVo.id);
      }
      
      private function onAuction(e:MouseEvent) : void
      {
         var cityId:int = 0;
         var arr:Array = null;
         var i:int = 0;
         var j:int = 0;
         if(Boolean(GameUnitManager.hero.crossClanIdArr.length))
         {
            i = 0;
            loop0:
            while(i < GameUnitManager.hero.crossClanIdArr.length)
            {
               cityId = int(GameUnitManager.hero.crossClanIdArr[i]);
               arr = Model_CrossClanBattle.allStaticCityData[cityId][Enum_CrossClanBattle.CITY_NEAR].toString().split(",");
               j = 0;
               while(true)
               {
                  if(j >= arr.length)
                  {
                     i++;
                     continue loop0;
                  }
                  if(arr[j] == this.nowVo.id)
                  {
                     break;
                  }
                  j++;
               }
               CrossClanBattleCGMessage.CG_AUCTION(this.nowVo.id,this.txtSilverName.text);
               return;
            }
            UIManager.centerBroadcast.addMsg("竞拍的城池必须是已占领城池的相邻城池");
         }
         else
         {
            CrossClanBattleCGMessage.CG_AUCTION(this.nowVo.id,this.txtSilverName.text);
         }
      }
      
      public function updateItem(data:Array) : void
      {
         var i:int = 0;
         var len:int = int(data.length);
         i = 0;
         while(i < Enum_CrossClanBattle.MAX_RANK_NUM)
         {
            if(Boolean(this.itemVec[i]))
            {
               if(i < len)
               {
                  this.itemVec[i].visible = true;
                  this.itemVec[i].update(data[i]);
               }
               else
               {
                  this.itemVec[i].visible = false;
               }
            }
            i++;
         }
      }
      
      public function show(vo:CityVo) : void
      {
         this.visible = true;
         this.nowVo = vo;
         var arr:Array = [];
         this.txtCityName.htmlText = vo.name;
         this.txtClanName.htmlText = Model_heFu.repNameUseSerID(vo.clanName) + "\n" + Model_CrossClanBattle.weekArr[vo.battleTime - 1];
         this.setTxtTime();
         if(vo.maxSpendSilver == 0)
         {
            arr = [];
         }
         else if(vo.secondSpendSilver == 0)
         {
            arr = [[1,vo.maxSpendclanName,vo.maxSpendSilver]];
         }
         else
         {
            arr = [[1,vo.maxSpendclanName,vo.maxSpendSilver],[2,vo.secondSpendclanName,vo.secondSpendSilver]];
         }
         this.updateItem(arr);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
      }
      
      private function setTxtTime() : void
      {
         var timeStr:String = null;
         if(Boolean(this.nowVo))
         {
            timeStr = DateUtil.getMSBySecond4(this.nowVo.endTime - Model_CrossClanBattle.serverTime < 0 ? 0 : this.nowVo.endTime - Model_CrossClanBattle.serverTime);
            this.txtTimeName.htmlText = timeStr;
            if(timeStr == "")
            {
               this.txtTimeName.htmlText = "竞拍已结束";
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
            }
         }
      }
      
      private function frameStep() : void
      {
         var now:uint = uint(getTimer());
         if(now - this.lastTime > 60000)
         {
            this.setTxtTime();
            this.lastTime = now;
         }
      }
      
      public function hide(prm:* = null) : void
      {
         this.visible = false;
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.KFBang_CCdm)
            {
               this.load();
            }
            else if(!this.titleBg)
            {
               this.initT();
            }
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push(["lang/ch/KFBang_CC.swf",this.onComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function onComplete(info:Object) : void
      {
         Global.KFBang_CCdm = info.applicationDomain;
         this.initT();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      override public function get height() : Number
      {
         if(!this.bg)
         {
            return super.height;
         }
         return this.bg.height;
      }
      
      override public function get width() : Number
      {
         if(!this.bg)
         {
            return super.width;
         }
         return this.bg.width;
      }
   }
}

