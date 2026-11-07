package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.vo.Vo_landRank;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_land_rank extends Panel
   {
      
      public var landLevel:int;
      
      private var land_text:MyTextField;
      
      private var landRank_explain:MyTextField;
      
      private var prerequisite:MyTextField;
      
      private var consume:MyTextField;
      
      private var upgrade_Button:Button;
      
      private var cancel_Button:Button;
      
      public var landpos:int;
      
      private var isFirstOpen:Boolean = true;
      
      public function View_land_rank()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":307,
            "height":201
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":149
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":30,
            "y":70,
            "width":248,
            "height":50
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":103,
            "y":133,
            "width":95,
            "height":17
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":103,
            "y":157,
            "width":95,
            "height":17
         },Global.Img_Cdm);
         move = new Rectangle(0,0,249,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":273,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("94",9),this,{
            "x":37,
            "y":132,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("95",9),this,{
            "x":37,
            "y":156,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.land_text = ComponentUtil.getTextField(LangConfig.getWord("96",9),this,{
            "x":81,
            "y":48,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.landRank_explain = ComponentUtil.getTextField("",this,{
            "x":39,
            "y":76,
            "color":11904647,
            "size":12,
            "leading":5
         });
         this.landRank_explain.multiline = true;
         this.prerequisite = ComponentUtil.getTextField("1",this,{
            "x":105,
            "y":132,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.consume = ComponentUtil.getTextField("1",this,{
            "x":106,
            "y":156,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.upgrade_Button = ComponentUtil.getButton(LangConfig.getWord("100",9),"Button_Two64",this,{
            "x":207,
            "y":128,
            "textColor":16773818
         },Global.Img_Cdm);
         this.cancel_Button = ComponentUtil.getButton(LangConfig.getWord("67",9),"Button_Two64",this,{
            "x":207,
            "y":155,
            "textColor":16773818
         },Global.Img_Cdm);
         this.cancel_Button.callBack = this.cliHandle;
         this.upgrade_Button.addEventListener(MouseEvent.CLICK,this.upgradeClickHandle);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               this.showBmp();
            }
         }
      }
      
      public function updata(level:int, pos:int, str:String) : void
      {
         this.landLevel = level;
         this.landpos = pos;
         this.land_text.htmlText = LangConfig.getWord("96",9,Model_farm.fruitColor1[Data_lib.landRank[this.landLevel][Vo_landRank.landNameColor] - 1],str,this.landLevel,Model_farm.fruitColor1[Data_lib.landRank[this.landLevel + 1][Vo_landRank.landNameColor] - 1],this.landLevel + 1);
         this.landRank_explain.htmlText = Data_lib.landRank[this.landLevel][Vo_landRank.upgradeInstruction];
         if(Model_farm.instace.masterBasic_mine.farmLevel >= Data_lib.landRank[this.landLevel][Vo_landRank.villaLevelRequire])
         {
            this.prerequisite.text = LangConfig.getWord("97",9,Data_lib.landRank[this.landLevel][Vo_landRank.villaLevelRequire]);
            this.prerequisite.textColor = 11904647;
         }
         else
         {
            this.prerequisite.text = LangConfig.getWord("97",9,Data_lib.landRank[this.landLevel][Vo_landRank.villaLevelRequire]);
            this.prerequisite.textColor = 16711680;
         }
         if(Model_farm.instace.masterBasic_mine.farmResource >= Data_lib.landRank[this.landLevel][Vo_landRank.resoureConsumption])
         {
            this.consume.text = Data_lib.landRank[this.landLevel][Vo_landRank.resoureConsumption];
            this.consume.textColor = 11904647;
         }
         else
         {
            this.consume.text = Data_lib.landRank[this.landLevel][Vo_landRank.resoureConsumption];
            this.consume.textColor = 16711680;
         }
      }
      
      private function showBmp() : void
      {
         ComponentUtil.getBitmap("BT_NTShenJi",this,{
            "x":74,
            "y":6
         },Global.ShanZhuang_Imgsdm);
      }
      
      private function upgradeClickHandle(evt:MouseEvent) : void
      {
         this.visible = false;
         if(Model_farm.instace.masterBasic_mine.farmLevel < Data_lib.landRank[this.landLevel][Vo_landRank.villaLevelRequire])
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("98",9));
            return;
         }
         if(Model_farm.instace.masterBasic_mine.farmResource < Data_lib.landRank[this.landLevel][Vo_landRank.resoureConsumption])
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("99",9));
            return;
         }
         FarmCGMessage.cg_farm_land_levelup(Model_farm.instace.masterBasic_mine.id,this.landpos);
      }
      
      private function cliHandle(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

