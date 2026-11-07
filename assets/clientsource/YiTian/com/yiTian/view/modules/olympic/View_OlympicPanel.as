package com.yiTian.view.modules.olympic
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.GuideCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextFieldType;
   
   public class View_OlympicPanel extends Panel
   {
      
      private static var _instance:View_OlympicPanel;
      
      private static var isOn:Boolean = false;
      
      private var input:MyTextField;
      
      private var btn:Button;
      
      private var heCaiBtn:Button;
      
      private var tfJHM:MyTextField;
      
      private var tfZHU:MyTextField;
      
      private var descrip:String;
      
      public var olymBtn:MainUIBtn;
      
      public function View_OlympicPanel()
      {
         super();
      }
      
      public static function get instance() : View_OlympicPanel
      {
         if(!_instance)
         {
            _instance = new View_OlympicPanel();
            _instance.init();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var _str:String;
         var tf:MyTextField;
         var sp:Sprite = null;
         var _vo:Vo_item = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":550,
            "height":510
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":23,
            "y":38,
            "width":504,
            "height":404
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":23,
            "y":443,
            "width":504,
            "height":60
         },Global.Img_Cdm);
         move = new Rectangle(0,0,529,38);
         this.descrip = LangConfig.getWord("60220",6);
         sp = new Sprite();
         sp.graphics.beginFill(0,0);
         sp.graphics.drawRect(0,0,73,18);
         sp.graphics.endFill();
         addChild(sp);
         sp.x = 139 + 112;
         sp.y = 476;
         _vo = new Vo_item();
         _vo.id = 44486;
         _vo.Init_lib();
         sp.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
         {
            isOn = true;
            TipManager.update(_vo);
            TipManager.view_tip.x = Global.stage.mouseX;
            TipManager.view_tip.y = Global.stage.mouseY;
         });
         sp.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
         {
            isOn = false;
            TipManager.hide();
         });
         sp.addEventListener(MouseEvent.MOUSE_MOVE,function(e:MouseEvent):void
         {
            if(isOn)
            {
               TipManager.view_tip.x = Global.stage.mouseX;
               TipManager.view_tip.y = Global.stage.mouseY;
            }
         });
         _str = "注：在2月5日-16日参与黄钻活动可领取" + HtmlUtil.link(HtmlUtil.underLine(HtmlUtil.font("新春黄钻礼包","#04ff00")),"huangZuanAct") + "，只有一次参与机会噢!";
         tf = ComponentUtil.getTextField("",this,{
            "x":39,
            "y":476,
            "color":16761344,
            "size":12,
            "leading":0
         });
         tf.htmlText = _str;
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":125,
            "y":452,
            "width":300,
            "height":21
         },Global.Img_Cdm);
         this.olymBtn = new MainUIBtn("resource/image/shouchong/olymPic.png",{
            "x":(65 - 55) / 2,
            "y":(70 - 55) / 2
         });
         this.olymBtn.addEventListener(MouseEvent.CLICK,function():void
         {
            View_OlympicPanel.instance.visible = !View_OlympicPanel.instance.visible;
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":516,
            "y":6
         },Global.Img_Cdm);
         this.input = ComponentUtil.getTextField("",this,{
            "x":135,
            "y":453.25,
            "realHeight":21,
            "realWidth":290
         });
         this.input.type = TextFieldType.INPUT;
         this.input.restrict = "a-z0-9A-Z";
         this.input.maxChars = 30;
         this.input.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
         });
         this.input.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
         });
         this.heCaiBtn = ComponentUtil.getButton("","Jilq",this,{
            "x":220,
            "y":217
         },Global.Img_Cdm);
         this.tfJHM = ComponentUtil.getTextField(LangConfig.getWord("60221",6),this,{
            "x":30,
            "y":452,
            "color":10148472
         });
         this.heCaiBtn.addEventListener(MouseEvent.CLICK,this.linktoQQ);
         this.btn = ComponentUtil.getButton(LangConfig.getWord("60102",6),"Button_Orange",this,{
            "x":443,
            "y":452
         },Global.UIdm);
         this.btn.addEventListener(MouseEvent.CLICK,this.getReward);
      }
      
      public function showOlym() : void
      {
      }
      
      public function remove_olym_btn() : void
      {
         if(Boolean(this.olymBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.olymBtn);
         }
      }
      
      private function getReward(e:MouseEvent) : void
      {
         if(this.btn.label == LangConfig.getWord("60102",6))
         {
            if(this.input.text == "")
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60221",6));
               return;
            }
            GuideCGMessage.CG_GET_NEWPAWARD(this.input.text);
         }
      }
      
      private function linktoQQ(e:MouseEvent) : void
      {
         var request:URLRequest = new URLRequest("http://qzs.qq.com/qzone/mall/app/meteor/act/index.html?rid=172");
         navigateToURL(request,"_blank");
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function setBtnLabel(result:int = 0) : void
      {
         this.btn.enabled = result == 0;
         this.btn.label = result == 0 ? LangConfig.getWord("60102",6) : LangConfig.getWord("60222",6);
      }
      
      public function resultHd(result:int) : void
      {
      }
      
      private function show() : void
      {
         ComponentUtil.getBitmap("txt_HZgame",this,{
            "x":195,
            "y":5
         },Global.new_yeardm);
         ComponentUtil.getBitmap("HuoDong",this,{
            "x":25,
            "y":40
         },Global.new_yeardm);
         setChildIndex(this.heCaiBtn,numChildren - 1);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.setBtnLabel();
            Global.focus = this.input;
            Global.control.registerCallBack(Enum_MsgType.OLYMPIC_UPDATE,this.setBtnLabel);
            if(!Global.new_yeardm)
            {
               SingleLoader.add("lang/ch/new_year.swf",function(info:Object):void
               {
                  Global.new_yeardm = info.applicationDomain;
                  show();
               });
            }
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.OLYMPIC_UPDATE,this.setBtnLabel);
         }
      }
   }
}

