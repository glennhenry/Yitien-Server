package com.yiTian.view.modules.paobiao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_NPC_ID;
   import com.yiTian.data.model.Model_CrossDart;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.DailyBtnManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossDartCGMessage;
   import com.yiTian.net.message.cg.PaoBiaoCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class PaoBiaoPanel extends Panel
   {
      
      public static var _startTime:String;
      
      public static var _endTime:String;
      
      public static var _add:int;
      
      private static var isFirstOpen:Boolean = true;
      
      private var bm:Bitmap;
      
      private var _icon:MainUIBtn;
      
      private var _eff:Effect;
      
      private var btnGo:Button;
      
      private var btnClose:Button;
      
      public var icon2:MainUIBtn;
      
      private var eff2:Effect;
      
      public var icon3:MainUIBtn;
      
      private var vecStr:Vector.<String> = new <String>["年","月","日"];
      
      public function PaoBiaoPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.bm = new Bitmap();
         addChild(this.bm);
         this.btnGo = ComponentUtil.getButton(LangConfig.getWord("10312",1),"Button_Orange",this,{
            "x":300,
            "y":230
         });
         this.btnClose = ComponentUtil.getButton(LangConfig.getWord("10313",1),"Button_Orange",this,{
            "x":400,
            "y":230
         });
         this.btnClose.addEventListener(MouseEvent.CLICK,this.hidePanel);
         this.btnGo.addEventListener(MouseEvent.CLICK,this.onClick);
         var t:MyTextField = ComponentUtil.getTextField("",this,{
            "x":250,
            "y":150
         });
         t.multiline = true;
         t.leading = 3;
         t.htmlText = LangConfig.getWord("10311",1);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(isFirstOpen)
            {
               Utils.loadTitle("lang/ch/guideMM.swf","guideBg",this.bm);
               isFirstOpen = false;
            }
         }
      }
      
      private function hidePanel(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function onClick(e:MouseEvent) : void
      {
         if(Model_CrossDart.isCross())
         {
            this.visible = false;
            if(Model_CrossDart.inCrossScence)
            {
               GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
            }
            else
            {
               CrossDartCGMessage.CG_CROSSDART_OPENAC(Model_CrossDart.TYPE_GO);
            }
            return;
         }
         GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
         this.visible = false;
      }
      
      public function hasIcon() : Boolean
      {
         return this.eff == null ? false : true;
      }
      
      public function showIcon() : void
      {
         if(!this.icon)
         {
            this._icon = new MainUIBtn("resource/image/paobiao/icon.png",null,null,null,true);
            this.icon.addEventListener(MouseEvent.CLICK,this.paoBiaoHandler);
         }
         if(!this.eff)
         {
            this._eff = EffectManager.addEffect("35343",this.icon,1000,32,29,true);
         }
         UIManager.mainUiBtnContainer.addBTN(this.icon);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.PaoBiao,1]);
         this.updateIconCount(DailyBtnManager.getCount(DailyBtnManager.PAO_BIAO));
      }
      
      public function updateIconCount(count:int) : void
      {
         if(Boolean(this.icon))
         {
            this.icon.showTime(count);
         }
      }
      
      public function hideIcon() : void
      {
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this._eff = null;
         }
         UIManager.mainUiBtnContainer.removeBTN(this.icon);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.PaoBiao,-1]);
         this.visible = false;
      }
      
      public function showIcon2() : void
      {
      }
      
      public function showEff2() : void
      {
         if(!this.eff2 && Boolean(this.icon2))
         {
            this.eff2 = EffectManager.addEffect("35343",this.icon2,1000,32,29,true);
         }
      }
      
      public function zhiBiaoHandler(e:MouseEvent = null) : void
      {
         var key:String = null;
         var _dic:Dictionary = Data_lib.hd;
         var sign:Boolean = false;
         var sTime:String = "";
         var reg:RegExp = /2013年/g;
         for(key in _dic)
         {
            if(_dic[key][21] == "62")
            {
               sign = true;
               sTime = _dic[key][4].replace(reg,"");
               break;
            }
         }
         sTime = sTime.replace("<font color=\'#f9ff00\'> 活动时间：</font>","");
         View_Alert.show("<font color=\"#FFFFFF\"><font color=\"" + ColorConstant.getColorStr(ColorConstant.GREEN) + "\">" + sTime + "</font>可免费运送<font color=\"" + ColorConstant.getColorStr(ColorConstant.PURPLE) + "\">紫镖</font><font color=\"" + ColorConstant.getColorStr(ColorConstant.YELLOW) + "\">（并附赠免费保险）</font>，是否参加？</font>",View_Alert.OK_CANCAL,function():void
         {
            if(Boolean(GameUnitManager.hero.paoBiao))
            {
               UIManager.centerBroadcast.addMsg("目前正在运镖");
               return;
            }
            PaoBiaoCGMessage.CG_ZHI_BIAO(0);
         });
      }
      
      public function hideIcon2() : void
      {
         UIManager.mainUiBtnContainer.removeBTN(this.icon2);
      }
      
      public function hideEff2() : void
      {
         if(Boolean(this.eff2) && Boolean(this.icon2) && this.icon2.contains(this.eff2))
         {
            EffectManager.removeEffect(this.eff2);
            this.eff2 = null;
         }
      }
      
      public function showIcon3(result:int, startTime:String, endTime:String, add:int) : void
      {
         _startTime = startTime;
         _endTime = endTime;
         _add = add;
         if(result == 1)
         {
            if(!this.icon3)
            {
               this.icon3 = new MainUIBtn("resource/image/paobiao/shenBiao.png");
               this.icon3.addEventListener(MouseEvent.CLICK,this.shenBiaoHandler);
            }
            UIManager.mainUiBtnContainer.addBTN(this.icon3);
         }
         else if(result == 0)
         {
            UIManager.mainUiBtnContainer.removeBTN(this.icon3);
         }
      }
      
      private function ss(str:String) : String
      {
         if(!str)
         {
            return "";
         }
         var s:String = "";
         s += str.substr(0,4) + this.vecStr[0];
         s += str.substr(5,2) + this.vecStr[1];
         s += str.substr(8,2) + this.vecStr[2];
         return s + str.substr(11,8);
      }
      
      public function shenBiaoHandler(e:MouseEvent = null) : void
      {
         var s1:String = this.ss(_startTime);
         var s2:String = this.ss(_endTime);
         if(Model_CrossDart.isCross())
         {
            if(Model_CrossDart.inCrossScence)
            {
               View_Alert.show("<font color=\"#039d4b\">" + s1 + "至" + s2 + "</font>参与跨服运镖可获得额外<font color=\"#0367ab\">" + _add + "%</font>经验加成哦！",View_Alert.OK_CANCAL,this.okCallBack,null,null,null,400,"","",TextFormatAlign.CENTER);
            }
            else
            {
               CrossDartCGMessage.CG_CROSSDART_OPENAC(Model_CrossDart.TYPE_SB);
            }
         }
         else
         {
            View_Alert.show("<font color=\"#039d4b\">" + s1 + "至" + s2 + "</font>参与运镖可获得额外<font color=\"#0367ab\">" + _add + "%</font>经验加成哦！",View_Alert.OK_CANCAL,this.okCallBack,null,null,null,400,"","",TextFormatAlign.CENTER);
         }
      }
      
      private function okCallBack() : void
      {
         if(GameUnitManager.hero.status == Status.SIT)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60038",6));
            return;
         }
         GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
      }
      
      public function paoBiaoHandler(e:MouseEvent) : void
      {
         this.visible = !this.visible;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function get icon() : MainUIBtn
      {
         return this._icon;
      }
      
      public function get eff() : Effect
      {
         return this._eff;
      }
   }
}

