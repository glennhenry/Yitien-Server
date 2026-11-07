package com.yiTian.scene
{
   import com.yiTian.Global;
   import com.yiTian.Version;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.model.Model_initStr;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.ContextMenuEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.System;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   
   public class IScene extends Sprite
   {
      
      protected static var myContextMenu:ContextMenu;
      
      public function IScene()
      {
         super();
      }
      
      protected function initContextMenu() : void
      {
         var menuItem1:ContextMenuItem = null;
         if(Global.pf == Enum_SPStr.QQJIA)
         {
            return;
         }
         myContextMenu = new ContextMenu();
         myContextMenu.hideBuiltInItems();
         if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QQ3366 || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isIwan(Global.pf))
         {
            menuItem1 = new ContextMenuItem(Model_initStr.STORE_YITIAN);
            myContextMenu.customItems.push(menuItem1);
            menuItem1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onSelect1);
         }
         var menuItem2:ContextMenuItem = new ContextMenuItem(Model_initStr.DEVELOPERS);
         var menuItem3:ContextMenuItem = new ContextMenuItem(Version.VERSION);
         myContextMenu.customItems.push(menuItem2);
         myContextMenu.customItems.push(menuItem3);
         menuItem3.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onSelect3);
      }
      
      private function onSelect1(e:ContextMenuEvent) : void
      {
         ExternalInterface.call("bookmark");
      }
      
      private function onSelect2(e:ContextMenuEvent) : void
      {
         try
         {
            navigateToURL(new URLRequest(Global.config.officialWebsite),"_blank");
         }
         catch(e:Error)
         {
         }
      }
      
      private function onSelect3(e:ContextMenuEvent) : void
      {
         try
         {
            System.setClipboard(Version.VERSION);
         }
         catch(err:Error)
         {
         }
      }
      
      public function show() : void
      {
         if(Global.pf == Enum_SPStr.QQJIA)
         {
            return;
         }
         if(!myContextMenu)
         {
            this.initContextMenu();
         }
         contextMenu = myContextMenu;
      }
      
      public function resize() : void
      {
      }
      
      public function dispose() : void
      {
         var child:DisplayObject = null;
         while(Boolean(numChildren))
         {
            child = getChildAt(0);
            if(child is Bitmap)
            {
               (child as Bitmap).bitmapData.dispose();
            }
            removeChild(child);
         }
      }
   }
}

