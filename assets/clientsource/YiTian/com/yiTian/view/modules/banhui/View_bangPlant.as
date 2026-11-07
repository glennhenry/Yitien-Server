package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_bangPlant extends Panel
   {
      
      private static var isFirstOpen:Boolean = true;
      
      private static var isLoad:Boolean = false;
      
      private var str:String;
      
      private var enterGarden:Button;
      
      private var descripeTF:MyTextField;
      
      private var back:DisplayObject;
      
      public function View_bangPlant()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":388,
            "height":360
         },Global.Img_Cdm);
         var back2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":22,
            "y":40,
            "width":344,
            "height":270
         },Global.Img_Cdm);
         move = new Rectangle(0,0,357,38);
         this.str = HtmlUtil.font(LangConfig.getWord("50035",5),"#f9ff00",14) + LangConfig.getWord("50036",5);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":350,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.enterGarden = ComponentUtil.getButton(LangConfig.getWord("50034",5),"Button_Four",this,{
            "x":155,
            "y":318,
            "textColor":16184781
         },Global.Img_Cdm);
         this.descripeTF = ComponentUtil.getTextField("",this,{
            "x":32,
            "y":52,
            "color":11904647,
            "realWidth":319,
            "wordWrap":true,
            "multiline":true,
            "leading":7
         });
         this.descripeTF.htmlText = this.str;
         this.enterGarden.callBack = this.enterHandle;
      }
      
      private function enterHandle(e:MouseEvent) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10379",1) + "</font>");
            return;
         }
         if(Boolean(GameUnitManager.hero.paoBiao))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("990",0));
            return;
         }
         if(Model_bang.partyType == 1)
         {
            UIManager.centerBroadcast.addMsg("公共帮会不能参与帮会种植活动");
            return;
         }
         if(!GameUnitManager.hero.partyId)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("934",0));
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.BANGPLANT)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("933",0));
            return;
         }
         BangCGMessage.CG_BANG_ENTER_PLANT();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(isFirstOpen)
            {
               isFirstOpen = false;
               if(!Global.Bang_Imgsdm)
               {
                  SingleLoader.add("lang/ch/Bang_Imgs.swf",function(info:Object):void
                  {
                     Global.Bang_Imgsdm = info.applicationDomain;
                     showBmp();
                  });
               }
               else if(!isLoad)
               {
                  this.showBmp();
               }
            }
         }
      }
      
      private function showBmp() : void
      {
         isLoad = true;
         ComponentUtil.getBitmap("Title_BangPlant",this,{
            "x":114,
            "y":5
         },Global.Bang_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 387) / 2;
         y = (Global.stage.stageHeight - 358) / 2;
      }
   }
}

