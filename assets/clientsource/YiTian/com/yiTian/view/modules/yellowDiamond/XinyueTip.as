package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class XinyueTip
   {
      
      private static var ins:XinyueTip;
      
      private var tipB:MainUIBtn;
      
      public function XinyueTip()
      {
         super();
      }
      
      public static function get instance() : XinyueTip
      {
         if(!ins)
         {
            ins = new XinyueTip();
         }
         return ins;
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         View_Alert.show("是否前往心悦使者领取礼包",View_Alert.OK_CANCAL,function():void
         {
            GameUnitManager.hero.autoMove(52910);
         });
      }
      
      public function show() : void
      {
         if(!this.tipB)
         {
            this.tipB = new MainUIBtn("resource/image/Diamond/xinYueTQ.png",{
               "x":2,
               "y":3
            });
            UIManager.mainUiBtnContainer.addBTN(this.tipB);
            this.tipB.addEventListener(MouseEvent.CLICK,this.cliHd);
         }
      }
      
      public function remove() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.tipB))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.tipB);
         }
      }
   }
}

