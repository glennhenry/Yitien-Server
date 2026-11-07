package com.yiTian.view.modules.activity.kaifuItem
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_KFLevel;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import flash.display.Sprite;
   
   public class Child_KFCJPanel extends Child_KaifuViewBase implements IBasekf
   {
      
      public static var tempIndex:int;
      
      private static var _instance:Child_KFCJPanel;
      
      private var content:Sprite;
      
      private var itemVec:Vector.<Item>;
      
      public function Child_KFCJPanel()
      {
         super();
         regResource("lang/ch/JCHD.swf","JCHDdm");
      }
      
      public static function get instance() : Child_KFCJPanel
      {
         return Singleton.getInstance(Child_KFCJPanel);
      }
      
      override protected function initUI2() : void
      {
         var item:Item = null;
         var v:int = 0;
         this.content = new Sprite();
         this.content.x = 155;
         this.content.y = 230;
         this.addChild(this.content);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.content,{
            "width":420,
            "height":255
         },Global.Img_Cdm);
         this.itemVec = new Vector.<Item>();
         var lib:Array = Data_lib.kf_chongji.toArray();
         var len:int = int(lib.length);
         v = 0;
         while(v < len)
         {
            item = new Item(lib[v][2],v + 1,lib[v][1]);
            item.x = v % 2 * 209 + 2;
            item.y = int(v / 2) * 83 + 4;
            this.content.addChild(item);
            this.itemVec.push(item);
            v++;
         }
      }
      
      public function iconFly() : void
      {
         this.itemVec[tempIndex - 1].iconFly();
      }
      
      public function setdata(... arguments) : void
      {
         var vec:Vector.<Vo_KFLevel> = Model_actDaily.data_chongji;
         var len:int = int(vec.length);
         var i:int = 0;
         while(i < len)
         {
            this.itemVec[i].setdata(vec[i]);
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            DailyActCGMessage.CG_KFHD_OPEN(3);
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.data.Enum_type_grid;
import com.yiTian.data.vo.Vo_KFLevel;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.EffectManager;
import com.yiTian.net.message.cg.DailyActCGMessage;
import com.yiTian.utils.Tween;
import com.yiTian.utils.Utils;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.activity.kaifuItem.Child_KFCJPanel;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

class Item extends Sprite
{
   
   private var tf:MyTextField;
   
   private var tf_remain:MyTextField;
   
   public var _index:int;
   
   private var gridVec:Vector.<View_Grid>;
   
   private var btn:Button;
   
   private var bmp:Bitmap;
   
   public function Item(award:String, index:int, level:int)
   {
      var arr:Array = null;
      var grid:View_Grid = null;
      var vo:Vo_item = null;
      super();
      this._index = index;
      arr = Util.splicObj(award,",_") as Array;
      this.gridVec = new Vector.<View_Grid>();
      var bb:Bitmap = ComponentUtil.getBitmap("Back_CJJL",this,{
         "x":0,
         "y":0
      },Global.JCHDdm);
      bb.scale9Grid = new Rectangle(4,4,150,50);
      bb.height = 80;
      ComponentUtil.getBitmap("Text_JSJL",this,{
         "x":39,
         "y":4
      },Global.JCHDdm);
      ComponentUtil.getBitmap("Icon_LBX",this,{
         "x":4,
         "y":1
      },Global.JCHDdm);
      this.tf = ComponentUtil.getTextField(level + "",this,{
         "x":23,
         "y":1,
         "color":16776960,
         "size":12,
         "leading":0
      });
      this.tf_remain = ComponentUtil.getTextField("99999",this,{
         "x":165,
         "y":1,
         "color":327424,
         "size":12,
         "leading":0
      });
      this.btn = ComponentUtil.getButton("领取奖励","Button_Four",this,{
         "x":129,
         "y":37,
         "textColor":16771436,
         "callBack":this.onClick
      },Global.Img_Cdm);
      this.bmp = Utils.getLoadBitmap("resource/image/tuanGou/yilingqu.png",null,{
         "x":129,
         "y":28
      });
      addChild(this.bmp);
      var _temp_1:* = this.btn;
      this.btn.enabled = false;
      _temp_1.mouseEnabled = false;
      var i:int = 0;
      while(i < arr.length)
      {
         grid = new View_Grid();
         grid.type = Enum_type_grid.NO_DRAG;
         grid.set_bmp_over();
         grid.set_tf_count(true,true,true);
         grid.set_bmp_bg();
         grid.set_tf_count();
         vo = new Vo_item();
         vo.id = arr[i][1];
         vo.count = arr[i][2];
         vo.bBind = true;
         vo.Init_lib();
         grid.vo = vo;
         if([45235,46887].indexOf(vo.id) != -1)
         {
            EffectManager.addEffect("35176",grid,1200,17,18,true);
         }
         grid.x = 6 + 40 * i;
         grid.y = 30;
         this.addChild(grid);
         this.gridVec.push(grid);
         i++;
      }
   }
   
   private function onClick(evt:MouseEvent) : void
   {
      DailyActCGMessage.CG_KFHD_CJ_GETAWARD(this._index);
      Child_KFCJPanel.tempIndex = this._index;
   }
   
   public function setdata(vo:Vo_KFLevel) : void
   {
      this.tf_remain.text = "" + vo.remaind;
      var boo:Boolean = vo.status == 1;
      if(vo.remaind == 0)
      {
         boo = false;
      }
      if(vo.status == 2)
      {
         this.bmp.visible = true;
         this.btn.visible = false;
      }
      else
      {
         this.bmp.visible = false;
      }
      this.btn.mouseEnabled = this.btn.enabled = boo;
   }
   
   public function iconFly() : void
   {
      var i:int = 0;
      while(i < this.gridVec.length)
      {
         Tween.gridToBagBezierFuncDef(this.gridVec[i]);
         i++;
      }
   }
}
