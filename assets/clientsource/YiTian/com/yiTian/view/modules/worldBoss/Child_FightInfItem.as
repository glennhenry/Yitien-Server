package com.yiTian.view.modules.worldBoss
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class Child_FightInfItem extends Sprite
   {
      
      public var _tfRank:MyTextField;
      
      private var _tfRoleName:MyTextField;
      
      private var _tfDamagePercent:MyTextField;
      
      public function Child_FightInfItem()
      {
         super();
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":0,
            "y":0,
            "width":234,
            "height":26
         },Global.Img_Cdm);
         this._tfRank = ComponentUtil.getTextField("",this,{
            "x":15,
            "y":4,
            "color":13424242
         });
         this._tfRoleName = ComponentUtil.getTextField("",this,{
            "x":100,
            "y":4,
            "color":13424242
         });
         this._tfRoleName.autoSize = TextFieldAutoSize.CENTER;
         this._tfDamagePercent = ComponentUtil.getTextField("",this,{
            "x":193,
            "y":4,
            "color":16383744
         });
         this._tfDamagePercent.autoSize = TextFieldAutoSize.CENTER;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         transform.colorTransform = Util.colorWhite2;
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         transform.colorTransform = Util.colorNomal;
      }
      
      public function update(v:Object) : void
      {
         if(v == null)
         {
            visible = false;
            return;
         }
         visible = true;
         this._tfRoleName.text = v[Enum_WorldBoss.RANK_ROLENAME];
         this._tfDamagePercent.text = (v[Enum_WorldBoss.RANK_DAMAGEPERCENT] / 100).toString() + "%";
      }
   }
}

