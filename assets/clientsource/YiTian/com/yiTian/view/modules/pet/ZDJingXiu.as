package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel123;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.utils.setTimeout;
   import flashx.textLayout.formats.TextAlign;
   
   public class ZDJingXiu extends Panel123
   {
      
      public static var num:MyTextField;
      
      public static var iszdjx:Boolean;
      
      public static var input_num:int = 10;
      
      private var back:ScaleBitmap;
      
      private var queDingBtn:Button;
      
      private var quXiaoBtn:Button;
      
      private var ZDBox:CheckBox;
      
      private var box:int;
      
      public function ZDJingXiu()
      {
         super();
         regResource("lang/ch/ZDJX.swf","ZDJXdm");
         bindParent = GameScene.modalLayer;
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":300,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":22,
            "y":37,
            "width":256,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60471",6),this,{
            "x":34,
            "y":49,
            "color":16774871,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60472",6),this,{
            "x":50,
            "y":70,
            "color":16774871,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":23,
            "y":97,
            "width":250,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":124,
            "y":50,
            "width":80,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60473",6),this,{
            "x":34,
            "y":100,
            "color":16774871,
            "size":12,
            "leading":0
         });
         var tf:MyTextField = ComponentUtil.getTextField("",this,{
            "x":34,
            "y":116,
            "color":16774871,
            "size":12,
            "leading":0
         });
         tf.multiline = true;
         tf.htmlText = LangConfig.getWord("60474",6);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":265,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         num = ComponentUtil.getTextField("10",this,{
            "x":125,
            "y":50,
            "color":16774871,
            "size":12,
            "leading":0,
            "realWidth":78,
            "realHeight":19
         });
         num.align = TextAlign.CENTER;
         num.type = TextFieldType.INPUT;
         num.maxChars = 4;
         num.restrict = "0-9";
         num.addEventListener(Event.CHANGE,this.changedHandle);
         CloseButton.addEventListener(MouseEvent.CLICK,this.quXiaoClick);
         CloseButton.callBack = this.closeClick;
      }
      
      override protected function initDynamicView() : void
      {
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getBitmap("txt_ZDXX",this,{
            "x":70,
            "y":5
         },Global.ZDJXdm);
         this.queDingBtn = ComponentUtil.getButton(LangConfig.getWord("60475",6),"Button_Four",this,{
            "x":105,
            "y":175,
            "textColor":16774871
         },Global.Img_Cdm);
         this.quXiaoBtn = ComponentUtil.getButton(LangConfig.getWord("60476",6),"Button_Orange",this,{
            "x":105,
            "y":175,
            "textColor":16774871
         },Global.Img_Cdm);
         this.ZDBox = ComponentUtil.getCheckBox("","CheckBox01",this,{
            "x":30,
            "y":70,
            "color":16777215
         },Global.Img_Cdm);
         this.queDingBtn.addEventListener(MouseEvent.CLICK,this.queDingClick);
         this.quXiaoBtn.addEventListener(MouseEvent.CLICK,this.quXiaoClick);
      }
      
      private function closeClick(e:MouseEvent) : void
      {
         this.hide();
      }
      
      private function changedHandle(e:Event) : void
      {
         num = e.target as MyTextField;
         if(int(num.text) < 1)
         {
            num.text = "1";
         }
         else if(int(num.text) > 999)
         {
            num.text = "999";
         }
         num.setSelection(num.text.length,num.text.length);
         input_num = int(num.text);
      }
      
      private function queDingClick(e:MouseEvent) : void
      {
         iszdjx = true;
         if(HuaXingJingXiuVO.type == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60477",6));
         }
         else if(input_num != 0)
         {
            this.BtnVisble();
            this.cg();
         }
         else if(input_num == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60478",6));
         }
      }
      
      public function BtnVisble() : void
      {
         var index:int;
         this.queDingBtn.visible = true;
         this.quXiaoBtn.visible = false;
         index = int(setTimeout(function():void
         {
            PetCGMessage.CG_OPEN_JINGXIU();
         },300));
         if(iszdjx)
         {
            this.queDingBtn.visible = false;
            this.quXiaoBtn.visible = true;
         }
         else
         {
            this.queDingBtn.visible = true;
            this.quXiaoBtn.visible = false;
         }
      }
      
      private function quXiaoClick(e:MouseEvent) : void
      {
         iszdjx = false;
         this.BtnVisble();
      }
      
      public function cg() : void
      {
         if(iszdjx)
         {
            if(this.ZDBox.selected)
            {
               this.box = 1;
            }
            else
            {
               this.box = 0;
            }
            if(input_num > 0 && CommandManager.get_bag_count(46576,2) > 0 && GameUnitManager.hero.bingSilver + GameUnitManager.hero.silver >= Data_lib.petjx[HuaXingJingXiuVO.jingjie][5])
            {
               if(this.box == 1)
               {
                  PetCGMessage.CG_BT_JINGXIU(5,1);
               }
               else if(this.box == 0)
               {
                  PetCGMessage.CG_BT_JINGXIU(5,0);
               }
            }
            else if(GameUnitManager.hero.bingSilver + GameUnitManager.hero.silver >= Data_lib.petjx[HuaXingJingXiuVO.jingjie][5])
            {
               if(GameUnitManager.hero.money < 38 && this.box == 1)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("60479",6));
                  iszdjx = false;
                  this.BtnVisble();
               }
               else if(this.box == 0 && CommandManager.get_bag_count(46576,2) == 0)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("60480",6));
                  iszdjx = false;
                  this.BtnVisble();
               }
               else if(GameUnitManager.hero.money >= 38 && this.box == 1)
               {
                  PetCGMessage.CG_BT_JINGXIU(5,1);
               }
            }
            else if(GameUnitManager.hero.bingSilver + GameUnitManager.hero.silver < Data_lib.petjx[HuaXingJingXiuVO.jingjie][5])
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60481",6));
               iszdjx = false;
               this.BtnVisble();
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 + 300;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function show() : void
      {
         ModalUIManager.POPUP(this,"right300");
         this.ZDBox.selected = false;
         this.BtnVisble();
         input_num = 10;
         num.text = String(input_num);
      }
      
      public function hide() : void
      {
         ModalUIManager.UNPOP();
      }
   }
}

