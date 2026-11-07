package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_Battle;
   import com.yiTian.data.vo.Vo_battle_lib_data;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_farm_tip_panel extends Panel
   {
      
      private static var _pool:Vector.<View_farm_tip_panel>;
      
      public static const type_battle_video:uint = 0;
      
      public static const type_rescue:uint = 1;
      
      private var _type:uint;
      
      private var _info:Object;
      
      private var _battleResult:MyTextField;
      
      private var _battleVideo:MyTextField;
      
      private var _rescueTxt_0:MyTextField;
      
      private var _rescueTxt_1:MyTextField;
      
      private var _rescueBtn:Button;
      
      public function View_farm_tip_panel()
      {
         super();
      }
      
      public static function getInstace() : View_farm_tip_panel
      {
         var panel:View_farm_tip_panel = null;
         if(Boolean(_pool) && Boolean(_pool.length))
         {
            return _pool.pop();
         }
         panel = new View_farm_tip_panel();
         panel.init();
         return panel;
      }
      
      public function dispose() : void
      {
         if(!_pool)
         {
            _pool = new Vector.<View_farm_tip_panel>();
         }
         _pool.push(this);
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":285,
            "height":185
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":248,
            "height":135
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":70,
            "y":5
         },Global.Img_Cdm);
         move = new Rectangle(0,0,285,185);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":268,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      public function update(info:Object) : void
      {
         this._type = info.noticeType;
         this._info = info;
         this.hideAll();
         if(this._type == View_farm_tip_panel.type_battle_video)
         {
            if(!this._battleResult)
            {
               this._battleResult = ComponentUtil.getTextField("",this,{
                  "color":ColorConstant.getColorInt(4),
                  "leading":7,
                  "realWidth":232,
                  "wordWrap":true,
                  "multiline":true
               });
               this._battleResult.x = 28;
               this._battleResult.y = 65;
               this._battleResult.addEventListener(TextEvent.LINK,this.onLinkCheckRoleInfo);
               this._battleResult.mouseEnabled = true;
               this._battleResult.align = TextAlign.CENTER;
            }
            if(!this._battleVideo)
            {
               this._battleVideo = ComponentUtil.getTextField("",this,{
                  "color":ColorConstant.getColorInt(4),
                  "leading":7,
                  "realWidth":232,
                  "wordWrap":true,
                  "multiline":true
               });
               this._battleVideo.x = 28;
               this._battleVideo.y = 135;
               this._battleVideo.htmlText = HtmlUtil.createLink(LangConfig.getWord("50",9),true);
               this._battleVideo.align = TextAlign.CENTER;
               this._battleVideo.addEventListener(TextEvent.LINK,this.onLinkBattleVideo);
               this._battleVideo.mouseEnabled = true;
            }
            this._battleResult.htmlText = info.text;
            this._battleResult.visible = true;
            this._battleVideo.visible = true;
         }
         else if(this._type == View_farm_tip_panel.type_rescue)
         {
            if(!this._rescueTxt_0)
            {
               this._rescueTxt_0 = ComponentUtil.getTextField("",this,{
                  "color":ColorConstant.getColorInt(4),
                  "leading":7,
                  "realWidth":232,
                  "wordWrap":true,
                  "multiline":true
               });
               this._rescueTxt_0.x = 32;
               this._rescueTxt_0.y = 56;
               this._rescueTxt_0.mouseEnabled = true;
               this._rescueTxt_0.addEventListener(TextEvent.LINK,this.onLinkCheckRoleInfo);
            }
            this._rescueTxt_0.htmlText = info.text;
            if(!this._rescueTxt_1)
            {
               this._rescueTxt_1 = ComponentUtil.getTextField("",this,{
                  "color":ColorConstant.getColorInt(4),
                  "leading":7,
                  "realWidth":210,
                  "wordWrap":true,
                  "multiline":true
               });
               this._rescueTxt_1.x = 40;
               this._rescueTxt_1.y = 82;
               this._rescueTxt_1.mouseEnabled = true;
               this._rescueTxt_1.align = TextAlign.CENTER;
               this._rescueTxt_1.addEventListener(TextEvent.LINK,this.onLinkCheckRoleInfo);
            }
            this._rescueTxt_1.htmlText = info.text_1;
            if(!this._rescueBtn)
            {
               this._rescueBtn = ComponentUtil.getButton(LangConfig.getWord("51",9),"Button_Four",this,{
                  "x":118,
                  "y":135
               },Global.Img_Cdm);
               this._rescueBtn.addEventListener(MouseEvent.CLICK,this.onClickRescue);
            }
            this._rescueBtn.visible = true;
            this._rescueTxt_0.visible = true;
            this._rescueTxt_1.visible = true;
         }
      }
      
      private function onLinkBattleVideo(evt:TextEvent) : void
      {
         var bid:uint = uint(this._info.battle_id);
         if(bid == 0)
         {
            return;
         }
         var vo:Vo_battle_lib_data = Model_Battle.getBattleVideoData(bid);
         if(Boolean(vo))
         {
            BattleManager.init(vo);
         }
      }
      
      private function onLinkCheckRoleInfo(evt:TextEvent) : void
      {
         var id:Number = Number(evt.text);
         RoleCGMessage.CG_CHECK_OTHERROLE(id);
      }
      
      private function onClickRescue(evt:MouseEvent) : void
      {
         this.visible = false;
         if(GameUnitManager.hero.status == Status.WU_LING)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("183",9));
            return;
         }
         FarmCGMessage.cg_farm_seekHelp(this._info.seek_id,this._info.be_seek_id,this._info.seek_master_id,"",2);
      }
      
      private function hideAll() : void
      {
         if(Boolean(this._battleResult))
         {
            this._battleResult.visible = false;
         }
         if(Boolean(this._battleVideo))
         {
            this._battleVideo.visible = false;
         }
         if(Boolean(this._rescueBtn))
         {
            this._rescueBtn.visible = false;
         }
         if(Boolean(this._rescueTxt_0))
         {
            this._rescueTxt_0.visible = false;
         }
         if(Boolean(this._rescueTxt_1))
         {
            this._rescueTxt_1.visible = false;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.dispose();
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

