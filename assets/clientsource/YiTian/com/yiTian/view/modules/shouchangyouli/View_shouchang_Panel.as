package com.yiTian.view.modules.shouchangyouli
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ShouchangCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class View_shouchang_Panel extends Panel
   {
      
      private var grid:View_Grid;
      
      private var isInit:Boolean;
      
      private var shouchangDm:ApplicationDomain;
      
      public function View_shouchang_Panel()
      {
         super();
      }
      
      public function flyToBag() : void
      {
         var item:Vo_item = null;
         item = new Vo_item();
         item.id = 44605;
         item.Init_lib();
         ComboTweenStep.toBag(item,this.x + 220,this.y + 160);
      }
      
      private function saveToDesk(e:MouseEvent) : void
      {
         Model_shouCang.addDesktopUrl(Global.zoneid,"http://yi.qq.com/?ADTAG=ied.guanwang.renwu.tubiao",function():void
         {
            UIManager.centerBroadcast.addMsg("收藏完成");
            ShouchangCGMessage.CG_SHOUCHANG();
         },function():void
         {
            UIManager.centerBroadcast.addMsg("ioE");
         },function():void
         {
            visible = false;
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!this.isInit && value)
         {
            this.loadTitle();
            this.isInit = true;
         }
      }
      
      private function loadTitle() : void
      {
         var arr:Array = [];
         arr.push(["lang/ch/ShouCang.swf",this.loadCom,LangConfig.getWord("10550",1),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr);
      }
      
      private function loadCom(info:Object) : void
      {
         this.shouchangDm = info.applicationDomain;
         ComponentUtil.getBitmap("Back_SC",this,{
            "x":0,
            "y":0
         },this.shouchangDm);
         ComponentUtil.getBitmap("Logo",this,{
            "x":188,
            "y":130
         },this.shouchangDm);
         ComponentUtil.getTextField("   收藏游戏到桌面快捷方式\n可快速进入游戏，并立即获得价值",this,{
            "x":177,
            "y":52,
            "color":15400706,
            "size":12,
            "leading":0
         });
         var btn:Button = ComponentUtil.getButton("收藏","Button_TwoBule91",this,{
            "x":212,
            "y":244,
            "textColor":16184781
         },Global.Img_Cdm);
         btn.addEventListener(MouseEvent.CLICK,this.saveToDesk);
         CloseButton = ComponentUtil.getButton("","NPC_Close",this,{
            "x":435,
            "y":35,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.callBack = this.onClose;
      }
      
      private function onClose(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 513) / 2;
         y = (Global.stage.stageHeight - 290) / 2;
      }
   }
}

