package com.yiTian.utils.shake
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import flash.display.Sprite;
   
   public class EffectShake
   {
      
      public static var _shake:Array = [];
      
      public function EffectShake()
      {
         super();
      }
      
      public static function update() : void
      {
         var index:Number = NaN;
         index = _shake.length - 1;
         while(index >= 0)
         {
            shake(index);
            index--;
         }
      }
      
      public static function addShake(cont:Sprite, xspeed:Number, yspeed:Number, xsteps:Number, ysteps:Number) : void
      {
         var index:Number = NaN;
         if(null != cont)
         {
            index = ArrayObject.isIndex(_shake,cont,0);
            if(-1 == index)
            {
               _shake.push([cont,[xspeed,yspeed,xsteps,ysteps],[cont.x,cont.y]]);
            }
            else if(_shake[index][1][0] + _shake[index][1][1] <= xspeed + yspeed)
            {
               _shake[index][1] = [xspeed,yspeed,xsteps,ysteps];
            }
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,update);
      }
      
      private static function removeIndex(index:Number) : void
      {
         var cont:Sprite = null;
         var pointArr:Array = null;
         cont = _shake[index][0];
         if(Boolean(cont))
         {
            pointArr = _shake[index][2];
            cont.x = pointArr[0];
            cont.y = pointArr[1];
         }
         _shake.splice(index,1);
      }
      
      private static function shake(index:Number) : void
      {
         var data:Array = null;
         var isShake:Boolean = false;
         var value:Array = _shake[index];
         var spt:Sprite = value[0];
         if(!spt)
         {
            removeIndex(index);
            return;
         }
         data = value[1];
         var start:Array = value[2];
         if(!isNaN(data[2]) && data[2] > 0)
         {
            spt.x = value[2][0] + NumberObject.random(1,-1) * data[0];
            --data[2];
            isShake = true;
         }
         if(!isNaN(data[3]) && data[3] > 0)
         {
            spt.y = value[2][1] + NumberObject.random(1,-1) * data[1];
            --data[3];
            isShake = true;
         }
         if(!isShake)
         {
            removeIndex(index);
         }
      }
      
      public static function deleteMe() : void
      {
         var index:Number = NaN;
         index = _shake.length - 1;
         while(index >= 0)
         {
            removeIndex(index);
            index--;
         }
         if(_shake.length == 0)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,update);
         }
      }
   }
}

