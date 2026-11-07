package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_Yellow_Dia_ND;
   import com.yiTian.data.vo.Vo_YellowDia_ND_Play;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.yellowDiamond_NationalDay.View_YellowDiamond_ND_Panel;
   import com.yiTian.view.modules.yellowDiamond_NationalDay.View_YellowDiamond_ND_Tip;
   
   public class YellowDia_ND_Handler
   {
      
      public function YellowDia_ND_Handler()
      {
         super();
      }
      
      public static function GC_YELLOW_DIAMOND_SHOW_BUTTON(show:int) : void
      {
         var showStr:String = null;
         if(show == 0)
         {
            View_YellowDiamond_ND_Tip.instance.remove();
         }
         else if(show == 1)
         {
            if(GameUnitManager.hero.level >= 30)
            {
               View_YellowDiamond_ND_Tip.instance.show();
            }
            else
            {
               Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,lvUpHd);
            }
         }
         else if(show == 2)
         {
            showStr = "不在活动时间内";
            UIManager.centerBroadcast.addMsg(showStr);
         }
         else if(show == 3)
         {
            showStr = "转转次数已满";
            UIManager.centerBroadcast.addMsg(showStr);
         }
      }
      
      private static function lvUpHd() : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            View_YellowDiamond_ND_Tip.instance.show();
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,lvUpHd);
         }
      }
      
      public static function GC_YELLOW_DIAMOND_START(name:String, job:int, paiXuHao:int, goodsID:int, count:int) : void
      {
         var vo:Vo_YellowDia_ND_Play = new Vo_YellowDia_ND_Play();
         vo.name = name;
         vo.job = job;
         vo.goodsID = goodsID;
         vo.goodsCount = count;
         Model_Yellow_Dia_ND.panelObj.paiXuHao = paiXuHao;
         UIManager.yellowDiamondND.updateOpen(vo);
      }
      
      public static function GC_YELLOW_REQUEST_INITDATA(arr:Array, sheY:int, isOver:String, startTime:String, endTime:String) : void
      {
         var vo:Vo_YellowDia_ND_Play = null;
         Model_Yellow_Dia_ND.vecPlayVo = new Vector.<Vo_YellowDia_ND_Play>();
         Model_Yellow_Dia_ND.panelObj.shengYu = sheY;
         Model_Yellow_Dia_ND.panelObj.isOver = isOver;
         View_YellowDiamond_ND_Panel.startTime = startTime;
         View_YellowDiamond_ND_Panel.endTime = endTime;
         var i:int = arr.length - 1;
         while(i >= 0)
         {
            vo = new Vo_YellowDia_ND_Play();
            vo.name = arr[i][0];
            vo.job = arr[i][1];
            vo.goodsID = arr[i][2];
            vo.goodsCount = arr[i][3];
            Model_Yellow_Dia_ND.vecPlayVo.push(vo);
            i--;
         }
         if(!UIManager.yellowDiamondND.visible)
         {
            UIManager.yellowDiamondND.visible = true;
         }
         UIManager.yellowDiamondND.update();
      }
   }
}

