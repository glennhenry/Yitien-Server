package com.yiTian.view.modules.tianTi
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class Child_xinFaCJ extends Sprite
   {
      
      public static var vecX:Vector.<int> = new <int>[25,75,122,170,222];
      
      public static const Y1:Number = 17;
      
      public static const OFFSET:Number = 49.5;
      
      private var sbVec:Vector.<Child_xinFaCJH>;
      
      private var _mask:Shape;
      
      private var bg:Bitmap;
      
      private var _isShake:Boolean = false;
      
      private const interval:int = 60;
      
      private var tmp:int;
      
      public function Child_xinFaCJ()
      {
         super();
         this.bg = new Bitmap();
         addChild(this.bg);
      }
      
      public function init() : void
      {
         var i:int = 0;
         var a:Child_xinFaCJH = null;
         var b:Bitmap = new Bitmap();
         addChild(b);
         Utils.loadTitle("lang/ch/Challenge_Imgs.swf","Back_YaoJiang",b,null,null);
         this.sbVec = new Vector.<Child_xinFaCJH>();
         i = 0;
         while(i < 5)
         {
            a = new Child_xinFaCJH();
            a.x = vecX[i];
            a.y = Y1;
            addChild(a);
            this.sbVec.push(a);
            a.init();
            i += 1;
         }
      }
      
      public function showCJEnd(results:Array, nxtInfos:Array) : void
      {
         var i:int = 0;
         var j:int = 0;
         var arr:Array = [0,0,0,0,0];
         var isAllDiff:Boolean = true;
         var _curArr:Array = results;
         i = 0;
         while(i < _curArr.length)
         {
            j = i + 1;
            while(j < _curArr.length)
            {
               if(_curArr[i] == _curArr[j])
               {
                  isAllDiff = false;
               }
               j += 1;
            }
            if(!isAllDiff)
            {
               break;
            }
            i += 1;
         }
         if(isAllDiff)
         {
            i = 0;
            while(i < _curArr.length)
            {
               arr[i] = _curArr[i];
               i += 1;
            }
         }
         else
         {
            i = 0;
            while(i < _curArr.length - 1)
            {
               j = i + 1;
               while(j < _curArr.length)
               {
                  if(_curArr[i] == _curArr[j])
                  {
                     arr[i] = arr[j] = _curArr[i];
                  }
                  j += 1;
               }
               i += 1;
            }
         }
         UIManager.xinFaPanel.showEffect(arr,nxtInfos);
      }
      
      public function shake() : void
      {
         if(this._isShake)
         {
            return;
         }
         this._isShake = true;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
      }
      
      public function stopShake() : void
      {
         if(!this._isShake)
         {
            return;
         }
         this._isShake = false;
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         x = Enum_ZhangMenRen.CJX;
         y = Enum_ZhangMenRen.CJY;
      }
      
      private function onFrame(i:int) : void
      {
         this.tmp += i;
         if(this.tmp >= this.interval)
         {
            this.tmp = 0;
            x = Enum_ZhangMenRen.CJX + -5 + Math.random() * 10;
            y = Enum_ZhangMenRen.CJY + -3 + Math.random() * 6;
         }
      }
      
      public function start(results:Array, nxtInfos:Array, base:int, acc:int) : void
      {
         var i:int = 0;
         while(i < results.length)
         {
            this.sbVec[i].start(results[i],results,nxtInfos,base,acc);
            i += 1;
         }
         Child_xinFaCJH.tt1 = 0;
      }
   }
}

