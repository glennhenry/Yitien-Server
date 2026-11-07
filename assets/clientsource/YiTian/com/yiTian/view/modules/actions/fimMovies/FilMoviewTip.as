package com.yiTian.view.modules.actions.fimMovies
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class FilMoviewTip
   {
      
      private static var tipBtn:MainUIBtn;
      
      public function FilMoviewTip()
      {
         super();
      }
      
      public static function showTip() : void
      {
         if(Global.filMoviesCTRL)
         {
            if(!tipBtn)
            {
               tipBtn = new MainUIBtn("resource/image/filmMovies/filmM.png",{
                  "x":-12,
                  "y":-12
               });
               UIManager.mainUiBtnContainer.addBTN(tipBtn);
               tipBtn.addEventListener(MouseEvent.CLICK,function():void
               {
                  UIManager.mainUiBtnContainer.removeBTN(tipBtn);
                  tipBtn = null;
                  navigateToURL(new URLRequest("http://yi.qq.com/act/a20130410movie/"),"_blank");
               });
            }
         }
      }
   }
}

