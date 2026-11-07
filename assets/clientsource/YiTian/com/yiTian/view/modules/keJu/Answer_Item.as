package com.yiTian.view.modules.keJu
{
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_KeJu;
   import com.yiTian.data.model.Model_KeJu;
   import com.yiTian.net.message.cg.KejuCGMessage;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Answer_Item extends Sprite
   {
      
      private var answerTF:MyTextField;
      
      public var checkBox:CheckBox;
      
      private var answerNum:int;
      
      private var mouseBack:Sprite;
      
      public function Answer_Item()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.answerTF = ComponentUtil.getTextField("",this,{
            "x":25,
            "y":-2
         });
         this.answerTF.mouseEnabled = true;
         this.answerTF.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.answerTF.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         this.answerTF.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onOver(event:MouseEvent) : void
      {
         if(Boolean(this.mouseBack))
         {
            this.mouseBack.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
         }
      }
      
      private function onOut(event:MouseEvent) : void
      {
         if(Boolean(this.mouseBack))
         {
            this.mouseBack.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
         }
      }
      
      public function sourceComplete() : void
      {
         this.checkBox = ComponentUtil.getCheckBox("","CheckBox_keJu",this,{"color":16777215},Global.KeJu_Imgsdm);
         this.checkBox.addEventListener(MouseEvent.CLICK,this.onClick);
         this.checkBox.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.checkBox.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         this.mouseBack = new Sprite();
         addChildAt(this.mouseBack,0);
         ComponentUtil.getBitmap("kuang",this.mouseBack,{
            "x":-2,
            "y":-2
         },Global.KeJu_Imgsdm);
         this.mouseBack.alpha = 0;
         this.mouseBack.addEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
         this.mouseBack.addEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
         this.checkBox.selected = false;
         this.checkBox.mouseEnabled = false;
         this.mouseBack.visible = false;
         if(this.answerTF.text == "")
         {
            this.checkBox.visible = false;
         }
      }
      
      private function onOutHandler(e:MouseEvent) : void
      {
         this.mouseBack.alpha = 0;
      }
      
      private function onOverHandler(e:MouseEvent) : void
      {
         this.mouseBack.alpha = 1;
      }
      
      private function onClick(event:MouseEvent) : void
      {
         if(!(event.target is CheckBox))
         {
            this.checkBox.selected = true;
         }
         this.chooseAnswer();
         KejuCGMessage.CG_USE_CAISHEN(Model_KeJu.questID,Model_KeJu.answernum,Model_KeJu.isLucky,0,View_Keju.instance.getWriteTime());
      }
      
      public function chooseAnswer() : void
      {
         Model_KeJu.answernum = this.answerNum + 1;
         View_Keju.instance.luckyStar.dispose(false);
         View_Keju.instance.caishenStar.dispose(false);
         View_Keju.instance.disAnswer(false);
      }
      
      public function upData(num:int, questID:int) : void
      {
         var answer:String = null;
         this.answerNum = num;
         if(num == 0)
         {
            Model_KeJu.answerArr = Data_lib.ExamQuestion[questID][2].split("_");
         }
         if(num < Model_KeJu.answerArr.length)
         {
            answer = Model_KeJu.answerArr[num];
            this.answerTF.htmlText = "<font color=\'#0066FF\'>" + Enum_KeJu.ANSWERNUM[num] + "</font>" + " : " + answer;
            this.show();
         }
         else
         {
            this.answerTF.htmlText = "";
            this.hide();
         }
         this.answerTF.mouseEnabled = false;
         if(Boolean(this.checkBox))
         {
            this.checkBox.selected = false;
            this.checkBox.mouseEnabled = false;
         }
         this.filters = Util.disabled;
      }
      
      private function show() : void
      {
         this.answerTF.visible = true;
         if(Boolean(this.checkBox))
         {
            var _temp_1:* = this.checkBox;
            this.mouseBack.visible = true;
            _temp_1.visible = true;
         }
      }
      
      public function hide() : void
      {
         this.answerTF.visible = false;
         if(Boolean(this.checkBox))
         {
            var _temp_1:* = this.checkBox;
            this.mouseBack.visible = false;
            _temp_1.visible = false;
         }
      }
      
      public function dispose(lock:Boolean) : void
      {
         if(Boolean(this.checkBox))
         {
            this.checkBox.mouseEnabled = lock;
            this.answerTF.mouseEnabled = lock;
            if(lock)
            {
               this.filters = [];
            }
            else
            {
               this.filters = Util.disabled;
            }
         }
      }
   }
}

