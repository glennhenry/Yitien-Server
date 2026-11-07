package com.yiTian.view.modules.Kunlun
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KLMountianCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.text.TextFieldAutoSize;
   
   public class View_kunlunPrompt extends Panel
   {
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      private var Informat_text:MyTextField;
      
      private var bg:DisplayObjectContainer;
      
      private var isUIComplete:Boolean = false;
      
      public function View_kunlunPrompt()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":300,
            "height":180
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":40,
            "width":252,
            "height":130
         },Global.Img_Cdm);
         move = new Rectangle(0,0,width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":266,
            "y":6
         },Global.Img_Cdm);
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":55,
            "y":115,
            "textColor":10148472,
            "textOverColor":10148472
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this,{
            "x":180,
            "y":115,
            "textColor":10148472,
            "textOverColor":10148472
         },Global.Img_Cdm);
         this.Informat_text = ComponentUtil.getTextField(LangConfig.getWord("22357",2),this,{
            "y":61.75,
            "color":13434624,
            "realWidth":this.width
         });
         this.Informat_text.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.Button_Cancel.callBack = this.cancelHandle;
         this.Button_OK.callBack = this.OKHandle;
      }
      
      public function cancelHandle(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(!this.isUIComplete)
            {
               Utils.loadTitle("lang/ch/KunLun_Imgs.swf","Title_KunLun",new Bitmap(),{
                  "x":70,
                  "y":5
               },this.bg,function(info:Object):void
               {
                  if(info is ApplicationDomain)
                  {
                     Global.KunLun_Imgsdm = info as ApplicationDomain;
                  }
                  else
                  {
                     Global.KunLun_Imgsdm = info.applicationDomain;
                  }
               });
               this.isUIComplete = true;
            }
         }
         super.visible = value;
      }
      
      private function OKHandle(e:MouseEvent) : void
      {
         this.visible = false;
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22343",2));
            return;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29231",2));
            return;
         }
         if(Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22358",2));
            return;
         }
         KLMountianCGMessage.CG_ENTER_KL_MOUNTIAN();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2 - 150;
      }
   }
}

