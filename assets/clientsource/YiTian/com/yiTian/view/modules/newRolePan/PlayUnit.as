package com.yiTian.view.modules.newRolePan
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class PlayUnit extends Sprite
   {
      
      private var ttUnit:Child_tianTiUnit;
      
      public function PlayUnit(_parent:DisplayObjectContainer, _x:int, _y:int, typeStr:String = "self")
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
         _parent.addChild(this);
         this.ttUnit = new Child_tianTiUnit();
         addChild(this.ttUnit);
         ComponentUtil.setPropertie(this,{
            "x":_x,
            "y":_y
         });
      }
      
      public function playImg(horseOther:int = 0, weaponOther:int = 0, heroSex:int = 0, roleBody:int = 0, roleJob:int = 0, playWing:int = 0) : void
      {
         this.ttUnit.way = 5;
         this.ttUnit.type = Child_tianTiUnit.PLAYER;
         this.ttUnit.modelId = roleBody;
         this.ttUnit.wing = playWing;
         this.ttUnit.horse = horseOther;
         this.ttUnit.weaponDir = weaponOther.toString();
         this.ttUnit.state = Action.STAND;
         this.ttUnit.job = roleJob;
         this.ttUnit.sex = heroSex;
         this.ttUnit.setFrameInterval(150);
         this.ttUnit.updateLayer();
         this.ttUnit.updateHorseLayer();
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.ttUnit.onFrame);
      }
   }
}

