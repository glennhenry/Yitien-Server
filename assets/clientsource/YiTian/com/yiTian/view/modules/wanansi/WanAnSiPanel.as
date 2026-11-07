package com.yiTian.view.modules.wanansi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_map_lib;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.DailyBtnManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WanAnSiCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.IMainUiBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class WanAnSiPanel extends Panel
   {
      
      private const AWARD_ID:Vector.<int> = new <int>[46412,46490,46491,46492];
      
      private const HELL_AWARD_ID:Vector.<int> = new <int>[45217,46412,45220,45221];
      
      private var bmBack:Bitmap;
      
      private var txtTiems:MyTextField;
      
      public var icon:MainUIBtn;
      
      private var isAskChallType:int;
      
      private var normalChallBtn:Button;
      
      private var hellChallBtn:Button;
      
      private const PATH:String = "lang/ch/WanAnSi_Imgs.swf";
      
      private var rewardGridVec:Vector.<View_Grid>;
      
      private var isFirstOpen:Boolean = true;
      
      public function WanAnSiPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":668,
            "height":440
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":50,
            "width":620,
            "height":380
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,40);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":634,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.bmBack = new Bitmap();
         addChild(this.bmBack);
         TipManager.bind(ComponentUtil.getButton("","Button_Quest",this,{
            "x":610,
            "y":6
         },Global.Img_Cdm),LangConfig.getWord("10638",1));
      }
      
      public function showIcon() : IMainUiBtn
      {
         if(!this.icon)
         {
            this.icon = new MainUIBtn("resource/image/wanansi/icon.png",null,null,null,true);
            this.icon.addEventListener(MouseEvent.CLICK,this.iconOnClick);
         }
         UIManager.mainUiBtnContainer.addBTN(this.icon);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.WanAnSi,1]);
         this.updateIconCount(DailyBtnManager.getCount(DailyBtnManager.WAN_AN));
         return this.icon;
      }
      
      public function updateIconCount(count:int) : void
      {
         if(Boolean(this.icon))
         {
            this.icon.showTime(count);
         }
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.WanAnSi,count]);
      }
      
      public function hideIcon() : void
      {
         UIManager.mainUiBtnContainer.removeBTN(this.icon);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.WanAnSi,2]);
      }
      
      private function iconOnClick(e:MouseEvent) : void
      {
         UIManager.wanAnSiPanel.visible = true;
         WanAnSiCGMessage.CG_WANANSI_TIMES();
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         var hintStr:String = null;
         var btn:Button = e.target as Button;
         if(btn.name == "normal")
         {
            hintStr = LangConfig.getWord("10640",1);
            this.isAskChallType = 1;
         }
         else if(btn.name == "hell")
         {
            hintStr = "确定开启挑战地狱万安寺副本？";
            this.isAskChallType = 2;
         }
         View_Alert.show("<font color=\'#FFFF00\'>" + hintStr + "</font>",View_Alert.OK_CANCAL,this.callBack);
      }
      
      private function callBack() : void
      {
         if(GameUnitManager.hero.status == Status.SIT || GameUnitManager.hero.status == Status.FISH)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10541",1));
            return;
         }
         if(Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] == 3 || Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] == 5)
         {
            if(Boolean(Model_team.teamMumberInfo_data_save.length))
            {
               if(Model_team.isCap())
               {
                  if(Model_team.isAway() || Model_team.isOffLine())
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("10641",1));
                  }
                  else
                  {
                     WanAnSiCGMessage.CG_WANANSI_ENTER(this.isAskChallType);
                  }
               }
               else
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("10642",1));
               }
            }
            else
            {
               WanAnSiCGMessage.CG_WANANSI_ENTER(this.isAskChallType);
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10643",1));
         }
      }
      
      private function updateType() : void
      {
         var vo:Vo_item = null;
         var i:int = 0;
         while(i < 4)
         {
            vo = new Vo_item();
            if(WanAnSiVO.isType == 1)
            {
               vo.id = this.AWARD_ID[i];
            }
            else
            {
               vo.id = this.HELL_AWARD_ID[i];
            }
            vo.Init_lib();
            this.rewardGridVec[i].vo = vo;
            i++;
         }
         if(WanAnSiVO.isType == 2)
         {
            if(!this.hellChallBtn)
            {
               this.hellChallBtn = ComponentUtil.getButton("","Button_DiYu",this,{
                  "x":557 - 10,
                  "y":345,
                  "textColor":16184781,
                  "name":"hell"
               },Utils.swfPool[this.PATH]);
               this.hellChallBtn.addEventListener(MouseEvent.CLICK,this.onClick);
            }
            this.hellChallBtn.visible = true;
         }
         else if(Boolean(this.hellChallBtn))
         {
            this.hellChallBtn.visible = false;
         }
      }
      
      private function updateTimes() : void
      {
         this.txtTiems.text = WanAnSiVO.times + "/2";
      }
      
      public function updateServerData() : void
      {
         this.updateTimes();
         if(Boolean(this.normalChallBtn))
         {
            this.updateType();
         }
      }
      
      private function setBtn() : void
      {
         this.normalChallBtn = ComponentUtil.getButton("","Button_PuTong",this,{
            "x":371 + 8,
            "y":345,
            "textColor":16184781,
            "name":"normal"
         },Utils.swfPool[this.PATH]);
         this.normalChallBtn.addEventListener(MouseEvent.CLICK,this.onClick);
         if(WanAnSiVO.isType == 2)
         {
            this.updateType();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         var g:View_Grid = null;
         var vo:Vo_item = null;
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               Utils.loadTitle("lang/ch/WanAnSi_Imgs.swf","Title_WanAnSi",new Bitmap(),{
                  "x":254,
                  "y":5
               },this);
               Utils.loadTitle(this.PATH,"WAS_Back",this.bmBack,{
                  "x":34,
                  "y":60
               },null,this.setBtn);
               this.txtTiems = ComponentUtil.getTextField(WanAnSiVO.times + "/2",this,{
                  "x":536,
                  "autoSize":TextFieldAutoSize.CENTER,
                  "y":370,
                  "color":16777215,
                  "size":16
               });
               this.rewardGridVec = new Vector.<View_Grid>(4,true);
               i = 0;
               while(i < 4)
               {
                  g = new View_Grid();
                  g.type = Enum_type_grid.NO_DRAG;
                  g.set_tf_count(true,false,true);
                  g.set_bmp_bg();
                  g.set_bmp_select();
                  g.set_bmp_over();
                  addChild(g);
                  g.x = 416 + (Const_png.SIZE_GRID + 4) * i;
                  g.y = 300;
                  vo = new Vo_item();
                  vo.id = this.AWARD_ID[i];
                  vo.Init_lib();
                  g.vo = vo;
                  this.rewardGridVec[i] = g;
                  i++;
               }
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

