package com.yiTian.view.modules.actions.xsHaoli
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.New_mainBtnContainer;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class LinkManager
   {
      
      public static var RIGHT_UP:String = "right_up";
      
      public static var DOWN:String = "down";
      
      private static var btnPosition:String = "";
      
      public function LinkManager()
      {
         super();
      }
      
      public static function get RIGHT() : String
      {
         if(New_mainBtnContainer.isUsingNewBtn)
         {
            return "right";
         }
         return RIGHT_UP;
      }
      
      public static function jump(obj:Object, disObj:DisplayObject, isHide:Boolean = false, isRightUpBtn:String = "right_up") : void
      {
         if(isRightUpBtn == RIGHT_UP)
         {
            if(!UIManager.mainUiBtnContainer.hasBTN(disObj))
            {
               UIManager.mainUiBtnContainer.addBTN(disObj);
            }
         }
         else if(isRightUpBtn == RIGHT)
         {
            if(!UIManager.newMainBtnContainer.hasBtn(disObj))
            {
               UIManager.newMainBtnContainer.addBtn(disObj);
            }
         }
         else if(isRightUpBtn == DOWN)
         {
            trace("还没处理");
         }
         if(Boolean(disObj) && !disObj.hasEventListener(MouseEvent.CLICK))
         {
            disObj.addEventListener(MouseEvent.CLICK,function():void
            {
               var fun:Function = null;
               var url:String = null;
               if(obj is Function)
               {
                  fun = obj as Function;
                  fun();
               }
               else if(obj is String)
               {
                  url = obj as String;
                  navigateToURL(new URLRequest(url),"_blank");
               }
               if(isHide)
               {
                  if(Boolean(disObj) && UIManager.mainUiBtnContainer.hasBTN(disObj))
                  {
                     UIManager.mainUiBtnContainer.removeBTN(disObj);
                     disObj = null;
                  }
                  else if(Boolean(disObj) && UIManager.newMainBtnContainer.hasBtn(disObj))
                  {
                     UIManager.newMainBtnContainer.removeBtn(disObj);
                     disObj = null;
                  }
               }
            });
         }
      }
   }
}

