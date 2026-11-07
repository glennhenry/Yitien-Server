package com.yiTian.view.modules.bag
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class View_bagPwdSetter extends Panel123
   {
      
      private var titleBg:Bitmap;
      
      private var backBitmap:ScaleBitmap;
      
      private var backLayer:Sprite;
      
      private var txtLayer:Sprite;
      
      private var dymLayer:Sprite;
      
      private var input1Txt:MyTextField;
      
      private var input2Txt:MyTextField;
      
      private var yesBtn:Button;
      
      private var noBtn:Button;
      
      public function View_bagPwdSetter()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var txt:MyTextField = null;
         this.backLayer = new Sprite();
         addChild(this.backLayer);
         this.txtLayer = new Sprite();
         addChild(this.txtLayer);
         this.dymLayer = new Sprite();
         addChild(this.dymLayer);
         this.backBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.backLayer,{
            "x":0,
            "y":0,
            "width":368,
            "height":230
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this.backLayer,{
            "x":24,
            "y":40,
            "width":320,
            "height":180
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this.backLayer,{
            "x":34,
            "y":50,
            "width":300,
            "height":120
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.backLayer,{
            "x":160,
            "y":67,
            "width":130,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.backLayer,{
            "x":160,
            "y":102,
            "width":130,
            "height":24
         },Global.Img_Cdm);
         move = new Rectangle(0,0,808,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":334,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         txt = ComponentUtil.getTextField(LangConfig.getWord("20019",11),this.txtLayer,{
            "x":70,
            "y":70,
            "realWidth":80,
            "color":13424242,
            "size":12
         });
         this.input1Txt = ComponentUtil.getTextField("",this.txtLayer,{
            "x":165,
            "y":70,
            "realWidth":130,
            "realHeight":18,
            "color":16777215,
            "size":12,
            "wordWrap":false
         });
         this.input1Txt.type = TextFieldType.INPUT;
         this.input1Txt.maxChars = 12;
         this.input1Txt.displayAsPassword = true;
         this.input1Txt.restrict = "0-9a-zA-Z\\`\\~\\!\\@\\#\\$\\%\\^\\&\\*\\(\\)\\-\\_\\=\\+\\|\\\\{\\}\\[\\]\\:\"\\:\\;\\\'\\<\\>\\,\\.\\?\\/";
         txt = ComponentUtil.getTextField(LangConfig.getWord("20020",11),this.txtLayer,{
            "x":70,
            "y":105,
            "realWidth":80,
            "color":13424242,
            "size":12
         });
         this.input2Txt = ComponentUtil.getTextField("",this.txtLayer,{
            "x":165,
            "y":106,
            "realWidth":130,
            "realHeight":18,
            "color":16777215,
            "size":12,
            "wordWrap":false
         });
         this.input2Txt.type = TextFieldType.INPUT;
         this.input2Txt.maxChars = 12;
         this.input2Txt.displayAsPassword = true;
         this.input2Txt.restrict = "0-9a-zA-Z\\`\\~\\!\\@\\#\\$\\%\\^\\&\\*\\(\\)\\-\\_\\=\\+\\|\\\\{\\}\\[\\]\\:\"\\:\\;\\\'\\<\\>\\,\\.\\?\\/";
         txt = ComponentUtil.getTextField(LangConfig.getWord("20021",11),this.txtLayer,{
            "x":158,
            "y":138,
            "realWidth":150,
            "realHeight":18,
            "color":16318464,
            "size":12
         });
      }
      
      override protected function initDynamicView() : void
      {
         this.yesBtn = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this.dymLayer,{
            "x":83,
            "y":182,
            "textColor":16184781,
            "callBack":this.onClickHandler
         },Global.Img_Cdm);
         this.noBtn = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this.dymLayer,{
            "x":213,
            "y":182,
            "textColor":16184781,
            "callBack":this.onClickHandler
         },Global.Img_Cdm);
      }
      
      override protected function initUI2() : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_Set",this.backLayer,{
            "x":104,
            "y":5
         },Global.EJiMiMa_Imgsdm);
      }
      
      private function onClickHandler(e:MouseEvent) : void
      {
         var btn:Button = e.target as Button;
         if(btn == this.noBtn)
         {
            this.visible = false;
            return;
         }
         var pwd1:String = this.input1Txt.text;
         var pwd2:String = this.input2Txt.text;
         if(pwd1.length < Model_bag.MIN_PWD_LEN || pwd2.length < Model_bag.MIN_PWD_LEN)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20022",11));
            return;
         }
         if(pwd1 != pwd2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20023",11));
            return;
         }
         BagCGMessage.CG_BAG_PWD_SETTER(pwd1,pwd2);
         this.visible = false;
      }
      
      private function clearInput() : void
      {
         if(Boolean(this.input1Txt) && Boolean(this.input2Txt))
         {
            var _temp_2:* = this.input1Txt;
            this.input2Txt.text = "";
            _temp_2.text = "";
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.EJiMiMa_Imgsdm)
            {
               regResource(Model_bag.EJiMiMaSOURCE_URL,"EJiMiMa_Imgsdm");
               preFun();
            }
            else if(!this.titleBg)
            {
               this.initUI2();
            }
         }
         else
         {
            this.clearInput();
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      override public function get width() : Number
      {
         return 368;
      }
      
      override public function get height() : Number
      {
         return 230;
      }
   }
}

