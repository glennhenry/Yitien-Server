package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   
   public class View_babyTip extends View_tip
   {
      
      private static var list:Array = [];
      
      public static var gapArr:Array = [0,70,75,76,77,75];
      
      protected var gap:int = 80;
      
      public function View_babyTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         var tf:MyTextField = null;
         addBorder();
         var i:uint = 0;
         while(i < 6)
         {
            tf = ComponentUtil.getTextField("",this,{
               "leading":3,
               "x":gapArr[i] * i,
               "wordWrap":true,
               "multiline":true,
               "realWidth":300,
               "realHeight":600
            });
            list.push(tf);
            i++;
         }
      }
      
      public function dispose() : void
      {
         var tf:MyTextField = null;
         var i:uint = 0;
         while(i < list.length)
         {
            tf = list[i];
            tf.x = gapArr[i] * i;
            tf.htmlText = "";
            i++;
         }
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var maxLen:uint = 0;
         var len:uint = 0;
         var outI:uint = 0;
         var lstf:MyTextField = null;
         var arr:Array = null;
         var inI:uint = 0;
         var data:String = null;
         var tf:MyTextField = null;
         if(obj is String)
         {
            super.Show(obj,type,stoneLvl);
         }
         else if(obj is Array)
         {
            maxLen = (obj as Array).length;
            len = ((obj as Array)[0] as Array).length;
            outI = 0;
            while(outI < maxLen)
            {
               arr = (obj as Array)[outI];
               inI = 0;
               while(inI < len)
               {
                  data = arr[inI] + "\n";
                  tf = list[inI];
                  tf.htmlText += data;
                  inI++;
               }
               outI++;
            }
            lstf = list[len - 1];
            border.x = -8;
            border.y = -4;
            border.width = lstf.x + lstf.textWidth + 16;
            border.height = lstf.y + lstf.textHeight + 12;
         }
      }
   }
}

