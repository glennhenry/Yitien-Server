package com.yiTian.view.modules.actions.liushiwanjiazhaohui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.LiuShiWanJiaZhaoHuiCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class WanjiaBackPan extends Panel123
   {
      
      private var getBtn:Button;
      
      public var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var tfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var bmp:Bitmap;
      
      private var arr1:Array = [[1,46201,2],[1,46061,2],[1,46409,2],[1,46221,2]];
      
      private var arr2:Array = [[1,46201,5],[1,46061,5],[1,46409,5],[1,46221,5]];
      
      public var _value:int;
      
      public function WanjiaBackPan()
      {
         super();
         regResource("lang/ch/ZH.swf","wanJiaBack_Imgdm");
      }
      
      public static function get instance() : WanjiaBackPan
      {
         return Singleton.getInstance(WanjiaBackPan);
      }
      
      override protected function initUI2() : void
      {
         var g:View_Grid = null;
         var tf:MyTextField = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":574,
            "height":415
         },Global.Img_Cdm);
         move = new Rectangle(0,0,574,40);
         ComponentUtil.getBitmap("Title_KJDL",this,{
            "x":207,
            "y":5
         },Global.wanJiaBack_Imgdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":537,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         initDynamicView();
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":39,
            "width":524,
            "height":366
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("BG_ZH",this,{
            "x":31,
            "y":45
         },Global.wanJiaBack_Imgdm);
         this.bmp = ComponentUtil.getBitmap("",this,{
            "x":216,
            "y":123
         },Global.wanJiaBack_Imgdm);
         this.getBtn = ComponentUtil.getButton("","BT_DJLQ",this,{
            "x":235,
            "y":353,
            "textColor":16771436
         },Global.wanJiaBack_Imgdm);
         this.getBtn.addEventListener(MouseEvent.CLICK,this.onClickHandle);
         var i:int = 0;
         while(i < 4)
         {
            g = new View_Grid(true);
            g.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            g.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
            g.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
            g.x = 85 + i * 112;
            g.y = 259;
            addChild(g);
            tf = ComponentUtil.getTextField("",this,{
               "x":g.x + 52,
               "y":g.y + 48
            });
            this.tfVec.push(tf);
            this.gridVec.push(g);
            i++;
         }
      }
      
      public function update(value:int) : void
      {
         var _a:Array = null;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var g:View_Grid = null;
         var tf:MyTextField = null;
         var voI:Vo_item = null;
         if(!visible)
         {
            visible = true;
         }
         var arr:Array = [];
         if(value == 0)
         {
            return;
         }
         if(value == 1)
         {
            this.bmp.bitmapData = ComponentUtil.getBitmapData("Text_288",Global.wanJiaBack_Imgdm);
            arr = this.arr1;
         }
         else if(value == 2)
         {
            arr = this.arr2;
            this.bmp.bitmapData = ComponentUtil.getBitmapData("Text_488",Global.wanJiaBack_Imgdm);
         }
         var i:int = 0;
         while(i < 4)
         {
            _a = arr[i];
            _type = int(_a[0]);
            _id = int(_a[1]);
            _count = int(_a[2]);
            g = this.gridVec[i];
            tf = this.tfVec[i];
            voI = new Vo_item();
            voI.id = _id;
            tf.text = _count.toString();
            voI.Init_lib();
            g.vo = voI;
            i++;
         }
      }
      
      private function onClickHandle(e:MouseEvent) : void
      {
         var leftBagNum:int = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
         if(leftBagNum >= 5)
         {
            LiuShiWanJiaZhaoHuiCGMessage.CG_LIUSHIWANJIA_AWARD_BACK();
         }
         else
         {
            UIManager.centerBroadcast.addMsg("背包空间不足");
         }
      }
   }
}

