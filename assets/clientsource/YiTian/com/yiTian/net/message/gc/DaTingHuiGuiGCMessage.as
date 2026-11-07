package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.actions.datingBack.Tipbtn;
   import flash.utils.IDataInput;
   
   public class DaTingHuiGuiGCMessage
   {
      
      public var isShowIcon:Boolean = true;
      
      private var arr:Array = ["背包已满","领取成功","已领取",".....","不满足条件"];
      
      private var _result:int;
      
      public function DaTingHuiGuiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_QQ_GAME_BACK] = this.GC_QQ_GAME_BACK;
         index[MessageType.GC_QQGAME_AWARD_BACK] = this.GC_QQGAME_AWARD_BACK;
      }
      
      private function GC_QQ_GAME_BACK(patch:IDataInput) : void
      {
         var type:int = 0;
         var result:int = patch.readByte();
         var day:int = patch.readInt();
         if(day >= 7 && day < 14)
         {
            type = 1;
         }
         else if(day >= 14 && day < 30)
         {
            type = 2;
         }
         else if(day >= 30 && day < 90)
         {
            type = 3;
         }
         else if(day >= 90)
         {
            type = 4;
         }
         this._result = type;
         if(result == 1 && GameUnitManager.hero.level >= 30)
         {
            Tipbtn.show(type,day);
         }
         else if(result == 0 || GameUnitManager.hero.level < 30)
         {
            Tipbtn.hide();
         }
      }
      
      private function GC_QQGAME_AWARD_BACK(patch:IDataInput) : void
      {
         var i:int = 0;
         var __arr:Array = null;
         var _id:int = 0;
         var g:View_Grid = null;
         var vo:Vo_item = null;
         var result:int = patch.readByte();
         UIManager.centerBroadcast.addMsg(this.arr[result]);
         var str:String = Data_lib.QQGameBack[this._result][1];
         var _arr:Array = str.split(",");
         if(result == 1)
         {
            i = 0;
            while(i < 4)
            {
               __arr = (_arr[i] as String).split("_");
               _id = int(__arr[1]);
               g = new View_Grid();
               g.x = 72 + i * 75;
               vo = new Vo_item();
               vo.id = _id;
               vo.Init_lib();
               g.vo = vo;
               ComboTweenStep.toBag(g.vo,g.x + 450,Global.stage.stageHeight / 2);
               i++;
            }
            Tipbtn.hide();
         }
      }
   }
}

