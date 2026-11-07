package com.yiTian.view.modules.tuanGou.tuanGouLBYH
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_CangBaoTu;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CangBaoTuCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class CangBaoTuPan extends Panel123
   {
      
      private var getBtn:Button;
      
      public var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var tfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var nowGrid:View_Grid;
      
      private var vo:Vo_valuable;
      
      private var nowBmp:Bitmap;
      
      private var _voId:int;
      
      private var _gridId:int;
      
      public function CangBaoTuPan()
      {
         super();
         regResource("lang/ch/CBT.swf","cangBaoTu_Imgdm");
      }
      
      public static function get instance() : CangBaoTuPan
      {
         return Singleton.getInstance(CangBaoTuPan);
      }
      
      override protected function initUI2() : void
      {
         var weiZhiArr:Array = null;
         var i:int = 0;
         var vg:View_Grid = null;
         var g:View_Grid = null;
         ComponentUtil.getBitmap("Back_CBT",this,{
            "x":0,
            "y":0
         },Global.cangBaoTu_Imgdm);
         ComponentUtil.getBitmap("Frame_PTK",this,{
            "x":137,
            "y":140
         },Global.cangBaoTu_Imgdm);
         ComponentUtil.getBitmap("Frame_PTK",this,{
            "x":230,
            "y":140
         },Global.cangBaoTu_Imgdm);
         ComponentUtil.getBitmap("Frame_PTK",this,{
            "x":323,
            "y":140
         },Global.cangBaoTu_Imgdm);
         ComponentUtil.getBitmap("Frame_PTK",this,{
            "x":415,
            "y":140
         },Global.cangBaoTu_Imgdm);
         ComponentUtil.getBitmap("Frame_PTK",this,{
            "x":125,
            "y":204
         },Global.cangBaoTu_Imgdm);
         ComponentUtil.getBitmap("Frame_PTK",this,{
            "x":431,
            "y":204
         },Global.cangBaoTu_Imgdm);
         ComponentUtil.getBitmap("Frame_PTK",this,{
            "x":110,
            "y":269
         },Global.cangBaoTu_Imgdm);
         ComponentUtil.getBitmap("Frame_PTK",this,{
            "x":224,
            "y":269
         },Global.cangBaoTu_Imgdm);
         ComponentUtil.getBitmap("Frame_PTK",this,{
            "x":338,
            "y":269
         },Global.cangBaoTu_Imgdm);
         ComponentUtil.getBitmap("Frame_PTK",this,{
            "x":451,
            "y":269
         },Global.cangBaoTu_Imgdm);
         ComponentUtil.getButton("","Button_DJLQ",this,{
            "x":227,
            "y":206,
            "textColor":16771436
         },Global.cangBaoTu_Imgdm);
         CloseButton = ComponentUtil.getButton("","Button_GuanBi",this,{
            "x":520,
            "y":81,
            "textColor":16771436
         },Global.cangBaoTu_Imgdm);
         CloseButton.callBack = this.hide;
         initDynamicView();
         ComponentUtil.getBitmap("Text_Zhu",this,{
            "x":180,
            "y":342
         },Global.cangBaoTu_Imgdm);
         this.nowBmp = ComponentUtil.getBitmap("",this,{},Global.cangBaoTu_Imgdm);
         this.getBtn = ComponentUtil.getButton("","Button_DJLQ",this,{
            "x":225,
            "y":205,
            "textColor":16771436
         },Global.cangBaoTu_Imgdm);
         this.getBtn.callBack = this.getHandle;
         weiZhiArr = [[137,140],[230,140],[323,140],[415,140],[431,204],[451,269],[338,269],[224,269],[110,269],[125,204]];
         i = 0;
         while(i < 10)
         {
            g = new View_Grid();
            g.set_bmp_bg(View_Grid.GRID_OPEN);
            g.set_bmp_over(true,View_Grid.GRID_OVER);
            g.set_tf_count(true,false,false);
            g.set_bmp_select(View_Grid.GRID_SELECT);
            g.x = weiZhiArr[i][0] + 21;
            g.y = weiZhiArr[i][1] + 15;
            addChild(g);
            this.gridVec.push(g);
            i++;
         }
         for each(vg in this.gridVec)
         {
            vg.addEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var grid:View_Grid = e.target as View_Grid;
         if(!grid.vo)
         {
            return;
         }
         if(this.nowGrid == grid)
         {
            return;
         }
         if(Boolean(this.nowGrid))
         {
            this.nowGrid.bSelect = false;
         }
         this.nowGrid = grid;
         this.nowGrid.bSelect = true;
         if(Boolean(this.nowBmp))
         {
            this.nowBmp.bitmapData = ComponentUtil.getBitmapData("Frame_PTK",Global.cangBaoTu_Imgdm);
         }
         this.nowBmp.x = this.nowGrid.x - 21;
         this.nowBmp.y = this.nowGrid.y - 15;
         this.nowBmp.bitmapData = ComponentUtil.getBitmapData("Frame_XZK",Global.cangBaoTu_Imgdm);
      }
      
      private function getHandle(e:MouseEvent) : void
      {
         var str:String;
         var color:String;
         var leftBagNum:int = 0;
         this.vo = this.nowGrid.vo as Vo_valuable;
         str = this.vo.str_name;
         color = Model_shop.get_color_arr[this.vo.color - 1];
         leftBagNum = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
         View_Alert.show(LangConfig.getWord("50046",5) + HtmlUtil.font(str,color),View_Alert.OK_CANCAL,function():void
         {
            var p:Point = null;
            if(leftBagNum >= 1)
            {
               CangBaoTuCGMessage.CG_CANGBAOTU_AWARD(_gridId,vo.id);
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("1073",0));
               p = localToGlobal(new Point(nowGrid.x,nowGrid.y));
               ComboTweenStep.toBag(vo,p.x,p.y);
               nowGrid.bSelect = false;
               nowGrid = null;
               nowBmp.bitmapData = null;
               visible = false;
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("106",0));
            }
         });
      }
      
      public function show(voId:int, gridId:int) : void
      {
         var __arr:Array = null;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var g:View_Grid = null;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         if(!visible)
         {
            visible = true;
         }
         this._voId = voId;
         this._gridId = gridId;
         var a:int = Math.random() * 9.5;
         if(Boolean(this.nowGrid))
         {
            this.nowGrid.bSelect = false;
         }
         this.nowGrid = this.gridVec[a];
         this.vo = this.nowGrid.vo as Vo_valuable;
         this.nowGrid.bSelect = true;
         this.nowBmp.x = this.nowGrid.x - 21;
         this.nowBmp.y = this.nowGrid.y - 15;
         this.nowBmp.bitmapData = ComponentUtil.getBitmapData("Frame_XZK",Global.cangBaoTu_Imgdm);
         var str:String = Data_lib.cangBaoTu[this._voId][1];
         var _arr:Array = str.split(",");
         var i:int = 0;
         while(i < _arr.length)
         {
            __arr = (_arr[i] as String).split("_");
            _type = int(__arr[Enum_CangBaoTu.TYPE]);
            _id = int(__arr[Enum_CangBaoTu.ID]);
            _count = int(__arr[Enum_CangBaoTu.COUNT]);
            g = this.gridVec[i];
            if(_type == 1)
            {
               voI = new Vo_item();
               voI.id = _id;
               voI.count = _count;
               voI.bBind = true;
               voI.Init_lib();
               g.vo = voI;
            }
            else if(_type == 2)
            {
               voE = new Vo_equip();
               voE.id = _id;
               voE.count = _count;
               voE.bBind = true;
               voE.Init_lib();
               g.vo = voE;
            }
            i++;
         }
      }
      
      private function hide(e:MouseEvent) : void
      {
         if(visible == true)
         {
            visible = false;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

