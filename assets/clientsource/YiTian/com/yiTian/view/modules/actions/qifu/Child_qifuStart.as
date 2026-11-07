package com.yiTian.view.modules.actions.qifu
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QifuCGMessage;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_qifuStart extends Sprite
   {
      
      private var costM:Array = [20,190,900];
      
      public function Child_qifuStart()
      {
         var btn:Button = null;
         var tf:MyTextField = null;
         super();
         var i:int = 0;
         while(i < 3)
         {
            btn = ComponentUtil.getButton(Model_qifu.btnQiFuArr(i),"Button_Four",this,{
               "x":126 * i,
               "y":0,
               "tabIndex":i + 1
            },Global.Img_Cdm);
            tf = ComponentUtil.getTextField(Model_qifu.tfQiFuArr(i),this,{
               "x":2 + i * 123,
               "y":24,
               "color":327424
            });
            btn.addEventListener(MouseEvent.CLICK,this.cliHd);
            i++;
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var index:int = (e.target as Button).tabIndex;
         if(Child_grid.isRunning)
         {
            UIManager.centerBroadcast.addMsg("请稍等，正在获取祈祷物品");
            return;
         }
         var cost:int = int(this.costM[index - 1]);
         if(GameUnitManager.hero.money < cost)
         {
            UIManager.centerBroadcast.addMsg("元宝不足");
            return;
         }
         QifuCGMessage.CG_QIFU_TYPE(index);
      }
   }
}

