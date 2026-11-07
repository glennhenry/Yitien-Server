package com.yiTian.view.modules.paoku.userCom.state
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.modules.paoku.core.state.IState;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.view.View_kuPaoPnl;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class KuPaoHelpState implements IState
   {
      
      public var _view:Sprite;
      
      public var _tfIntroduce:MyTextField;
      
      public function KuPaoHelpState()
      {
         super();
         this._view = new Sprite();
         this._tfIntroduce = ComponentUtil.getTextField("",this._view,{
            "x":0,
            "y":0
         });
         this._tfIntroduce.htmlText = "这个是跑酷帮助";
         ComponentUtil.getButton("返回","Button_Four",this._view,{
            "x":300,
            "callBack":this.returnClickHd
         },Global.Img_Cdm);
      }
      
      public function enter(param:*) : void
      {
         View_kuPaoPnl.instance.addToContainer(this._view);
      }
      
      public function exit(param:*) : void
      {
         View_kuPaoPnl.instance.removeFromContainer(this._view);
      }
      
      public function update(param:*) : void
      {
      }
      
      public function askExit(nextState:int) : Boolean
      {
         return true;
      }
      
      private function returnClickHd(e:MouseEvent) : void
      {
         KuPaoMgr.instance.paokuGlobalSM.changeState(KuPaoMgr.GST_STARTMENU);
      }
   }
}

