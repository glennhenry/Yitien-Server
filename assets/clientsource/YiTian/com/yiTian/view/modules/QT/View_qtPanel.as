package com.yiTian.view.modules.QT
{
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QTSignCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.sign.SignUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_qtPanel extends Panel123
   {
      
      private static var _instance:View_qtPanel;
      
      private var _content:TabButton;
      
      private var _qtSign:TabButton;
      
      private var _contentPanel:View_QT;
      
      private var _signPanel:View_qtSign;
      
      private var _btn_vec:Vector.<TabButton> = new Vector.<TabButton>();
      
      private var _icon:MainUIBtn;
      
      private var _initt:Boolean = false;
      
      private var _con:Sprite;
      
      private var _isUpdate:Boolean = false;
      
      private var now:TabButton;
      
      public function View_qtPanel()
      {
         super();
         regResource("lang/ch/QTHD.swf","QTHDdm");
         regResource("lang/ch/qtSign_Imgs.swf","QTSIGNdm");
      }
      
      public static function get instance() : View_qtPanel
      {
         if(!_instance)
         {
            _instance = new View_qtPanel();
         }
         return _instance;
      }
      
      public function showBtn() : void
      {
         if(!this.icon)
         {
            this._icon = new MainUIBtn("resource/image/QT/Icon_QTHL.png");
            this._icon.addEventListener(MouseEvent.CLICK,this.onClick);
         }
         UIManager.newMainBtnContainer.addBtn(this.icon);
      }
      
      private function onClick(e:MouseEvent) : void
      {
         Global.delegate.dosomething(View_qtPanel.instance,function():void
         {
            visible = !visible;
         });
      }
      
      public function signed() : void
      {
         this._signPanel.sign();
         SignUtil.removeSingleTips();
      }
      
      public function getSignedAward() : void
      {
         this._signPanel.getAward();
      }
      
      public function update(count:int, date:Date) : void
      {
         this._contentPanel.visible = false;
         this._signPanel.visible = true;
         this._signPanel.update(count,date);
      }
      
      override protected function initUI2() : void
      {
         move = new Rectangle(0,0,729,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":727,
            "height":487
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":64,
            "width":679,
            "height":414
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_QTHD",this,{
            "x":284,
            "y":5
         },Global.QTHDdm);
         this._con = new Sprite();
         addChild(this._con);
         this._contentPanel = View_QT.instance;
         this._con.addChild(this._contentPanel);
         this._contentPanel.x = -2;
         this._contentPanel.y = 25;
         this._content = ComponentUtil.getTabButton("活动详情","TabButton_Four",this,{
            "x":34,
            "y":43,
            "textColor":16773818,
            "chooseColor":16383744,
            "name":"1"
         },Global.Img_Cdm);
         this._qtSign = ComponentUtil.getTabButton("QT签到","TabButton_Four",this,{
            "x":110,
            "y":43,
            "textColor":16773818,
            "chooseColor":16383744,
            "name":"2"
         },Global.Img_Cdm);
         this._content.choose = true;
         this.now = this._content;
         this._btn_vec.push(this._content);
         this._btn_vec.push(this._qtSign);
         this._content.addEventListener(MouseEvent.CLICK,this.onClickHandle);
         this._qtSign.addEventListener(MouseEvent.CLICK,this.onClickHandle);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":694,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
      }
      
      private function onClickHandle(e:MouseEvent) : void
      {
         var btn:TabButton = e.target as TabButton;
         if(this.now == btn)
         {
            return;
         }
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         btn.choose = true;
         this.now = btn;
         if(btn.name == "1")
         {
            this._contentPanel.visible = true;
            this._signPanel.visible = false;
         }
         else if(btn.name == "2")
         {
            if(!this._signPanel)
            {
               this._signPanel = View_qtSign.instance;
               this._con.addChild(this._signPanel);
            }
            QTSignCGMessage.CG_QTSign_OPEN();
         }
      }
      
      public function get icon() : MainUIBtn
      {
         return this._icon;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(Boolean(this.now) && this.now.name == "2")
            {
               QTSignCGMessage.CG_QTSign_OPEN();
            }
         }
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 727) * 0.5;
         y = (Global.stage.stageHeight - 487) * 0.5;
      }
   }
}

