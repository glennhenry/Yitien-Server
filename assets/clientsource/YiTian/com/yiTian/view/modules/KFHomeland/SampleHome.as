package com.yiTian.view.modules.KFHomeland
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class SampleHome extends Panel123
   {
      
      private var back:ScaleBitmap;
      
      private var buyBtn:Button;
      
      public function SampleHome()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":432,
            "height":308
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":384,
            "height":259
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":this.back.width - 37,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         if(!Global.KFJYdm)
         {
            SingleLoader.add("lang/ch/KFJY.swf",function(info:Object):void
            {
               Global.KFJYdm = info.applicationDomain;
               initJY();
            });
         }
         else
         {
            this.initJY();
         }
      }
      
      private function initJY() : void
      {
         ComponentUtil.getBitmap("Back_JiaYuan",this,{
            "x":34,
            "y":50
         },Global.KFJYdm);
         ComponentUtil.getTextField(LangConfig.getWord("30214",3),this,{
            "x":177,
            "y":229,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Title_JiaYuan",this,{
            "x":136,
            "y":5
         },Global.KFJYdm);
         this.buyBtn = ComponentUtil.getButton(LangConfig.getWord("30202",3),"Button_TwoBule91",this,{
            "x":171,
            "y":265,
            "textColor":16771436
         },Global.Img_Cdm);
         this.buyBtn.callBack = this.buyHandle;
      }
      
      private function buyHandle(evt:MouseEvent) : void
      {
         if(Boolean(VoHome.isCreatHome))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30154",3));
            return;
         }
         if(GameUnitManager.hero.bingSilver + GameUnitManager.hero.silver < 100000)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30152",3));
            return;
         }
         View_Alert.show(LangConfig.getWord("30215",3),View_Alert.OK_CANCAL,function(evt:MouseEvent):void
         {
            HomeLandCGMessage.CG_BUY_HOMELAND();
         });
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

