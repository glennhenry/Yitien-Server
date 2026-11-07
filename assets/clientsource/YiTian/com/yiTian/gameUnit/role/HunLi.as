package com.yiTian.gameUnit.role
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Tween;
   import flash.utils.Dictionary;
   
   public class HunLi extends Role
   {
      
      public static var list:Dictionary = new Dictionary();
      
      public static var pool:Array = new Array();
      
      public var sysId:Number;
      
      public var npcType:int;
      
      public var roleId:Number;
      
      public var talkTxt:String = "(*^__^*)";
      
      public function HunLi()
      {
         super();
         type = UnitType.HUNLI;
      }
      
      public function init(objId:Number, sysId:Number, GlobalX:int, GlobalY:int, dir:int, action:int, route:Array, buffer:Array, isScript:Boolean = false) : void
      {
         hp = 1;
         hpMax = 1;
         mp = 1;
         mpMax = 1;
         id = objId;
         this.sysId = sysId;
         type = UnitType.NPC;
         var _npc:Array = Data_lib.npc[sysId];
         if(!isScript)
         {
            name = _npc[Npc.NAME];
         }
         global_x = GlobalX;
         global_y = GlobalY;
         this.speed = 100;
         nameBar.y = isScript == false ? _npc[Npc.NAME_HEIGHT] * -1 : -145;
         setShadow(Status.NOMAL,11);
         if(!isScript)
         {
            setBody(Status.NOMAL,_npc[Npc.BODY]);
         }
         else
         {
            setBody(action,sysId);
         }
         way = dir;
         status = Status.NOMAL;
         action = action;
      }
      
      override public function show() : void
      {
         super.show();
         list[id] = this;
      }
      
      override public function update(now:int) : void
      {
         var n:String = name;
         var roldid:Number = id;
         super.update(now);
      }
      
      override public function interaction(mode:int = 0) : void
      {
         this.interactionBehv();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         delete list[id];
         visible = true;
         if(pool.indexOf(this) == -1)
         {
            pool.push(this);
         }
         Tween.stop(this);
         this.talkTxt = "(*^__^*)";
      }
      
      private function interactionBehv() : void
      {
         UIManager.centerBroadcast.addMsg(this.talkTxt);
      }
   }
}

