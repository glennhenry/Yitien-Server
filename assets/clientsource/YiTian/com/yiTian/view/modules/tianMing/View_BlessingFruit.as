package com.yiTian.view.modules.tianMing
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class View_BlessingFruit extends Panel123
   {
      
      private static var _instance:View_BlessingFruit;
      
      public var nowItem:int;
      
      private var titleBg:Bitmap;
      
      private var back:ScaleBitmap;
      
      private var gridVec:Vector.<BlessItem>;
      
      public function View_BlessingFruit()
      {
         super();
         init();
      }
      
      public static function get instance() : View_BlessingFruit
      {
         if(!_instance)
         {
            _instance = new View_BlessingFruit();
         }
         return _instance;
      }
      
      public function getNowPos() : Point
      {
         var grid:BlessItem = this.gridVec[this.nowItem];
         var point:Point = new Point(grid.x + 25,grid.y + 88);
         return grid.parent.localToGlobal(point);
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":338,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":290,
            "height":160
         },Global.Img_Cdm);
         move = new Rectangle(0,0,338,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":304,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.creatGrid();
      }
      
      private function creatGrid() : void
      {
         var item:BlessItem = null;
         this.gridVec = new Vector.<BlessItem>(3);
         var START_ID:int = Enum_TianMing.FRUIT_FIRST_ID;
         var i:int = 0;
         while(i < 3)
         {
            item = new BlessItem();
            item.show(START_ID + i);
            addChild(item);
            this.gridVec[i] = item;
            ComponentUtil.setPropertie(item,{
               "x":34,
               "y":50 + i * 47
            });
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(visible)
         {
            if(!Global.TianMing_Imgsdm)
            {
               regResource(Enum_TianMing.TIANMINGSOURCE,"TianMing_Imgsdm");
               preFun();
            }
            else if(!this.titleBg)
            {
               this.initUI2();
            }
         }
      }
      
      override protected function initUI2() : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_ZhuFuGuo",this,{
            "x":89,
            "y":5
         },Global.TianMing_Imgsdm);
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.Data_lib;
import com.yiTian.data.config.Enum_TianMing;
import com.yiTian.data.config.valuable.Enum_color;
import com.yiTian.data.model.Model_Tianming;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.CommandManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.TianMingCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.view.comp.View_Alert;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.tianMing.View_BlessingFruit;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

class BlessItem extends Sprite
{
   
   private var grid:View_Grid;
   
   private var content:MyTextField;
   
   private var numTF:MyTextField;
   
   private var btn:Button;
   
   public function BlessItem()
   {
      super();
      this.init();
   }
   
   private function init() : void
   {
      ComponentUtil.getScaleBitmap("ListBack_Bule01",[7,7,1,1],this,{
         "x":0,
         "y":0,
         "width":270,
         "height":46
      },Global.Img_Cdm);
      this.grid = new View_Grid();
      addChild(this.grid);
      this.grid.set_bmp_bg();
      this.grid.set_bmp_over();
      ComponentUtil.setPropertie(this.grid,{
         "x":10,
         "y":5
      });
      this.content = ComponentUtil.getTextField("",this,{
         "x":60,
         "y":12,
         "color":16777215,
         "size":14,
         "leading":0
      });
      this.numTF = ComponentUtil.getTextField("",this,{
         "x":155,
         "y":13,
         "color":16777215,
         "size":12,
         "leading":0
      });
      this.btn = ComponentUtil.getButton(LangConfig.getWord("80218",8),"Button_RedTwo",this,{
         "x":200,
         "y":11,
         "textColor":16184781
      },Global.Img_Cdm);
      this.btn.callBack = this.clickFun;
   }
   
   public function show(id:int) : void
   {
      var color:String = null;
      var vo:Vo_item = new Vo_item();
      vo.id = id;
      vo.Init_lib();
      this.grid.vo = vo;
      if(vo.color == Enum_color.WHITE)
      {
         color = ColorConstant.getColorStr(ColorConstant.WHITE);
      }
      else if(vo.color == Enum_color.GREEN)
      {
         color = ColorConstant.getColorStr(ColorConstant.GREEN);
      }
      else if(vo.color == Enum_color.BLUE)
      {
         color = ColorConstant.getColorStr(ColorConstant.BLUE);
      }
      else if(vo.color == Enum_color.PURPLE)
      {
         color = ColorConstant.getColorStr(ColorConstant.PURPLE);
      }
      else if(vo.color == Enum_color.ORANGE)
      {
         color = ColorConstant.getColorStr(ColorConstant.ORANGE);
      }
      else if(vo.color == Enum_color.ANJIN)
      {
         color = ColorConstant.getColorStr(ColorConstant.ANJIN);
      }
      this.content.htmlText = HtmlUtil.font(vo.str_name,color);
      this.upNum();
      Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.upNum);
   }
   
   private function upNum() : void
   {
      this.numTF.htmlText = "X" + CommandManager.get_bag_count(this.grid.vo.id);
   }
   
   public function getGridPos() : Point
   {
      return this.grid.parent.localToGlobal(new Point(this.grid.x,this.grid.y));
   }
   
   private function clickFun(event:MouseEvent) : void
   {
      var id:int = 0;
      if(CommandManager.get_bag_count(this.grid.vo.id) <= 0)
      {
         View_Alert.show(LangConfig.getWord("80216",8),View_Alert.OK_CANCAL,function():void
         {
            UIManager.sm_shop.visible = true;
         });
      }
      else if(Model_Tianming.zhuFuExp >= Data_lib.tmzf[Enum_TianMing.ZHUFU_MAXLEVEL][0])
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("80219",8));
      }
      else
      {
         id = this.grid.vo.id - Enum_TianMing.FRUIT_FIRST_ID;
         TianMingCGMessage.CG_USE_BLESSINGFRUIT(id + 1,1);
         View_BlessingFruit.instance.nowItem = id;
      }
   }
}
