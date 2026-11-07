package manager
{
   import com.utils.Util;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class Utils
   {
      
      public function Utils()
      {
         super();
      }
      
      public static function getLoadBitmap(url:String, bitmap:Bitmap = null, propertie:Object = null, complete:Function = null, loadLevel:int = 1) : Bitmap
      {
         var key:String = null;
         if(!bitmap)
         {
            bitmap = new Bitmap();
         }
         if(Boolean(Util.bmdPool[url]))
         {
            bitmap.bitmapData = Util.bmdPool[url] as BitmapData;
            for(key in propertie)
            {
               bitmap[key] = propertie[key];
            }
            if(complete != null)
            {
               complete();
            }
         }
         else
         {
            MassLoader.add(url,function(info:Object):void
            {
               var key:String = null;
               if(Boolean(info.content))
               {
                  info.obj.bm.bitmapData = (info.content as Bitmap).bitmapData;
                  Util.bmdPool[info.url] = (info.content as Bitmap).bitmapData;
               }
               for(key in info.obj.propertie)
               {
                  info.obj.bm[key] = info.obj.propertie[key];
               }
               if(info.obj.complete != null)
               {
                  info.obj.complete();
               }
            },null,loadLevel,{
               "bm":bitmap,
               "propertie":propertie,
               "complete":complete
            });
         }
         return bitmap;
      }
      
      public static function rnd(min:Number, max:Number) : Number
      {
         return Math.floor(Math.random() * (max - min + 1)) + min;
      }
      
      public static function print(... arg) : void
      {
         var str:String = null;
         var i:int = 0;
         if(Boolean(arg.length))
         {
            if(Global.config.arrErr.length >= 100)
            {
               Global.config.arrErr.shift();
            }
            Global.config.arrErr.push(arg);
            trace.apply(null,arg);
         }
         else if(Global.stage.contains(Global.config.txtErr))
         {
            Global.stage.removeChild(Global.config.txtErr);
         }
         else
         {
            Global.stage.addChild(Global.config.txtErr);
         }
         if(Global.stage.contains(Global.config.txtErr))
         {
            str = "";
            i = 0;
            while(i < Global.config.arrErr.length)
            {
               str += Global.config.arrErr[i] + "\n";
               i++;
            }
            Global.config.txtErr.text = str;
            Global.config.txtErr.height = 400;
            Global.config.txtErr.scrollV = Global.config.txtErr.maxScrollV;
         }
      }
   }
}

