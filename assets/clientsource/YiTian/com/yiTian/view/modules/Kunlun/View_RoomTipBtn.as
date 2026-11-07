package com.yiTian.view.modules.Kunlun
{
   import com.yiTian.Global;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_changeRoom;
   import com.yiTian.view.modules.KuaFuPaiDui.View_KuaFuPaiDui_roomMenu;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_RoomTipBtn extends Sprite
   {
      
      private static var _instance:View_RoomTipBtn;
      
      private var _bm:Bitmap;
      
      public function View_RoomTipBtn()
      {
         super();
         this.init();
      }
      
      public static function isInstance() : Boolean
      {
         return _instance != null;
      }
      
      public static function getInstance() : View_RoomTipBtn
      {
         if(!_instance)
         {
            _instance = new View_RoomTipBtn();
         }
         return _instance;
      }
      
      protected function init() : void
      {
         this._bm = Utils.getLoadBitmap("resource/image/extralPng/klRoom.png",this._bm);
         addChild(this._bm);
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      protected function clickHandle(evt:MouseEvent) : void
      {
         var st:int = SceneConfig.getSceneType();
         if(st == SceneConfig.KUNLUN)
         {
            UIManager.kl_roomInfo.visible = !UIManager.kl_roomInfo.visible;
         }
         else if(st == SceneConfig.FISH || st == SceneConfig.BEACH)
         {
            UIManager.riverChoose.visible = !UIManager.riverChoose.visible;
         }
         else if(st == SceneConfig.AiDeBaoBao)
         {
            Global.delegate.dosomething(View_AiDeBaoBao_changeRoom.instance,function():void
            {
               View_AiDeBaoBao_changeRoom.instance.visible = !View_AiDeBaoBao_changeRoom.instance.visible;
            });
         }
         else if(st == SceneConfig.KuaFuPaiDui)
         {
            View_KuaFuPaiDui_roomMenu.instance.visible = true;
         }
      }
      
      public function dispose() : void
      {
         _instance = null;
      }
   }
}

