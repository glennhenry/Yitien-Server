package com.yiTian.view.modules.yellowDiamond.tiXingXuFei
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_HZXF;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.UIManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class YellowDiaXFPan extends Panel123
   {
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var tfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var bmp:Bitmap;
      
      private var getBtn:Button;
      
      private var myTF:MyTextField;
      
      private var nameTF:MyTextField;
      
      private var vo:Vo_valuable;
      
      private var roleName:String;
      
      private var isOver:int;
      
      public function YellowDiaXFPan()
      {
         super();
         regResource("lang/ch/HZTX.swf","HZTXdm");
      }
      
      public static function get instance() : YellowDiaXFPan
      {
         return Singleton.getInstance(YellowDiaXFPan);
      }
      
      override protected function initUI2() : void
      {
         var g:View_Grid = null;
         var tf:MyTextField = null;
         ComponentUtil.getBitmap("Back_HZTX",this,{
            "x":0,
            "y":0
         },Global.HZTXdm);
         ComponentUtil.getBitmap("Line_HZTX",this,{
            "x":98,
            "y":105
         },Global.HZTXdm);
         ComponentUtil.getBitmap("Text_QAD",this,{
            "x":33,
            "y":81
         },Global.HZTXdm);
         ComponentUtil.getBitmap("Text_ZYTG",this,{
            "x":107,
            "y":313
         },Global.HZTXdm);
         ComponentUtil.getBitmap("Title_HZTX",this,{
            "x":142,
            "y":17
         },Global.HZTXdm);
         CloseButton = ComponentUtil.getButton("","Button_GuanBi",this,{
            "x":432,
            "y":12,
            "textColor":16771436
         },Global.HZTXdm);
         this.getBtn = ComponentUtil.getButton("","Button_XFLQ",this,{
            "x":154,
            "y":345,
            "textColor":16771436
         },Global.HZTXdm);
         this.getBtn.callBack = this.getHandle;
         move = new Rectangle(0,0,400,60);
         initDynamicView();
         this.nameTF = ComponentUtil.getTextField("玩家名字六字",this,{
            "x":107,
            "y":87,
            "color":16777011,
            "size":12,
            "leading":0
         });
         this.myTF = ComponentUtil.getTextField("",this,{
            "x":77,
            "y":123,
            "color":16771436,
            "size":15,
            "leading":10
         });
         ComponentUtil.getTextField("428YB    续费大礼包！",this,{
            "x":86,
            "y":151,
            "color":16711680,
            "size":15,
            "leading":0
         });
         var i:int = 0;
         while(i < 3)
         {
            g = new View_Grid();
            g.set_bmp_bg(View_Grid.GRID_OPEN);
            g.set_bmp_over(true,View_Grid.GRID_OVER);
            g.set_bmp_select(View_Grid.GRID_SELECT);
            g.x = 115 + 104 * i;
            g.y = 222;
            addChild(g);
            tf = ComponentUtil.getTextField("",this,{
               "x":g.x - 12,
               "y":g.y + 41
            });
            this.tfVec.push(tf);
            this.gridVec.push(g);
            i++;
         }
      }
      
      public function show(_result:int, _roleName:String) : void
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
         if(visible)
         {
            visible = true;
         }
         this.nameTF.htmlText = _roleName;
         if(_result == 0)
         {
            this.myTF.htmlText = "  您的黄钻已经过期，现在续费黄钻，即可免费获得价值\n" + "           的";
         }
         else if(_result == 1)
         {
            this.myTF.htmlText = "  您的黄钻即将过期，现在续费黄钻，即可免费获得价值\n" + "           的";
         }
         this.isOver = _result;
         this.roleName = _roleName;
         if(!visible)
         {
            visible = true;
         }
         var str:String = Data_lib.HZXF[44998][1];
         var _arr:Array = str.split(",");
         var i:int = 0;
         while(i < _arr.length)
         {
            __arr = (_arr[i] as String).split("_");
            _type = int(__arr[Enum_HZXF.TYPE]);
            _id = int(__arr[Enum_HZXF.ID]);
            _count = int(__arr[Enum_HZXF.COUNT]);
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
         YelloDiaCGMessage.CG_HUANGZUAN_XF_ASK();
      }
      
      public function xuFei(vaule:int) : void
      {
         var isEnable:int = vaule;
         if(isEnable == 1)
         {
            View_hzTribute.sendType = "self";
            YellowDiaManager.remindBuy();
         }
         else
         {
            UIManager.centerBroadcast.addMsg("不符合条件");
         }
      }
   }
}

