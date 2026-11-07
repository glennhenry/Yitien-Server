package com.yiTian.view.modules.qiJu
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_QiJu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.handler.QiJuHandler;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class MyTeamItem extends Sprite
   {
      
      private static const LABEL_ARRA:Array = [LangConfig.getWord("80138",8),LangConfig.getWord("80139",8)];
      
      private var titleTF:MyTextField;
      
      private var button:Button;
      
      private var teamBitmap:Bitmap;
      
      private var iconBitmap:Bitmap;
      
      private var vo:MyTeamVo;
      
      public function MyTeamItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":0,
            "width":195,
            "height":2
         },Global.Img_Cdm);
         this.titleTF = ComponentUtil.getTextField("",this,{
            "x":48,
            "y":6,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.titleTF.mouseEnabled = true;
         this.titleTF.addEventListener(TextEvent.LINK,QiJuHandler.linkHandler);
         this.button = ComponentUtil.getButton("","Button_Two",this,{
            "x":140,
            "y":3,
            "textColor":16773818
         },Global.Img_Cdm);
         this.button.callBack = this.butFun;
         this.iconBitmap = new Bitmap();
         addChild(this.iconBitmap);
         ComponentUtil.setPropertie(this.iconBitmap,{
            "x":25,
            "y":8
         });
         this.teamBitmap = new Bitmap();
         addChild(this.teamBitmap);
         ComponentUtil.setPropertie(this.teamBitmap,{
            "x":2,
            "y":5
         });
      }
      
      public function show(vo:MyTeamVo) : void
      {
         this.vo = vo;
         this.button.visible = this.teamBitmap.visible = this.iconBitmap.visible = true;
         this.titleTF.htmlText = "<u><a href=\'event:role_" + vo.id + "\'>" + vo.name + "</a></u>";
         Utils.getLoadBitmap(QiJuHandler.getHeatUrl(vo.sex,vo.job),this.iconBitmap);
         this.showTeamIcon();
         this.upBtn();
      }
      
      public function showTeamIcon() : void
      {
         if(!Global.ZLQiJundm || !this.vo)
         {
            return;
         }
         var teamStr:String = this.vo.isCaptain == 0 ? "BG_DZ" : "BG_DY";
         this.teamBitmap.bitmapData = ComponentUtil.getBitmapData(teamStr,Global.ZLQiJundm);
      }
      
      private function upBtn() : void
      {
         if(Model_QiJu.isCaptain)
         {
            this.button.visible = true;
            if(this.vo.id != GameUnitManager.hero.id)
            {
               this.button.label = LABEL_ARRA[1];
            }
            else
            {
               this.button.label = LABEL_ARRA[0];
            }
         }
         else if(this.vo.id == GameUnitManager.hero.id)
         {
            this.button.visible = true;
            this.button.label = LABEL_ARRA[0];
         }
         else
         {
            this.button.visible = false;
         }
      }
      
      private function butFun(event:MouseEvent) : void
      {
         var label:String = event.target.label;
         switch(label)
         {
            case LABEL_ARRA[0]:
               QiJuCGMessage.CG_EXIT_QIJU_TEAM(0);
               break;
            case LABEL_ARRA[1]:
               QiJuCGMessage.CG_T_QIJU_TEAM(Model_QiJu.team_id,this.vo.id);
         }
      }
      
      public function dispose() : void
      {
         this.titleTF.htmlText = "<font color=\'#B5A687\'>" + LangConfig.getWord("80140",8) + "</font>";
         this.button.visible = this.teamBitmap.visible = this.iconBitmap.visible = false;
         this.vo = null;
      }
   }
}

