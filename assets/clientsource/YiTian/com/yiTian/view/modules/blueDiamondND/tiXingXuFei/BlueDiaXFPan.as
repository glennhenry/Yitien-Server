package com.yiTian.view.modules.blueDiamondND.tiXingXuFei
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_LZXF;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class BlueDiaXFPan extends Panel123
   {
      
      public var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var tfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var bmp:Bitmap;
      
      private var getBtn:Button;
      
      private var myTF:MyTextField;
      
      private var vo:Vo_valuable;
      
      public function BlueDiaXFPan()
      {
         super();
         regResource("lang/ch/LZHD.swf","LZHDdm");
      }
      
      public static function get instance() : BlueDiaXFPan
      {
         return Singleton.getInstance(BlueDiaXFPan);
      }
      
      override protected function initUI2() : void
      {
         var g:View_Grid = null;
         var tf:MyTextField = null;
         ComponentUtil.getBitmap("Back_LZJC",this,{
            "x":0,
            "y":0
         },Global.LZHDdm);
         ComponentUtil.getBitmap("LZ_LanZuan",this,{
            "x":64,
            "y":209
         },Global.LZHDdm);
         ComponentUtil.getBitmap("Text_CZZS",this,{
            "x":175,
            "y":210
         },Global.LZHDdm);
         ComponentUtil.getBitmap("Text_KTXF",this,{
            "x":64,
            "y":78
         },Global.LZHDdm);
         ComponentUtil.getBitmap("Text_ZYTG",this,{
            "x":102,
            "y":258
         },Global.LZHDdm);
         CloseButton = ComponentUtil.getButton("","Button_GuanBi",this,{
            "x":404,
            "y":5,
            "textColor":16771436
         },Global.LZHDdm);
         move = new Rectangle(0,0,400,60);
         this.getBtn = ComponentUtil.getButton("","Button_XFLQ",this,{
            "x":115,
            "y":324,
            "textColor":16771436
         },Global.LZHDdm);
         this.getBtn.callBack = this.getHandle;
         initDynamicView();
         ComponentUtil.getTextField("蓝钻特权尊享：",this,{
            "x":84,
            "y":206,
            "color":2775447,
            "size":12,
            "leading":0
         });
         this.myTF = ComponentUtil.getTextField("",this,{
            "x":101,
            "y":293,
            "color":14497297,
            "size":12,
            "leading":0
         });
         var i:int = 0;
         while(i < 4)
         {
            g = new View_Grid();
            g.set_bmp_bg(View_Grid.GRID_OPEN);
            g.set_bmp_over(true,View_Grid.GRID_OVER);
            g.set_bmp_select(View_Grid.GRID_SELECT);
            g.x = 82 + i * 81;
            g.y = 123;
            addChild(g);
            tf = ComponentUtil.getTextField("",this,{
               "x":g.x - 15,
               "y":g.y + 39
            });
            this.tfVec.push(tf);
            this.gridVec.push(g);
            i++;
         }
      }
      
      public function show(result:int) : void
      {
         var __arr:Array = null;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var g:View_Grid = null;
         var tf:MyTextField = null;
         var str1:String = null;
         var color:String = null;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var _result:int = result;
         if(!visible)
         {
            visible = true;
         }
         this.myTF.text = "  该活动每月只能参与一次（本月获得 " + _result.toString() + "/1）";
         var str:String = Data_lib.LZXF[44997][1];
         var _arr:Array = str.split(",");
         var i:int = 0;
         while(i < _arr.length)
         {
            __arr = (_arr[i] as String).split("_");
            _type = int(__arr[Enum_LZXF.TYPE]);
            _id = int(__arr[Enum_LZXF.ID]);
            _count = int(__arr[Enum_LZXF.COUNT]);
            g = this.gridVec[i];
            tf = this.tfVec[i];
            if(_type == 1)
            {
               voI = new Vo_item();
               voI.id = _id;
               voI.count = _count;
               voI.Init_lib();
               g.vo = voI;
            }
            else if(_type == 2)
            {
               voE = new Vo_equip();
               voE.id = _id;
               voE.count = _count;
               voE.Init_lib();
               g.vo = voE;
            }
            this.vo = g.vo as Vo_valuable;
            str1 = this.vo.str_name;
            color = Model_shop.get_color_arr[this.vo.color - 1];
            tf.htmlText = HtmlUtil.font(str1,color) + "*" + _count.toString();
            i++;
         }
      }
      
      private function getHandle(e:MouseEvent) : void
      {
         View_hzTribute.sendType = "self";
         YellowDiaManager.remindBuy();
      }
   }
}

