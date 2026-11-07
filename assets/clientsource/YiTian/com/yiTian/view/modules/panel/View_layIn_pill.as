package com.yiTian.view.modules.panel
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_layInPill;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class View_layIn_pill extends Panel
   {
      
      private static var GAP_WIDTH:int = 50;
      
      private var layInPill:MyTextField;
      
      private var Button_Confirm:Button;
      
      private var Button_Cancel:Button;
      
      private var pourText:MyTextField;
      
      private var tf:TextFormat;
      
      private var pillId:int;
      
      private var pillGridId:int;
      
      private var pillNum:int;
      
      private var isFirstOpen:Boolean = true;
      
      private var isLoad:Boolean = false;
      
      public function View_layIn_pill()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":354 + GAP_WIDTH,
            "height":150
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":306 + GAP_WIDTH,
            "height":80
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":30,
            "y":45,
            "width":294 + GAP_WIDTH,
            "height":70
         },Global.Img_Cdm);
         move = new Rectangle(0,0,246 + GAP_WIDTH,38);
         this.layInPill = ComponentUtil.getTextField("",this,{
            "x":35,
            "y":58,
            "size":14
         });
         this.layInPill.realWidth = 284 + GAP_WIDTH;
         this.pourText = ComponentUtil.getTextField("",this,{
            "x":35,
            "y":85,
            "size":12,
            "color":16711680
         });
         this.pourText.realWidth = 284 + GAP_WIDTH;
         this.pourText.multiline = true;
         this.tf = new TextFormat();
         this.tf.align = TextFormatAlign.CENTER;
         this.layInPill.setTextFormat(this.tf);
         this.pourText.setTextFormat(this.tf);
         this.Button_Confirm = ComponentUtil.getButton(LangConfig.getWord("88",9),"Button_Two64",this,{
            "x":63 + GAP_WIDTH / 2,
            "y":120,
            "textColor":16773818
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("160",9),"Button_Two64",this,{
            "x":230 + GAP_WIDTH / 2,
            "y":120,
            "textColor":16773818
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":324 + GAP_WIDTH,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.Button_Confirm.addEventListener(MouseEvent.CLICK,this.clickHandle);
         this.Button_Cancel.addEventListener(MouseEvent.CLICK,this.closeHandle);
      }
      
      public function update(id:int, num:int, strName:String, color:int, gridId:int) : void
      {
         if(id == 46620 || id == 46621 || id == 46622 || id == 46626)
         {
            this.layInPill.htmlText = LangConfig.getWord("173",9,Model_shop.get_color_arr[color - 1],num,strName,int(num * Data_lib.item[id][Enum_lib_item.RESULT] / 10000));
            this.pourText.htmlText = LangConfig.getWord("174",9,int((Number(Model_layInPill.instance.highestExp) - Number(Model_layInPill.instance.currentExp)) / 10000));
         }
         else
         {
            this.layInPill.htmlText = LangConfig.getWord("175",9,Model_shop.get_color_arr[color - 1],num,strName);
            this.pourText.htmlText = LangConfig.getWord("176",9,num * Data_lib.item[id][Enum_lib_item.RESULT] / 10000);
         }
         this.layInPill.setTextFormat(this.tf);
         this.pourText.setTextFormat(this.tf);
         this.pillGridId = gridId;
         this.pillNum = num;
         this.pillId = id;
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.level < 40)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("177",9));
            return;
         }
         if(Data_lib.item[this.pillId][Enum_lib_item.TYPE] == 150)
         {
            if(this.pillNum * Data_lib.item[this.pillId][Enum_lib_item.RESULT] > Number(Model_layInPill.instance.currentExp))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("178",9));
               return;
            }
         }
         else if(Data_lib.item[this.pillId][Enum_lib_item.TYPE] == 371)
         {
            if(this.pillNum * Data_lib.item[this.pillId][Enum_lib_item.RESULT] > GameUnitManager.hero.exp)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("179",9));
               return;
            }
         }
         BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,this.pillGridId,this.pillNum);
         this.visible = false;
      }
      
      private function closeHandle(evt:MouseEvent) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               if(!Global.NPC_Imgsdm)
               {
                  SingleLoader.add("lang/ch/NPC_Imgs.swf",function(info:Object):void
                  {
                     Global.NPC_Imgsdm = info.applicationDomain;
                     showBmp();
                  });
               }
               else if(!this.isLoad)
               {
                  this.showBmp();
               }
            }
         }
      }
      
      private function showBmp() : void
      {
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":97 + GAP_WIDTH / 2,
            "y":5
         },Global.NPC_Imgsdm);
         this.isLoad = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

