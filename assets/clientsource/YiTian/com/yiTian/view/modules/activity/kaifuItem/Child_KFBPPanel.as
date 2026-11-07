package com.yiTian.view.modules.activity.kaifuItem
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_KFBP;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.activity.Enum_KF;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_KFBPPanel extends Child_KaifuViewBase implements IBasekf
   {
      
      private static var _instance:Child_KFBPPanel;
      
      public static var tempIndex:int = 0;
      
      public static var tempType:int = 0;
      
      private static var _w:int = 135;
      
      private var content:Sprite;
      
      private var tf_title:MyTextField;
      
      private var tf_rwDescript:MyTextField;
      
      private var tf_actDescrpit:MyTextField;
      
      private var tf_ljDescript:MyTextField;
      
      private var itemVec:Vector.<Item>;
      
      private var maskSpr:Shape;
      
      private var continer:Sprite;
      
      private var left_btn:Button;
      
      private var right_btn:Button;
      
      private var title:MyTextField;
      
      private var _showTime:String;
      
      public var ratio:int = 2;
      
      public var powerr:Number = 0.4;
      
      private var moving:Boolean;
      
      private var R:int;
      
      private var itemX:Array = [6,145,282,413,550,686,816,956,1092];
      
      public function Child_KFBPPanel()
      {
         super();
         regResource("lang/ch/JCHD.swf","JCHDdm");
      }
      
      public static function get instance() : Child_KFBPPanel
      {
         return Singleton.getInstance(Child_KFBPPanel);
      }
      
      override protected function initUI2() : void
      {
         var item:Item = null;
         var i:int = 0;
         this.content = new Sprite();
         this.content.x = 155;
         this.content.y = 230;
         this.addChild(this.content);
         ComponentUtil.getBitmap("Back_WLDB",this.content,{
            "x":0,
            "y":0
         },Global.JCHDdm);
         ComponentUtil.getBitmap("Back_BZJL",this.content,{
            "x":1,
            "y":183
         },Global.JCHDdm);
         ComponentUtil.getBitmap("Back_BZJG",this.content,{
            "x":96,
            "y":1
         },Global.JCHDdm);
         ComponentUtil.getBitmap("DK_ZuoYou",this.content,{
            "x":2,
            "y":79
         },Global.JCHDdm);
         ComponentUtil.getBitmap("DK_ZuoYou",this.content,{
            "x":387,
            "y":79
         },Global.JCHDdm);
         this.title = ComponentUtil.getTextField("11月11日帮会战结果(这排文字加粗)",this.content,{
            "x":154,
            "y":3,
            "color":13816530,
            "size":12,
            "leading":0,
            "bold":true
         });
         this.continer = new Sprite();
         this.content.addChild(this.continer);
         this.continer.mask = this.maskSpr;
         var lib:Array = Data_lib.kf_bangpaipaihang.toArray();
         this.itemVec = new Vector.<Item>();
         i = 0;
         while(i < 9)
         {
            item = new Item(lib[int(i / 3)],i + 1);
            item.x = this.itemX[i];
            item.y = 26;
            item._id = i;
            this.continer.addChild(item);
            this.itemVec.push(item);
            i++;
         }
         var bg:Sprite = new Sprite();
         bg.mouseEnabled = false;
         this.content.addChild(bg);
         this.maskSpr = ComponentUtil.getShape(405,260,16711680,1);
         this.maskSpr.x = 7;
         this.content.addChild(this.maskSpr);
         this.continer.mask = this.maskSpr;
         this.right_btn = ComponentUtil.getButton("","Button_JCZuoFan",this.content,{
            "x":392,
            "y":77,
            "textColor":16771436,
            "callBack":this.rightHandler
         },Global.JCHDdm);
         this.left_btn = ComponentUtil.getButton("","Button_JCYouFan",this.content,{
            "x":4,
            "y":77,
            "textColor":16771436,
            "callBack":this.leftHandler
         },Global.JCHDdm);
         var _temp_1:* = this.left_btn;
         this.left_btn.enabled = false;
         _temp_1.mouseEnabled = false;
      }
      
      private function leftHandler(e:MouseEvent = null) : void
      {
         var endFun:Function = null;
         endFun = function():void
         {
            moving = false;
         };
         if(this.moving || this.R - 1 < 0)
         {
            return;
         }
         this.moving = true;
         --this.R;
         if(this.R - 1 < 0)
         {
            this.left_btn.mouseEnabled = this.left_btn.enabled = false;
         }
         this.right_btn.mouseEnabled = this.right_btn.enabled = true;
         Tween.to(this.continer,400,{"x":[this.continer.x,this.continer.x + _w * 3]},endFun,null,this.tFun);
         this.setTitle();
      }
      
      private function rightHandler(e:MouseEvent = null) : void
      {
         var vec:Vector.<Vo_KFBP>;
         var endFun:Function = null;
         endFun = function():void
         {
            moving = false;
         };
         if(this.moving || this.R + 1 > 2)
         {
            return;
         }
         vec = Model_actDaily.data_bangpai;
         if(!vec || vec.length < this.R + 1)
         {
            return;
         }
         this.moving = true;
         ++this.R;
         if(this.R + 1 > 2)
         {
            this.right_btn.mouseEnabled = this.right_btn.enabled = false;
         }
         this.left_btn.mouseEnabled = this.left_btn.enabled = true;
         Tween.to(this.continer,400,{"x":[this.continer.x,this.continer.x - _w * 3]},endFun,null,this.tFun);
         this.setTitle();
      }
      
      private function tFun(p:Number) : Number
      {
         var rate:Number = p * 3.1416 * this.ratio;
         return Math.pow(1 - Math.sin(rate) / rate,this.powerr);
      }
      
      private function setPage(showPage:int) : void
      {
         var xxx:int = showPage - 1 - this.R;
         switch(xxx)
         {
            case 1:
               this.rightHandler();
               break;
            case 2:
               this.moving = true;
               this.R = 0;
               this.right_btn.mouseEnabled = this.right_btn.enabled = true;
               this.left_btn.mouseEnabled = this.left_btn.enabled = false;
               Tween.to(this.continer,200,{"x":[this.continer.x,this.continer.x - _w * 6]},function():void
               {
                  moving = false;
               },null,this.tFun);
               break;
            case -1:
               this.leftHandler();
               break;
            case -2:
               this.moving = true;
               this.R = 0;
               this.right_btn.mouseEnabled = this.right_btn.enabled = true;
               this.left_btn.mouseEnabled = this.left_btn.enabled = false;
               Tween.to(this.continer,200,{"x":[this.continer.x,this.continer.x + _w * 6]},function():void
               {
                  moving = false;
               },null,this.tFun);
         }
      }
      
      private function setTitle() : void
      {
         var vec:Vector.<Vo_KFBP> = Model_actDaily.data_bangpai;
         var vo:Vo_KFBP = vec[(this.R + 1) * 3 - 1];
         this.title.htmlText = Enum_KF.transDate(int(vo.time),1);
      }
      
      public function iconFly() : void
      {
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            if(this.itemVec[i]._ids == tempIndex)
            {
               this.itemVec[i].iconFly();
            }
            i++;
         }
      }
      
      public function setdata(... arguments) : void
      {
         var item:Item = null;
         var vec:Vector.<Vo_KFBP> = Model_actDaily.data_bangpai;
         var i:int = 0;
         while(i < 9)
         {
            item = this.itemVec[i];
            if(Boolean(vec.length > i) && Boolean(vec[i]) && vec[i].hasData)
            {
               item.setdata(vec[i]);
            }
            else
            {
               item.setdata();
            }
            i++;
         }
         if(arguments[0] != 0)
         {
            this.setPage(arguments[0]);
            this.title.htmlText = Enum_KF.transDate(int(vec[arguments[0] * 3 - 1].time),1);
         }
         else
         {
            this.setPage(1);
            this.title.htmlText = Enum_KF.transDate(int(vec[arguments[0]].time),1);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            DailyActCGMessage.CG_KFHD_OPEN(2);
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.Enum_type_grid;
import com.yiTian.data.vo.Vo_KFBP;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.gameUnit.config.Action;
import com.yiTian.manager.EffectManager;
import com.yiTian.net.message.cg.DailyActCGMessage;
import com.yiTian.utils.Tween;
import com.yiTian.utils.Utils;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.activity.kaifuItem.Child_KFBPPanel;
import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

class Item extends Sprite
{
   
   private var maskSpr:Sprite;
   
   private var _modelRole:Child_tianTiUnit;
   
   private var tf:MyTextField;
   
   private var gg_btn:Button;
   
   private var dd_btn:Button;
   
   private var rankTf:MyTextField;
   
   private var gridArr:Array = [];
   
   public var _id:int;
   
   public var _ids:int;
   
   private var rank:int;
   
   private var bzbm:Bitmap;
   
   private var bzobm:Bitmap;
   
   private var rankArr:Array = ["","一","二","三"];
   
   public function Item(arr:Array, ids:int)
   {
      var grid:View_Grid = null;
      var vo:Vo_item = null;
      var i:int = 0;
      super();
      this._ids = ids;
      ComponentUtil.getBitmap("Back_RWTZ",this,{
         "x":0,
         "y":95
      },Global.JCHDdm);
      this.maskSpr = new Sprite();
      this.addChild(this.maskSpr);
      ComponentUtil.getBitmap("Back_XWRW",this.maskSpr,{
         "x":9,
         "y":0
      },Global.JCHDdm);
      ComponentUtil.getBitmap("Back_XWYD",this.maskSpr,{
         "x":11,
         "y":40
      },Global.JCHDdm);
      this._modelRole = new Child_tianTiUnit();
      this._modelRole.type = Child_tianTiUnit.PLAYER;
      this._modelRole.x = 55;
      this._modelRole.y = 120;
      this._modelRole.scaleX = this._modelRole.scaleY = 0.8;
      this._modelRole.way = 4;
      addChild(this._modelRole);
      this._modelRole.visible = false;
      this.rankTf = ComponentUtil.getTextField("第一名",this,{
         "x":55,
         "y":7,
         "color":327424,
         "size":12,
         "leading":0
      },TextFieldAutoSize.CENTER);
      this.tf = ComponentUtil.getTextField("2011年11月11日",this,{
         "x":55,
         "y":137,
         "color":13816530,
         "size":12,
         "leading":0
      },TextFieldAutoSize.CENTER);
      this.gg_btn = ComponentUtil.getButton("帮主领取","Button_Two64",this,{
         "x":0,
         "y":204,
         "textColor":16771436,
         "callBack":this.onClick
      },Global.Img_Cdm);
      this.bzbm = Utils.getLoadBitmap("resource/image/tuanGou/yilingqu.png",null,{
         "x":0,
         "y":200
      });
      addChild(this.bzbm);
      this.dd_btn = ComponentUtil.getButton("帮众领取","Button_Two64",this,{
         "x":66,
         "y":204,
         "textColor":16771436,
         "callBack":this.onClick
      },Global.Img_Cdm);
      this.bzobm = Utils.getLoadBitmap("resource/image/tuanGou/yilingqu.png",null,{
         "x":66,
         "y":200
      });
      addChild(this.bzobm);
      this.gg_btn.mouseEnabled = this.gg_btn.enabled = false;
      this.dd_btn.mouseEnabled = this.dd_btn.enabled = false;
      var flag:int = (this._ids - 1) % 3 + 1;
      var arr1:Array = [];
      var arr2:Array = [];
      arr1 = Util.splicObj(arr[flag * 2 - 1],",_") as Array;
      arr2 = Util.splicObj(arr[flag * 2],",_") as Array;
      var k:int = 0;
      while(k < arr1.length)
      {
         grid = new View_Grid();
         grid.type = Enum_type_grid.NO_DRAG;
         grid.set_bmp_over();
         grid.set_tf_count(true,true,true);
         grid.set_bmp_bg();
         vo = new Vo_item();
         vo.id = arr1[i][1];
         vo.count = arr1[i][2];
         vo.bBind = true;
         vo.Init_lib();
         EffectManager.addEffect("35176",grid,1200,17,18,true);
         grid.vo = vo;
         grid.set_tf_count();
         grid.x = 17;
         grid.y = 167;
         this.addChild(grid);
         this.gridArr.push(grid);
         k++;
      }
      i = 0;
      while(i < arr2.length)
      {
         grid = new View_Grid();
         grid.type = Enum_type_grid.NO_DRAG;
         grid.set_bmp_over();
         grid.set_tf_count(true,true,true);
         grid.set_bmp_bg();
         vo = new Vo_item();
         vo.id = arr2[i][1];
         vo.count = arr2[i][2];
         vo.bBind = true;
         vo.Init_lib();
         grid.vo = vo;
         grid.set_tf_count();
         grid.x = 78;
         grid.y = 167;
         this.addChild(grid);
         this.gridArr.push(grid);
         i++;
      }
   }
   
   public function onClick(e:MouseEvent) : void
   {
      var ii:int = Math.ceil(this._ids / 3);
      switch((e.target as Button).label)
      {
         case "帮主领取":
            DailyActCGMessage.CG_KFHD_BP_GETAWARD(ii,this.rank,1);
            Child_KFBPPanel.tempType = 1;
            break;
         case "帮众领取":
            DailyActCGMessage.CG_KFHD_BP_GETAWARD(ii,this.rank,0);
            Child_KFBPPanel.tempType = 0;
      }
      Child_KFBPPanel.tempIndex = this._ids;
   }
   
   public function iconFly() : void
   {
      if(Child_KFBPPanel.tempType == 0)
      {
         this.bzobm.visible = true;
         this.dd_btn.visible = false;
      }
      else
      {
         this.bzbm.visible = true;
         this.gg_btn.visible = false;
      }
      Tween.gridToBagBezierFuncDef(this.gridArr[Child_KFBPPanel.tempType]);
   }
   
   public function setdata(vo:Vo_KFBP = null) : void
   {
      var b:Boolean = false;
      var bb:Boolean = false;
      if(!vo)
      {
         this.tf.text = "";
         this.rankTf.text = "";
         this.gg_btn.mouseEnabled = this.gg_btn.enabled = false;
         this.dd_btn.mouseEnabled = this.dd_btn.enabled = false;
         this._modelRole.visible = false;
         this.maskSpr.visible = true;
         this.bzbm.visible = false;
         this.bzobm.visible = false;
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this._modelRole.onFrame);
      }
      else
      {
         this.rank = vo.rank;
         this.rankTf.text = "第" + this.rankArr[vo.rank] + "名";
         this.tf.text = "" + vo.familyName;
         b = vo.GGStatus == 1;
         this.gg_btn.mouseEnabled = this.gg_btn.enabled = b;
         if(vo.GGStatus == 2)
         {
            this.bzbm.visible = true;
            this.gg_btn.visible = false;
         }
         else
         {
            this.bzbm.visible = false;
            this.gg_btn.visible = true;
         }
         bb = vo.DDStatus == 1;
         this.dd_btn.mouseEnabled = this.dd_btn.enabled = bb;
         if(vo.DDStatus == 2)
         {
            this.bzobm.visible = true;
            this.dd_btn.visible = false;
         }
         else
         {
            this.bzobm.visible = false;
            this.dd_btn.visible = true;
         }
         this.maskSpr.visible = false;
         this._modelRole.visible = true;
         this._modelRole.way = 4;
         this._modelRole.type = Child_tianTiUnit.PLAYER;
         this._modelRole.modelId = vo.fishion;
         this._modelRole.weaponDir = vo.weapon + "";
         this._modelRole.state = Action.STAND;
         this._modelRole.job = vo.job;
         this._modelRole.sex = vo.sex;
         if(vo.wing != 0)
         {
            this._modelRole.wing = vo.wing;
         }
         this._modelRole.setFrameInterval(150);
         this._modelRole.updateLayer();
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this._modelRole.onFrame);
      }
   }
}
