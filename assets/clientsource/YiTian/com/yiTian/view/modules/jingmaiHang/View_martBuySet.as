package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class View_martBuySet extends Panel
   {
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      private var Number_Price_text:MyTextField;
      
      private var Number_Buy_text:MyTextField;
      
      public var _maxNum:int;
      
      public var _martId:int;
      
      public function View_martBuySet()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
      }
      
      public function changedHandle(e:Event) : void
      {
         var TF:MyTextField = e.target as MyTextField;
         if(int(TF.text) > this._maxNum)
         {
            TF.text = String(this._maxNum);
         }
      }
      
      public function sureBuyHandle(e:MouseEvent) : void
      {
         var btn:Button = e.target as Button;
         if(btn.label == LangConfig.getWord("6",0))
         {
            if(int(this.Number_Price_text.text) > GameUnitManager.hero.money)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ff0000\'>" + LangConfig.getWord("390",0) + "</font></a>");
               return;
            }
         }
         else
         {
            visible = false;
         }
         visible = false;
      }
      
      public function setPrice(_price:int) : void
      {
         this.Number_Price_text.text = String(_price);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

