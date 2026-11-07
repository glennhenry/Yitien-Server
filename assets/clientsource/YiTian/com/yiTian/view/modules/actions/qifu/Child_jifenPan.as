package com.yiTian.view.modules.actions.qifu
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.utils.Tween;
   import flash.display.Sprite;
   
   public class Child_jifenPan extends Sprite
   {
      
      public static var jifenType:int;
      
      private var itemVec:Vector.<ChildG>;
      
      private var contner:Canvas;
      
      public function Child_jifenPan()
      {
         var btn:Button;
         var dic:DictionaryTabel;
         var i:int;
         var arr:Array = null;
         var _a:Array = null;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var _jifen:int = 0;
         var childR:ChildG = null;
         var _voI:Vo_item = null;
         var _voE:Vo_equip = null;
         this.itemVec = new Vector.<ChildG>();
         super();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":298,
            "height":480
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":26,
            "y":39,
            "width":245,
            "height":430
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":42,
            "width":239,
            "height":424
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_HW",[20,20,1,1],this,{
            "x":30,
            "y":43,
            "width":216,
            "height":422
         },Global.QiFudm);
         ComponentUtil.getBitmap("Title_JFDH",this,{
            "x":70,
            "y":6
         },Global.QiFudm);
         btn = ComponentUtil.getButton("","Button_Close",this,{
            "x":261,
            "y":5,
            "textColor":16771436
         },Global.Img_Cdm);
         btn.callBack = function():void
         {
            if(Boolean(parent))
            {
               Tween.to(parent,200,{"x":[-299,0]});
            }
         };
         this.contner = new Canvas(239,408 - 31);
         ComponentUtil.setPropertie(this.contner,{
            "x":25,
            "y":47 + 9
         });
         addChild(this.contner);
         this.contner.scrollAutoType = ScrollAutoType.TO_TOP;
         this.contner.reset();
         dic = Data_lib.qfduihuan;
         i = 0;
         while(i < dic.getLength())
         {
            arr = dic[i + 1];
            _a = arr[0].split("_");
            _type = int(_a[0]);
            _id = int(_a[1]);
            _count = int(_a[2]);
            _jifen = int(arr[1]);
            childR = new ChildG();
            if(_type == 1)
            {
               _voI = new Vo_item();
               _voI.id = _id;
               _voI.count = _count;
               _voI.Init_lib();
               childR.vo = _voI;
            }
            else if(_type == 2)
            {
               _voE = new Vo_equip();
               _voE.id = _id;
               _voE.count = _count;
               _voE.Init_lib();
               childR.vo = _voE;
            }
            childR.jifen = _jifen;
            childR.type = i + 1;
            ComponentUtil.setPropertie(childR,{
               "x":24,
               "y":64 * i
            });
            this.contner.addChild(childR);
            i++;
         }
         this.contner.align();
         ComponentUtil.getTextField("祈福一次可获得10点积分",this,{
            "x":70,
            "y":439,
            "color":3461909,
            "size":12,
            "leading":0
         });
      }
      
      public function toTop() : void
      {
         this.contner.align();
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.data.vo.Vo_grid;
import com.yiTian.data.vo.Vo_valuable;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.QifuCGMessage;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.actions.qifu.Child_grid;
import com.yiTian.view.modules.actions.qifu.Child_jifenPan;
import com.yiTian.view.modules.actions.qifu.Model_qifu;
import com.yiTian.view.modules.actions.qifu.QifuPan;
import com.yiTian.view.modules.wuXing.WuXingMter;
import flash.display.Sprite;
import flash.geom.Point;

class ChildG extends Sprite
{
   
   private var grid:View_Grid;
   
   private var tfJf:MyTextField;
   
   public var type:int;
   
   public function ChildG()
   {
      super();
      ComponentUtil.getScaleBitmap("Back_WYBianQiang",[3,3,1,1],this,{
         "x":0,
         "y":0,
         "width":177,
         "height":55
      },Global.QiFudm);
      this.grid = new View_Grid();
      this.grid.set_bmp_bg();
      this.grid.set_bmp_over(true,null);
      this.grid.set_tf_count(true,false,true);
      addChild(this.grid);
      ComponentUtil.setPropertie(this.grid,{
         "x":7,
         "y":9
      });
      ComponentUtil.getButton("兑换","Button_Two",this,{
         "x":121,
         "y":15,
         "textColor":16771436,
         "callBack":function():void
         {
            var jf:*;
            var point:* = undefined;
            if(Child_grid.isRunning)
            {
               UIManager.centerBroadcast.addMsg("请稍等，正在获取祈祷物品");
               return;
            }
            jf = Data_lib.qfduihuan[type][1];
            if(QifuPan.jifenCount < jf)
            {
               WuXingMter.getPan(QifuPan,function(pan:QifuPan):void
               {
                  point = new Point(pan.x - 40,pan.y + pan.height / 2);
               });
               Model_qifu.addMes("积分不够",point);
               QifuPan.shanEff();
               return;
            }
            Child_jifenPan.jifenType = type;
            QifuCGMessage.CG_QIFU_DUIHUAN(type);
         }
      },Global.Img_Cdm);
      this.tfJf = ComponentUtil.getTextField("5000积分",this,{
         "x":56,
         "y":17,
         "color":16184781,
         "size":12,
         "leading":0
      });
   }
   
   public function set vo(value:Vo_valuable) : void
   {
      this.grid.vo = value as Vo_grid;
   }
   
   public function set jifen(value:int) : void
   {
      this.tfJf.htmlText = value + "积分";
   }
}
