package com.yiTian.net.handler
{
   import com.yiTian.data.vo.Vo_BlueDiamondND_Play;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BlueDiamondCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.blueDiamondND.ViewBlueDiamondNDPanel;
   import com.yiTian.view.modules.blueDiamondND.ViewBuleDiamondTip;
   import com.yiTian.view.modules.blueDiamondND.tiXingXuFei.BlueDiaXFPan;
   import com.yiTian.view.modules.blueDiamondND.xiaofeiCJ.Model_xiaoFeiCJ;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   
   public class BlueDiamondHandler
   {
      
      public function BlueDiamondHandler()
      {
         super();
      }
      
      public static function GC_BLUE_DIAMOND_SHOW_BUTTON(show:int) : void
      {
         var showStr:String = null;
         var tipViewer:ViewBuleDiamondTip = ViewBuleDiamondTip.instance;
         if(show == 0)
         {
            UIManager.mainUiBtnContainer.removeBTN(tipViewer);
         }
         else
         {
            if(show == 1)
            {
               return;
            }
            if(show == 2)
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
      }
      
      public static function GC_BLUE_DIAMOND_START(name:String, job:int, paiXuHao:int, goodsID:int, count:int, curYuanBao:int, MaxYuanBao:int, pan:ViewBlueDiamondNDPanel) : void
      {
         var vo:Vo_BlueDiamondND_Play = new Vo_BlueDiamondND_Play();
         vo.name = name;
         vo.job = job;
         vo.goodsID = goodsID;
         vo.goodsCount = count;
         pan.paiXuHao = paiXuHao;
         pan.updateOpen(vo);
      }
      
      public static function GC_BLUE_REQUEST_INITDATA(arr:Array, sheY:int, curYuanBao:int, maxYuanBao:int, isOver:String, startTime:String, endTime:String, pan:ViewBlueDiamondNDPanel) : void
      {
         var vo:Vo_BlueDiamondND_Play = null;
         pan.vecPlayVo = new Vector.<Vo_BlueDiamondND_Play>();
         pan.shengYu = sheY;
         pan.max = maxYuanBao;
         pan.min = curYuanBao;
         pan.startTime = startTime;
         pan.endTime = endTime;
         pan.isOver = isOver;
         var i:int = 0;
         while(i < arr.length)
         {
            vo = new Vo_BlueDiamondND_Play();
            vo.name = arr[i][0];
            vo.job = arr[i][1];
            vo.goodsID = arr[i][2];
            vo.goodsCount = arr[i][3];
            pan.vecPlayVo.push(vo);
            i++;
         }
         pan.visible = !pan.visible;
         if(pan.visible)
         {
            pan.update();
            pan.show();
         }
      }
      
      public static function GC_QQGAMEXF_SHOWPAN(type:int, result:int) : void
      {
         var pan:ViewBlueDiamondNDPanel = null;
         var pan2:View_hzTribute = null;
         if(type == 1)
         {
            BlueDiamondCGMessage.CG_QQGAMECJ_OPENPAN();
            pan = Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.LZSTR);
            pan.titleUrl = Model_xiaoFeiCJ.LZSTR;
         }
         else if(type == 2)
         {
            pan2 = Singleton.getInstance(View_hzTribute) as View_hzTribute;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan2,function():void
            {
               pan2.show();
            });
         }
         else if(type == 3)
         {
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(BlueDiaXFPan.instance,function():void
            {
               BlueDiaXFPan.instance.show(result);
            });
         }
      }
   }
}

