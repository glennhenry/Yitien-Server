package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.actions.liushiwanjiazhaohui.WanjiaBackPan;
   import com.yiTian.view.modules.actions.liushiwanjiazhaohui.ZhaoHuiBtn;
   import flash.utils.IDataInput;
   
   public class LiuShiWanJiaZhaoHuiGCMessage
   {
      
      private var arr:Array = ["领取成功","已领取","非沉默用户和濒临沉默用户不可领取","正在验证身份..请稍等…","请求腾讯状态失败","空间活动","不在活动时间内"];
      
      private var voId:Array = [46201,46061,46409,46221];
      
      public function LiuShiWanJiaZhaoHuiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_LIUSHIWANJIA_BACK] = this.GC_LIUSHIWANJIA_BACK;
         index[MessageType.GC_LIUSHIWANJIA_AWARD_BACK] = this.GC_LIUSHIWANJIA_AWARD_BACK;
      }
      
      private function GC_LIUSHIWANJIA_BACK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var a:int = patch.readInt();
         WanjiaBackPan.instance._value = a;
         if(result == 1)
         {
            ZhaoHuiBtn.show();
         }
         else if(result == 0)
         {
            ZhaoHuiBtn.hide();
         }
      }
      
      private function GC_LIUSHIWANJIA_AWARD_BACK(patch:IDataInput) : void
      {
         var i:int = 0;
         var g:View_Grid = null;
         var vo:Vo_item = null;
         var result:int = patch.readByte();
         UIManager.centerBroadcast.addMsg(this.arr[result - 1]);
         if(result == 1)
         {
            i = 0;
            while(i < 4)
            {
               g = new View_Grid();
               g.x = 85 + i * 112;
               vo = new Vo_item();
               vo.id = this.voId[i];
               vo.Init_lib();
               g.vo = vo;
               ComboTweenStep.toBag(g.vo,g.x + 450,Global.stage.stageHeight / 2);
               i++;
            }
            if(WanjiaBackPan.instance.visible)
            {
               WanjiaBackPan.instance.visible = false;
            }
            ZhaoHuiBtn.hide();
         }
      }
   }
}

