package com.yiTian.view.modules.battle
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_thing_type;
   import com.yiTian.data.model.Model_Battle;
   import com.yiTian.data.vo.Vo_battle_lib_data;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.external.ExternalInterface;
   import flash.text.TextFieldAutoSize;
   
   public class View_battleReplay extends Panel
   {
      
      private static var _discriptArr:Array;
      
      private var bg:DisplayObject;
      
      private var bm_sf:Bitmap;
      
      private var tf_info:MyTextField;
      
      private var tf_lose:MyTextField;
      
      private var tf_gain:MyTextField;
      
      private var btn_ok:Button;
      
      private var btn_share:Button;
      
      private var btn_replay:Button;
      
      private var gridContainer:Sprite;
      
      private var tfContainer:Sprite;
      
      private var txtNum:int = 0;
      
      private var gainStr:String;
      
      private var _obj:Object;
      
      private var itemLen:int = 0;
      
      private var gridArr:Array = [];
      
      public function View_battleReplay()
      {
         super();
      }
      
      public static function get discriptArr() : Array
      {
         if(!_discriptArr)
         {
            _discriptArr = [LangConfig.getWord("29195",2),LangConfig.getWord("29196",2),LangConfig.getWord("29197",2),LangConfig.getWord("29198",2),LangConfig.getWord("29199",2),LangConfig.getWord("29200",2),LangConfig.getWord("29201",2),LangConfig.getWord("29202",2),LangConfig.getWord("29203",2),LangConfig.getWord("29209",2)];
         }
         return _discriptArr;
      }
      
      override protected function initStaticView() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back_Invite",[5,5,6,6],this,{
            "x":0,
            "y":1,
            "width":350,
            "height":210
         },Global.Img_Cdm);
         var w:Number = this.bg.width;
         var h:Number = this.bg.height;
         this.tf_info = ComponentUtil.getTextField("",this,{
            "y":55,
            "realWidth":width,
            "bold":true,
            "size":14,
            "color":14013809
         });
         this.tf_info.autoSize = TextFieldAutoSize.CENTER;
         this.tf_info.mouseEnabled = true;
         this.tf_gain = ComponentUtil.getTextField("",this,{
            "y":75,
            "realWidth":width,
            "bold":true,
            "color":16043313
         });
         this.tf_gain.autoSize = TextFieldAutoSize.CENTER;
         this.btn_ok = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "y":153,
            "x":139
         },Global.Img_Cdm);
         this.btn_ok.x = (width - this.btn_ok.width) / 2;
         this.btn_share = ComponentUtil.getButton(LangConfig.getWord("29189",2),"Button_Two",this,{
            "y":163,
            "x":244
         },Global.Img_Cdm);
         if(Global.pf == "qqgame")
         {
            this.btn_share.visible = false;
         }
         this.btn_replay = ComponentUtil.getButton(LangConfig.getWord("29188",2),"Button_Two",this,{
            "y":163,
            "x":299
         },Global.Img_Cdm);
         this.gridContainer = new Sprite();
         addChild(this.gridContainer);
         this.tfContainer = new Sprite();
         addChild(this.tfContainer);
         this.bm_sf = new Bitmap();
         this.bm_sf.x = (this.bg.width - 163) / 2;
         this.bm_sf.y = 15;
         addChild(this.bm_sf);
      }
      
      public function set times(value:int) : void
      {
         value = 0;
         if(value == 1)
         {
            this.btn_share.visible = false;
            this.btn_ok.label = LangConfig.getWord("29189",2);
         }
         else
         {
            this.btn_share.visible = true;
            this.btn_ok.label = LangConfig.getWord("29034",2);
         }
         if(Global.pf == "qqgame")
         {
            this.btn_share.visible = false;
         }
      }
      
      private function btnClickHd(e:MouseEvent) : void
      {
         var btn:Button = e.target as Button;
         switch(btn.label)
         {
            case LangConfig.getWord("29034",2):
               this.okClickHd();
               break;
            case LangConfig.getWord("29189",2):
               this.shareClickHd();
               break;
            case LangConfig.getWord("29188",2):
               this.replayClickHd();
         }
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.btn_ok.callBack = this.btn_share.callBack = this.btn_replay.callBack = this.btnClickHd;
         this.tf_info.addEventListener(TextEvent.LINK,this.infoLinkHd);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_START,this.onBPS);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,this.onBPE);
      }
      
      public function clearTxt() : void
      {
         var _temp_1:* = this.tf_gain;
         this.gainStr = "";
         _temp_1.text = "";
         this.tf_info.text = "";
      }
      
      public function addTxt(str:String, override:Boolean = false) : void
      {
         if(override)
         {
            this.gainStr = str;
            this.txtNum = 0;
            return;
         }
         this.txtNum += 1;
         if(this.txtNum > 3 && this.txtNum % 3 != 0)
         {
            this.gainStr += "\n";
         }
         else
         {
            this.gainStr += "  ";
         }
         this.gainStr += str;
      }
      
      public function add(bId:int, discrpt:String, summry:String, fun:Function = null, funParam:Object = null) : void
      {
         var obj:Object = {};
         obj.discrpt = discrpt;
         obj.summry = summry;
         obj.battleId = bId;
         obj.fun = fun;
         obj.param = funParam;
         this._obj = obj;
         if(Boolean(this.btn_share))
         {
            this.btn_share.visible = false;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(visible)
            {
               this.clearTxt();
            }
         }
         else
         {
            this.clearTxt();
         }
         super.visible = value;
      }
      
      private function infoLinkHd(evt:TextEvent) : void
      {
         var id:int = int(evt.text);
         switch(id)
         {
            case 1:
               UIManager.castPanel.visible = !UIManager.castPanel.visible;
               break;
            case 2:
               UIManager.petPanel.visible = !UIManager.petPanel.visible;
         }
      }
      
      private function okClickHd(... param) : void
      {
         this.visible = false;
      }
      
      private function shareClickHd(... param) : void
      {
         var str:String = null;
         this.okClickHd();
         if(Boolean(this._obj) && Boolean(this._obj.discrpt))
         {
            str = LangConfig.getWord("29190",2);
            ExternalInterface.call("share",encodeURI(LangConfig.getWord("29191",2)),encodeURI(this._obj.discrpt),encodeURI(str));
         }
      }
      
      private function replayClickHd(... param) : void
      {
         BattleManager.init(Model_Battle.last_battle_vo);
      }
      
      private function onBPS(... param) : void
      {
         Model_Battle.last_battle_rewards = [];
         this.gainStr = "";
         this.txtNum = 0;
         this.visible = false;
      }
      
      private function onBPE(battleId:int) : void
      {
         var lastVo:Vo_battle_lib_data = null;
         var lastRewards:Array = null;
         var bm_url:String = null;
         var thingInfo:String = null;
         var discript:String = null;
         var arr:Array = null;
         var type:int = 0;
         if(!Model_Battle.last_battle_vo)
         {
            return;
         }
         if(Model_Battle.last_battle_vo.isReplay == true)
         {
            this.visible = false;
            return;
         }
         if(!this._obj)
         {
            return;
         }
         this.txtNum = 0;
         this.itemLen = 0;
         if(this._obj.battleId == battleId)
         {
            lastVo = Model_Battle.last_battle_vo;
            lastRewards = Model_Battle.last_battle_rewards;
            if(!lastVo || !lastRewards)
            {
               return;
            }
            bm_url = lastVo.isWin == 1 ? "win.png" : "lose.png";
            Utils.getLoadBitmap("resource/image/replay/" + bm_url,this.bm_sf);
            lastVo.isReplay = true;
            if(lastVo.battleId == battleId)
            {
               for each(arr in lastRewards)
               {
                  discript = "";
                  thingInfo = "";
                  type = int(arr[0]);
                  if(type == Enum_thing_type.EQUIP)
                  {
                     this.addItem(2,arr[1],arr[2]);
                  }
                  else if(type == Enum_thing_type.ITEM)
                  {
                     this.addItem(1,arr[1],arr[2]);
                  }
                  else
                  {
                     thingInfo = arr[2];
                  }
                  discript = discriptArr[type - 1].replace("&va",thingInfo);
                  if(discript != "null" && discript != null && discript != "")
                  {
                     this.addTxt(discript);
                  }
               }
            }
            this.align();
            this.visible = true;
            if(Boolean(this._obj) && Boolean(this._obj.fun))
            {
               if(Boolean(this._obj.fun.length))
               {
                  this._obj.fun(this._obj.param);
               }
               else
               {
                  this._obj.fun();
               }
            }
         }
         else
         {
            this.visible = false;
         }
      }
      
      public function addItem(type:int, id:int, num:int) : void
      {
         var vo:Object = null;
         var ng:View_Grid = null;
         if(!this.gridArr[this.itemLen])
         {
            ng = new View_Grid();
            ng.set_bmp_bg();
            ng.set_tf_count();
            ng.set_bmp_over(true,null);
            this.gridArr.push(ng);
         }
         var grid:View_Grid = this.gridArr[this.itemLen];
         if(type == 1)
         {
            vo = new Vo_item();
         }
         else
         {
            vo = new Vo_equip();
         }
         vo.id = id;
         vo.count = num;
         vo.Init_lib();
         grid.vo = vo as Vo_grid;
         this.itemLen += 1;
      }
      
      public function align() : void
      {
         var gh:Number = NaN;
         var loseTxt:String = null;
         var i:int = 0;
         while(i < this.itemLen)
         {
            this.gridArr[i].x = i * 50;
            this.gridContainer.addChild(this.gridArr[i]);
            i += 1;
         }
         var j:int = i;
         while(j < this.gridArr.length)
         {
            if(this.gridContainer.contains(this.gridArr[j]))
            {
               this.gridContainer.removeChild(this.gridArr[j]);
            }
            j += 1;
         }
         if(Model_Battle.last_battle_vo.isWin != 1)
         {
            loseTxt = LangConfig.getWord("29193",2);
            this.tf_info.htmlText = loseTxt;
            this.tf_info.visible = true;
            this.tf_gain.y = this.tf_info.y + 25;
         }
         else
         {
            this.tf_info.htmlText = "";
            this.tf_info.visible = false;
            this.tf_gain.y = this.tf_info.y + 8;
         }
         this.gainStr = this.gainStr == null ? "" : this.gainStr;
         this.gainStr = this.gainStr.replace("null","");
         var tmp:String = this.txtNum > 0 ? LangConfig.getWord("29192",2) + this.gainStr : this.gainStr;
         this.tf_gain.htmlText = tmp;
         gh = Boolean(this.gridContainer.numChildren) ? 40 : 0;
         this.gridContainer.y = this.tf_gain.y + 25;
         this.gridContainer.x = (this.bg.width - this.gridContainer.numChildren * 50 + 15) / 2;
         this.btn_ok.y = this.gridContainer.y + gh + 10;
         this.btn_replay.y = this.btn_share.y = this.btn_ok.y + 10;
         this.bg.height = this.btn_ok.y + this.btn_ok.height + 20;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
   }
}

