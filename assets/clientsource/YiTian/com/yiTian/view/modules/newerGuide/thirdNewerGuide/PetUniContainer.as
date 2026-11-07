package com.yiTian.view.modules.newerGuide.thirdNewerGuide
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import com.yiTian.view.modules.treeDownCL.lUtils.MoveRoundPan;
   
   public class PetUniContainer extends MoveRoundPan
   {
      
      private static var pool:Array = [];
      
      private var playUnit:Child_tianTiUnit;
      
      public function PetUniContainer()
      {
         super();
         this.playUnit = new Child_tianTiUnit();
         this.playUnit.setFrameInterval(300);
         addChild(this.playUnit);
         this.playUnit.shadow = 1;
         ComponentUtil.setPropertie(this.playUnit,{
            "x":60,
            "y":127
         });
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         delayTime = 600;
      }
      
      public static function get instance() : PetUniContainer
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new PetUniContainer();
      }
      
      override public function update(data:Object = null) : void
      {
         this.playUnit.modelId = data.id;
         this.playUnit.way = data.way;
         this.playUnit.state = data.state;
         this.playUnit.visible = true;
      }
      
      override public function complete() : void
      {
         this.playUnit.way = 4;
         this.playUnit.state = 0;
      }
      
      override public function inGuoCheng() : void
      {
         this.playUnit.state = 1;
      }
      
      override public function outGuoCheng() : void
      {
         if(Boolean(outDt))
         {
            this.playUnit.way = outDt.way;
         }
         this.playUnit.state = 1;
      }
      
      override public function dispose() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         pool.push(this);
         this.playUnit.visible = false;
      }
      
      public function onFrame(interval:int) : void
      {
         this.playUnit.onFrame(interval);
      }
   }
}

