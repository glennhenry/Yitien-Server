package com.yiTian.view.modules.boatChall
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.net.message.cg.BoatCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.boatChall.VTip.V_returnBtn;
   
   public class EndTipPan extends Panel123
   {
      
      private var idArr:Array = [44684,45525,46382];
      
      public function EndTipPan()
      {
         super();
         regResource("lang/ch/FWLZ.swf","FWLZdm");
      }
      
      public static function get instance() : EndTipPan
      {
         return Singleton.getInstance(EndTipPan);
      }
      
      override protected function initUI2() : void
      {
         var i:int;
         var g:View_Grid = null;
         var vo:Vo_item = null;
         ComponentUtil.getBitmap("Back_LZWCBS",this,{
            "x":0,
            "y":0
         },Global.FWLZdm);
         ComponentUtil.getButton("","Button_LJFH",this,{
            "x":141,
            "y":280,
            "textColor":16771436,
            "callBack":function():void
            {
               hide();
               CameraManager.cameraFromTo(BoatManager.END_X,BoatManager.END_Y,BoatManager.WATCH_X,BoatManager.WATCH_Y,500,function():void
               {
                  var _temp_1:* = BoatManager;
                  BoatManager.END_Y = 0;
                  _temp_1.END_X = 0;
                  Global.isPlayingMarriageEffect = false;
                  Child_DaoJiShi.instance.visible = true;
                  BoatManager.isMyShipEnding = false;
                  BoatGrids.instance.hide();
               });
               V_returnBtn.instance.hide(Global.stage);
            }
         },Global.FWLZdm);
         CloseButton = ComponentUtil.getButton("","Button_LZGBAN",this,{
            "x":396,
            "y":50,
            "textColor":16771436
         },Global.FWLZdm);
         ComponentUtil.getButton("","Button_TuiChuFB",this,{
            "x":251,
            "y":280,
            "textColor":16771436,
            "callBack":function():void
            {
               BoatCGMessage.CG_QUIT_CHALL();
               visible = false;
            }
         },Global.FWLZdm);
         super.initDynamicView();
         i = 0;
         while(i < 3)
         {
            g = new View_Grid();
            g.set_bmp_bg();
            g.set_bmp_over(true,null);
            addChild(g);
            ComponentUtil.setPropertie(g,{
               "x":176 + i * 55,
               "y":167
            });
            vo = new Vo_item();
            vo.id = this.idArr[i];
            vo.Init_lib();
            g.vo = vo;
            i++;
         }
      }
      
      public function show() : void
      {
         visible = visible || true;
      }
      
      public function hide() : void
      {
         visible = visible && false;
      }
   }
}

