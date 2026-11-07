package com.yiTian.view.modules.KFHomeland
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class visiteFirHomeItem extends Sprite
   {
      
      private var headBit:Bitmap;
      
      private var nameTxt:MyTextField;
      
      private var visiteBtn:Button;
      
      private var homeId:int;
      
      private var roleId:Number;
      
      private var roleZone:int;
      
      public function visiteFirHomeItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         ComponentUtil.getBitmap("Back_HaoYouDi",this,{
            "x":0,
            "y":2
         },Global.KFJYdm);
         ComponentUtil.getBitmap("Back_HYTX",this,{
            "x":3,
            "y":16
         },Global.KFJYdm);
         ComponentUtil.getBitmap("TX_NanDao",this,{
            "x":6,
            "y":0
         },Global.KFJYdm);
         this.headBit = new Bitmap();
         addChild(this.headBit);
         this.headBit.x = 6;
         this.headBit.y = 2;
         this.nameTxt = ComponentUtil.getTextField("玩家名称9个字哈",this,{
            "x":76,
            "y":14,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.visiteBtn = ComponentUtil.getButton(LangConfig.getWord("30225",3),"Button_JYAN",this,{
            "x":85,
            "y":48,
            "textColor":16771436
         },Global.KFJYdm);
         this.visiteBtn.callBack = this.visiteFriend;
      }
      
      public function update(obj:Object) : void
      {
         Utils.getLoadBitmap("resource/image/icon/23" + Enum_job.getBaseJob(obj.jobFri) + "1" + obj.sexFri + ".png",this.headBit,null,null,MassLoader.LEVEL0);
         if(obj.roleId == GameUnitManager.hero.marriageID)
         {
            this.nameTxt.htmlText = HtmlUtil.fontNoSize(Model_heFu.repNameByHero(obj.nameFri + ".S" + obj.roleZone),"#ff3333");
         }
         else
         {
            this.nameTxt.htmlText = Model_heFu.repNameByHero(obj.nameFri + ".S" + obj.roleZone);
         }
         this.homeId = obj.idHomeFri;
         this.roleId = obj.roleId;
         this.roleZone = obj.roleZone;
      }
      
      private function visiteFriend(evt:MouseEvent) : void
      {
         if(Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg("组队状态下不能参观好友家园");
            return;
         }
         if(Model_team.hasTeam())
         {
            HomeLandCGMessage.CG_GLOBAL_TEAM_OTHERHOME();
         }
         else if(GameUnitManager.hero.captainId == 0)
         {
            HomeLandCGMessage.CG_ENTER_HOMELAND(this.roleId,1,this.roleZone);
         }
      }
   }
}

