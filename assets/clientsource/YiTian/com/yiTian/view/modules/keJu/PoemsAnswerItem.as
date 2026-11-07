package com.yiTian.view.modules.keJu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_KeJu;
   import com.yiTian.data.model.Model_KeJu;
   import com.yiTian.net.message.cg.KejuCGMessage;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PoemsAnswerItem extends Sprite
   {
      
      private var answerTF:MyTextField;
      
      private var tiao:Bitmap;
      
      private var answerNum:int;
      
      public function PoemsAnswerItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.tiao = ComponentUtil.getBitmap("NPC_List",this,null,Global.npcTalk);
         this.tiao.width = 200;
         this.tiao.visible = false;
         this.answerTF = ComponentUtil.getTextField("",this,{
            "x":15,
            "y":-2,
            "color":1472370
         });
         addEventListener(MouseEvent.ROLL_OVER,this.onOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onOut);
         buttonMode = true;
      }
      
      public function onClick() : void
      {
         KejuCGMessage.CG_POEMS_ANSWER(Model_KeJu.poemsID,this.answerNum);
      }
      
      public function updata(num:int) : void
      {
         this.answerTF.text = "[" + Enum_KeJu.ANSWERNUM[num] + "]" + Model_KeJu.poemsAnswerArr[num];
         this.answerNum = num + 1;
      }
      
      public function dispose() : void
      {
         this.answerNum = 0;
         this.answerTF.text = "";
      }
      
      private function onOut(event:MouseEvent) : void
      {
         this.tiao.visible = false;
      }
      
      private function onOver(event:MouseEvent) : void
      {
         this.tiao.visible = true;
      }
   }
}

