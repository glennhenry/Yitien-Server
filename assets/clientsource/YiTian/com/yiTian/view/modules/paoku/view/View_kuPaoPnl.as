package com.yiTian.view.modules.paoku.view
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class View_kuPaoPnl extends Panel123
   {
      
      private static var _instance:View_kuPaoPnl;
      
      public var viewContainer:Sprite;
      
      public var pkMap:KPMap;
      
      private var _bg:ScaleBitmap;
      
      private var _tfHelp:MyTextField;
      
      private var _lastStyleTime:int = -60000;
      
      public function View_kuPaoPnl()
      {
         super();
         regResource("lang/ch/MMKP.swf",KuPaoUtil.mainDmName);
         regResource("lang/ch/kuPaoStyle1.swf","KuPaoStyle1dm");
         regResource("resource/moduleConfig/paoKu/pkMap.xml","",2);
         bAutoRemove = false;
      }
      
      public static function get instance() : View_kuPaoPnl
      {
         return _instance = _instance || new View_kuPaoPnl();
      }
      
      override protected function initUI2() : void
      {
         var m:Shape = null;
         var source:ByteArray = getCfg(0);
         source.uncompress();
         var xmls:Array = source.readObject();
         KuPaoMgr.instance.configXMls = xmls;
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":1050,
            "height":530
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_MinMinKuPao",this,{
            "x":445,
            "y":5
         },Global.MMKPdm);
         move = new Rectangle(0,0,this._bg.width,38);
         this.viewContainer = new Sprite();
         addChild(this.viewContainer);
         this.pkMap = KPMap.instance;
         this.pkMap.x = 25;
         this.pkMap.y = 40;
         this.viewContainer.addChild(this.pkMap);
         m = ComponentUtil.getShape(1000,480);
         m.x = 25;
         m.y = 40;
         addChild(m);
         this.pkMap.mask = m;
         ComponentUtil.getScaleBitmap("Back_YouXiZhong",[29,29,1,1],this,{
            "x":25,
            "y":40,
            "width":1000,
            "height":480
         },Global.MMKPdm);
         doubleClickEnabled = true;
         ComponentUtil.getButton("","Button_Close",this,{
            "x":this._bg.width - 35,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         var help:Button = ComponentUtil.getButton("","Button_Quest",this,{
            "x":this._bg.width - 65,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this._tfHelp = ComponentUtil.getTextField("");
         this._tfHelp.leading = 4;
         this._tfHelp.htmlText = KuPaoUtil.pkHelStr;
         help.addEventListener(MouseEvent.MOUSE_MOVE,this.onHelpMove);
         help.addEventListener(MouseEvent.ROLL_OUT,this.onHelpOut);
      }
      
      private function onHelpMove(e:MouseEvent) : void
      {
         TipManager.update(this._tfHelp);
      }
      
      private function onHelpOut(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function addToContainer(obj:DisplayObject) : void
      {
         this.viewContainer.addChild(obj);
      }
      
      public function removeFromContainer(obj:DisplayObject) : void
      {
         this.viewContainer.removeChild(obj);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
            if(getTimer() - this._lastStyleTime > 60000)
            {
               this._lastStyleTime = getTimer();
               KPMap.instance.setBGStyle(Util.rnd(1,3));
            }
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         }
         Model_KuPao._isInGame = value;
         super.visible = value;
      }
      
      public function show() : void
      {
         this.visible = true;
         KuPaoMgr.instance.paokuGlobalSM.changeState(KuPaoMgr.GST_STARTMENU,null);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this._bg.width) / 2;
         y = (Global.stage.stageHeight - this._bg.height) / 2;
      }
      
      private function onFrame(interval:int) : void
      {
         KuPaoMgr.instance.paokuGlobalSM.smUpdate(null);
         this.pkMap.update(interval);
         if(GameUnitManager.hero.action != Action.SIT)
         {
            this.visible = false;
         }
      }
      
      public function hide(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
   }
}

