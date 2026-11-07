package com.yiTian.view.modules.guangMingDing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class Child_RoomItem extends Sprite
   {
      
      private var _mouseArea:Sprite;
      
      private var _bmLock:Bitmap;
      
      private var _bmUnlock:Bitmap;
      
      private var _tfRoomIndex:MyTextField;
      
      private var _tfNumPlayer:MyTextField;
      
      private var _tfCapName:MyTextField;
      
      public var id:int;
      
      public var isEnable:Boolean = false;
      
      private var _data:*;
      
      private var rollOverRect:DisplayObject;
      
      public function Child_RoomItem()
      {
         super();
         this._mouseArea = new Sprite();
         addChild(this._mouseArea);
         this._mouseArea.buttonMode = true;
         ComponentUtil.getBitmap("Back_Room",this._mouseArea,null,Global.GuangMingDing_Imgdm);
         this._bmLock = ComponentUtil.getBitmap("Lock_Img",this,{
            "x":140,
            "y":34
         },Global.GuangMingDing_Imgdm);
         this._bmUnlock = ComponentUtil.getBitmap("UnLock_Img",this,{
            "x":140,
            "y":34
         },Global.GuangMingDing_Imgdm);
         this._tfRoomIndex = ComponentUtil.getTextField("",this,{
            "x":10,
            "y":10,
            "color":16777087,
            "bold":true
         });
         this._tfNumPlayer = ComponentUtil.getTextField("",this,{
            "x":70,
            "y":131,
            "color":15648030,
            "size":20
         });
         this._tfCapName = ComponentUtil.getTextField("",this,{
            "x":160,
            "y":10,
            "color":16777087
         });
         this._tfCapName.autoSize = TextFieldAutoSize.RIGHT;
         doubleClickEnabled = true;
         this._mouseArea.addEventListener(MouseEvent.CLICK,this.clickHd);
         this._mouseArea.buttonMode = true;
         this._mouseArea.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this._mouseArea.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         this.rollOverRect = this.rollOverRect || ComponentUtil.getBitmap("Round",this,null,Global.GuangMingDing_Imgdm);
         this.rollOverRect.visible = this.rollOverRect.visible || true;
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         if(this.rollOverRect != null)
         {
            this.rollOverRect.visible = false;
         }
      }
      
      private function clickHd(e:MouseEvent) : void
      {
         if(this._data[Enum_guangMingDing.TEAM_NUM_MEMBER] >= this._data[Enum_guangMingDing.TEAM_MAX_MEMBER])
         {
            UIManager.centerBroadcast.addMsg("该房间已满人");
            return;
         }
         GuangMingDingCGMessage.CG_GMD_INVITE_RESPON(this.id,"-1");
      }
      
      public function update(data:Object) : void
      {
         this._data = data;
         if(data != null)
         {
            visible = true;
            this.id = data[Enum_guangMingDing.TEAM_ID];
            this._bmLock.visible = data[Enum_guangMingDing.TEAM_PASSWORD] != "";
            this._bmUnlock.visible = !this._bmLock.visible;
            this._tfRoomIndex.text = "NO." + data[Enum_guangMingDing.TEAM_ID].toString();
            this._tfNumPlayer.text = data[Enum_guangMingDing.TEAM_NUM_MEMBER].toString() + "/" + data[Enum_guangMingDing.TEAM_MAX_MEMBER].toString();
            this._tfCapName.htmlText = "<font color=\'#99ff33\'>" + Model_heFu.repNameByHero(data[Enum_guangMingDing.TEAM_CAPTION_NAME]) + "</font> ";
         }
         else
         {
            this._tfNumPlayer.text = "0/3";
            visible = false;
         }
      }
   }
}

