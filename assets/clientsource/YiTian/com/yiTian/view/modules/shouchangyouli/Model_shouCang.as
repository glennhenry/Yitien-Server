package com.yiTian.view.modules.shouchangyouli
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.FileReference;
   
   public class Model_shouCang
   {
      
      public function Model_shouCang()
      {
         super();
      }
      
      public static function addDesktopUrl(strTitle:String, strUrl:String, onFinish:Function = null, onError:Function = null, onCancle:Function = null) : void
      {
         var kSaveFile:FileReference = null;
         var strFileContent:String = null;
         try
         {
            kSaveFile = new FileReference();
            strFileContent = "[InternetShortcut]" + "\n";
            strFileContent += "URL=" + strUrl + "\n";
            strFileContent += "IconFile=" + "\n";
            strFileContent += "IconIndex=0" + "\n";
            if(onFinish != null)
            {
               kSaveFile.addEventListener(Event.COMPLETE,onFinish);
            }
            if(onError != null)
            {
               kSaveFile.addEventListener(IOErrorEvent.IO_ERROR,onError);
            }
            if(onCancle != null)
            {
               kSaveFile.addEventListener(Event.CANCEL,onCancle);
            }
            kSaveFile.save(strFileContent,strTitle + ".url");
         }
         catch(e:Error)
         {
         }
      }
   }
}

