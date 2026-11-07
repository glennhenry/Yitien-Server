package com.yiTian.view.modules.jianghulixian
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_Jianghulixian;
   import com.yiTian.data.model.Model_Jianghulixian;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_Jianghulixian_icon extends Sprite
   {
      
      private static var _instance:View_Jianghulixian_icon;
      
      private var _bg:Bitmap;
      
      private var _ef:Effect;
      
      private var tipBm:Bitmap;
      
      private var tipTF:MyTextField;
      
      public function View_Jianghulixian_icon()
      {
         super();
      }
      
      public static function get instance() : View_Jianghulixian_icon
      {
         if(!_instance)
         {
            _instance = new View_Jianghulixian_icon();
            _instance.init();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/jianghulixian/jianghulixian.png",this._bg);
         this.buttonMode = true;
         this.addChild(this._bg);
         this.tipBm = ComponentUtil.getBitmap("cishu_tis",this,{
            "x":2,
            "y":2
         },Global.New_Imgsdm);
         this.tipTF = ComponentUtil.getTextField("",this,{
            "size":11,
            "color":16771584,
            "x":this.tipBm.x + this.tipBm.width / 2 - 2.5,
            "y":5
         },"center");
         this.setCount(Model_Jianghulixian.leftTimes);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.MOVE_TO_HIDE,this.onHide);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.SET_COUNT,this.onSetCount);
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         if(View_Jianghulixian_menu.IsInit)
         {
            View_Jianghulixian_menu.instance.visible = !View_Jianghulixian_menu.instance.visible;
            return;
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_Jianghulixian_menu.instance,function():void
         {
            View_Jianghulixian_menu.IsInit = true;
            View_Jianghulixian_menu.instance.visible = true;
            Global.control.sendNotification(Enum_Jianghulixian.Jianghulixian_UPDATE_LEFT_TIME,null);
         });
      }
      
      private function onSetCount(arr:Array) : void
      {
         if(arr[0] == Enum_mainUIBtn_hide.JiangHuLiXian)
         {
            this.setCount(arr[1]);
         }
      }
      
      private function setCount(count:int) : void
      {
         if(count < 1)
         {
            this.tipBm.visible = false;
            this.tipTF.text = "";
         }
         else
         {
            this.tipBm.visible = true;
            this.tipTF.text = count.toString();
         }
      }
      
      private function onHide() : void
      {
         UIManager.mainUiBtnContainer.partPauseRemove(this,1);
      }
   }
}

