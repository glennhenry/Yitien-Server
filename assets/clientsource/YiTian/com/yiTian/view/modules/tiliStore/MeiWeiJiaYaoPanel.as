package com.yiTian.view.modules.tiliStore
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TiLiCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class MeiWeiJiaYaoPanel extends Panel
   {
      
      private var btn:Button;
      
      private var bm:Bitmap;
      
      private var bmBack:Bitmap;
      
      private var MUB:MainUIBtn;
      
      private var eff:Effect;
      
      public function MeiWeiJiaYaoPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var t:MyTextField = null;
         var b:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":368,
            "height":230
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":320,
            "height":155
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,16],this,{
            "x":56,
            "y":59,
            "width":250,
            "height":85
         },Global.Img_Cdm);
         move = new Rectangle(0,0,b.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":334,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn = ComponentUtil.getButton(LangConfig.getWord("80",0),"Button_Orange",this,{
            "x":145,
            "y":156,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn.addEventListener(MouseEvent.CLICK,this.btnOnClick);
         ComponentUtil.getTextField(LangConfig.getWord("81",0),this,{
            "x":158,
            "y":70,
            "color":16764206,
            "size":16,
            "leading":0
         });
         t = ComponentUtil.getTextField("",this);
         t.color = 16764206;
         t.htmlText = LangConfig.getWord("82",0) + "<font color=\"#00CC00\">" + LangConfig.getWord("83",0) + "</font>\n" + LangConfig.getWord("84",0);
         t.x = 157;
         t.y = 99;
         t = ComponentUtil.getTextField("",this);
         t.color = 16764206;
         t.htmlText = LangConfig.getWord("85",0) + "<font color=\"#F9FF00\">12:00</font>" + LangConfig.getWord("86",0) + "<font color=\"#F9FF00\">18:00</font>" + LangConfig.getWord("87",0) + "<font color=\"#00CC00\">" + LangConfig.getWord("88",0) + "</font>";
         t.x = 34;
         t.y = 200;
         this.bmBack = new Bitmap();
         this.bmBack.x = 78;
         this.bmBack.y = 66;
         addChild(this.bmBack);
         this.bm = new Bitmap();
         this.bm.x = this.bmBack.x + 3;
         this.bm.y = this.bmBack.y + 3;
         addChild(this.bm);
      }
      
      protected function btnOnClick(e:MouseEvent) : void
      {
         if(GameUnitManager.hero.vigor > 1200)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("89",0));
         }
         else
         {
            TiLiCGMessage.CG_GET_TILI();
         }
      }
      
      public function showMUB() : void
      {
         if(!this.MUB)
         {
            this.MUB = new MainUIBtn("resource/image/tili/icon_50.png");
            this.MUB.addEventListener(MouseEvent.CLICK,this.MUBOnClick);
         }
         if(!this.eff)
         {
            this.eff = EffectManager.addEffect("35343",this,1000,32,29,true);
            this.MUB.addChild(this.eff);
         }
         UIManager.mainUiBtnContainer.addBTN(this.MUB);
      }
      
      public function hideMUB() : void
      {
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
         UIManager.mainUiBtnContainer.removeBTN(this.MUB);
         this.visible = false;
      }
      
      protected function MUBOnClick(e:MouseEvent) : void
      {
         this.visible = !this.visible;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.bmBack.bitmapData)
            {
               Utils.getLoadBitmap(View_Grid.GRID_BIGGEST_OPEN,this.bmBack);
            }
            if(!this.bm.bitmapData)
            {
               Utils.getLoadBitmap("resource/image/tili/Bz_65.png",this.bm);
               Utils.loadTitle("lang/ch/TLLingQuImgs.swf","MWJiaYao",new Bitmap(),{
                  "x":104,
                  "y":5
               },this);
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

