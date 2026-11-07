package com.yiTian.view.modules.keJu
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_KeJu;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.NpcPanel;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class View_PoemsNpc extends NpcPanel
   {
      
      private static var _instance:View_PoemsNpc;
      
      private var NPC_DIALOG:MyTextField;
      
      private var NPCHead:Bitmap;
      
      private var itemArr:Vector.<PoemsAnswerItem> = new Vector.<PoemsAnswerItem>();
      
      private var quest_length:int = 0;
      
      private var fun_len:int = 0;
      
      public function View_PoemsNpc()
      {
         super();
         init();
      }
      
      public static function get instance() : View_PoemsNpc
      {
         if(!_instance)
         {
            _instance = new View_PoemsNpc();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var back:Bitmap = ComponentUtil.getBitmap("Talk",this,null,Global.npcTalk);
         CloseButton = ComponentUtil.getButton("","NPC_Close",this,{
            "x":517,
            "y":7
         },Global.npcTalk);
         this.NPCHead = new Bitmap();
         this.NPCHead.x = 0;
         this.NPCHead.y = -15;
         addChild(this.NPCHead);
         this.NPC_DIALOG = ComponentUtil.getTextField("",this,{
            "x":195,
            "y":11,
            "color":14145887,
            "realWidth":340,
            "multiline":true,
            "wordWrap":true
         });
         this.creatAnswer();
         addEventListener(MouseEvent.CLICK,this.doQuest);
      }
      
      private function creatAnswer() : void
      {
         var item:PoemsAnswerItem = null;
         var i:int = 0;
         i = 0;
         while(i < 4)
         {
            item = new PoemsAnswerItem();
            addChild(item);
            item.x = 30 + i % 2 * 200;
            item.y = 130 + int(i / 2) * 35;
            this.itemArr.push(item);
            i++;
         }
      }
      
      private function updata() : void
      {
         var item:PoemsAnswerItem = null;
         Model_KeJu.poemsAnswerArr = Data_lib.dianshi[Model_KeJu.poemsID][1].split("_");
         var i:int = 0;
         while(i < 4)
         {
            item = this.itemArr[i];
            item.updata(i);
            i++;
         }
      }
      
      private function doQuest(event:MouseEvent) : void
      {
         var item:PoemsAnswerItem = null;
         if(event.target is PoemsAnswerItem)
         {
            item = event.target as PoemsAnswerItem;
            item.onClick();
            visible = false;
         }
      }
      
      override public function show(npc:Npc) : void
      {
         super.show(npc);
         this.NPCHead.bitmapData = null;
         Utils.getSwfBitmap(Const_strImg.getNpcHeadSWF(Data_lib.npc[npc.sysId][Npc.HEAD]),this.NPCHead,null,this.npcLoadComp);
         trace(Data_lib.dianshi[1][0]);
         this.NPC_DIALOG.htmlText = HtmlUtil.fontBr(npc.name + "：",ColorConstant.getColorStr(ColorConstant.NPC_NAME),14) + "    " + Data_lib.dianshi[Model_KeJu.poemsID][0];
         this.updata();
         visible = true;
      }
      
      private function npcLoadComp() : void
      {
         this.NPCHead.y = 102 - this.NPCHead.height;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 560) / 2;
         y = (Global.stage.stageHeight - 200) / 2;
      }
   }
}

