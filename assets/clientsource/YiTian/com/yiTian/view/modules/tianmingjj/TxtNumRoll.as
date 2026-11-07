package com.yiTian.view.modules.tianmingjj
{
   import com.ui.controls.MyTextField;
   import com.yiTian.scene.GameScene;
   import flash.utils.Dictionary;
   
   public class TxtNumRoll
   {
      
      private static var instance:TxtNumRoll;
      
      private var dic:Dictionary = new Dictionary(true);
      
      public function TxtNumRoll()
      {
         super();
         GameScene.instance.addFrameCallBack(this.run);
      }
      
      public static function getInstance() : TxtNumRoll
      {
         if(!instance)
         {
            instance = new TxtNumRoll();
         }
         return instance;
      }
      
      public function addTimeTic(txt:MyTextField, start:int, end:int, endFunction:Function = null) : void
      {
         var vo:Vo_roll = null;
         if(!this.dic[txt])
         {
            vo = new Vo_roll();
            this.dic[txt] = vo;
         }
         vo = this.dic[txt];
         vo.tf = txt;
         vo.startIndex = start;
         vo.endFun = endFunction;
         vo.endIndex = end;
         vo.add = vo.Running ? int(Math.ceil((end - vo.temp) / 20)) : int(Math.ceil((end - start) / 20));
      }
      
      public function run() : void
      {
         var now:int = 0;
         var vo:Vo_roll = null;
         var tf:MyTextField = null;
         var p:* = undefined;
         for(p in this.dic)
         {
            vo = this.dic[p];
            tf = vo.tf;
            now = int(tf.text);
            if(now >= vo.endIndex)
            {
               tf.text = vo.endIndex + "";
               vo.add = 0;
               vo.Running = false;
               if(vo.endFun != null)
               {
                  vo.endFun();
                  vo.endFun = null;
               }
               delete this.dic[p];
            }
            else
            {
               now += vo.add;
               tf.text = now.toString();
            }
         }
      }
   }
}

import com.ui.controls.MyTextField;

class Vo_roll
{
   
   public var tf:MyTextField;
   
   public var startIndex:int;
   
   public var endIndex:int;
   
   public var endFun:Function;
   
   public var Running:Boolean;
   
   public var temp:int;
   
   public var add:int;
   
   public function Vo_roll()
   {
      super();
   }
}
