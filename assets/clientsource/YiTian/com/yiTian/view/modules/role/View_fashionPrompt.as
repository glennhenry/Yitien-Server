package com.yiTian.view.modules.role
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_fashionPrompt extends Panel123
   {
      
      private var _tfMain:MyTextField;
      
      private var _tfMall:MyTextField;
      
      private var _tfToNpc:MyTextField;
      
      private var _btnMall:Button;
      
      private var _btnToNpc:Button;
      
      public function View_fashionPrompt()
      {
         super();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":318,
            "height":200
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":270,
            "height":150
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":39,
            "y":55,
            "width":240,
            "height":75
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":84,
            "y":5
         },Global.Img_Cdm);
         move = new Rectangle(0,0,318,30);
         this._tfMain = ComponentUtil.getTextField("",this,{
            "y":74,
            "color":11523767,
            "realWidth":328,
            "multiline":true,
            "leading":5
         });
         this._tfMain.align = TextFieldAutoSize.CENTER;
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":284,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this._btnMall = ComponentUtil.getButton("商城购买","Button_TwoBule91",this,{
            "x":113,
            "y":145,
            "textColor":16184781,
            "callBack":this.openMall
         },Global.Img_Cdm);
         this._btnToNpc = ComponentUtil.getButton("时装兑换","Button_TwoBule91",this,{
            "x":113,
            "y":145,
            "textColor":16184781,
            "callBack":this.toNpc
         },Global.Img_Cdm);
         super.initDynamicView();
      }
      
      public static function get instance() : View_fashionPrompt
      {
         return Singleton.getInstance(View_fashionPrompt);
      }
      
      public function show(prm:Object) : void
      {
         var info:Array = null;
         var itemName:String = null;
         if(visible == true)
         {
            visible = false;
            return;
         }
         info = Data_lib.sjszs[prm.id];
         if(Boolean(info))
         {
            itemName = Enum_BroadCastTool.instance.getItemText(prm.id);
            this._tfMain.htmlText = LangConfig.reTxt("您还没穿戴 {0}<br>以下途径可获得",itemName);
            visible = true;
            if(info[5] == 1)
            {
               this._btnMall.visible = true;
               this._btnToNpc.visible = false;
            }
            else if(info[5] == 2)
            {
               this._btnMall.visible = false;
               this._btnToNpc.visible = true;
            }
            else
            {
               visible = false;
            }
         }
      }
      
      private function openMall(e:Event) : void
      {
         var pan:ShoppingMallPan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
         pan.openView(3,1);
         visible = false;
      }
      
      private function toNpc(e:Event) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.COMMON)
         {
            GameUnitManager.hero.autoMove(52911);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("副本地图不能前往");
         }
         visible = false;
      }
   }
}

