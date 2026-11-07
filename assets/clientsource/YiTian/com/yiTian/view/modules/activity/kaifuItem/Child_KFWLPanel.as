package com.yiTian.view.modules.activity.kaifuItem
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_KFWL;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_KFWLPanel extends Child_KaifuViewBase implements IBasekf
   {
      
      private static var _instance:Child_KFWLPanel;
      
      private var tf_title:MyTextField;
      
      private var tf_rwDescript:MyTextField;
      
      private var tf_actDescrpit:MyTextField;
      
      private var tf_ljDescript:MyTextField;
      
      private var btn:Button;
      
      private var content:Sprite;
      
      private var itemVec:Vector.<RoleItem>;
      
      private var gridVec:Vector.<View_Grid>;
      
      public var _id:int;
      
      private var bmb:Bitmap;
      
      public function Child_KFWLPanel()
      {
         super();
         regResource("lang/ch/JCHD.swf","JCHDdm");
      }
      
      public static function get instance() : Child_KFWLPanel
      {
         return Singleton.getInstance(Child_KFWLPanel);
      }
      
      override protected function initUI2() : void
      {
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         var voE:Vo_equip = null;
         var type:int = 0;
         var item:RoleItem = null;
         var i:int = 0;
         this.itemVec = new Vector.<RoleItem>();
         this.gridVec = new Vector.<View_Grid>();
         this.content = new Sprite();
         this.content.y = 230;
         this.content.x = 155;
         this.addChild(this.content);
         ComponentUtil.getBitmap("Back_WLDB",this.content,{
            "x":0,
            "y":0
         },Global.JCHDdm);
         ComponentUtil.getBitmap("Back_DBJL",this.content,{
            "x":1,
            "y":203
         },Global.JCHDdm);
         var lib:Array = Data_lib.kf_wulin.toArray();
         var arr:Array = Util.splicObj(lib[0][1],",_") as Array;
         i = 0;
         while(i < arr.length)
         {
            type = int(arr[i][0]);
            grid = new View_Grid();
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_over();
            grid.set_tf_count(true,true,true);
            grid.set_bmp_bg();
            grid.set_tf_count();
            if(type == 1)
            {
               vo = new Vo_item();
               vo.id = arr[i][1];
               vo.count = arr[i][2];
               vo.bBind = true;
               vo.Init_lib();
               grid.vo = vo;
            }
            else
            {
               voE = new Vo_equip();
               voE.id = arr[i][1];
               voE.count = arr[i][2];
               voE.bBind = true;
               voE.Init_lib();
               grid.vo = voE;
               EffectManager.addEffect("35176",grid,1200,17,18,true);
            }
            grid.x = 5 + 43 * i;
            grid.y = 211;
            this.content.addChild(grid);
            this.gridVec.push(grid);
            i++;
         }
         this.btn = ComponentUtil.getButton("领取奖励","Button_Four",this.content,{
            "x":344,
            "y":218,
            "textColor":16771436,
            "callBack":this.onClick
         },Global.Img_Cdm);
         this.bmb = Utils.getLoadBitmap("resource/image/tuanGou/yilingqu.png",null,{
            "x":344,
            "y":208
         });
         this.content.addChild(this.bmb);
         var _temp_1:* = this.btn;
         this.btn.enabled = false;
         _temp_1.mouseEnabled = false;
         i = 0;
         while(i < 3)
         {
            item = new RoleItem(i + 1);
            item.x = i * 127;
            item.y = 12;
            this.content.addChild(item);
            this.itemVec.push(item);
            i++;
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         DailyActCGMessage.CG_KFHD_WL_GETAWARD();
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
      
      public function setdata(... arguments) : void
      {
         var nextLevl:int = 0;
         var tempVo:Vo_KFWL = null;
         var tempVoV:Vo_KFWL = null;
         this.btn.mouseEnabled = this.btn.enabled = arguments[0] == 1;
         if(arguments[0] == 2)
         {
            this.bmb.visible = true;
            this.btn.visible = false;
            this.btn.label = "已领取";
         }
         else
         {
            this.bmb.visible = false;
         }
         var vec:Vector.<Vo_KFWL> = Model_actDaily.data_wulin;
         var len:int = int(vec.length);
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            tempVo = null;
            tempVoV = null;
            if(Boolean(vec.length > i * 2) && Boolean(vec[i * 2]) && vec[i * 2].hasData)
            {
               tempVo = vec[i * 2];
            }
            nextLevl = i * 2 + 1;
            if(Boolean(vec.length > nextLevl) && Boolean(vec[nextLevl]) && vec[nextLevl].hasData)
            {
               tempVoV = vec[nextLevl];
            }
            this.itemVec[i].update(tempVo,tempVoV);
            this.itemVec[i].index = 1;
            i++;
         }
      }
      
      override public function show() : void
      {
         super.show();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            DailyActCGMessage.CG_KFHD_OPEN(1);
         }
      }
      
      public function get status() : Boolean
      {
         return false;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.vo.Vo_KFWL;
import com.yiTian.gameUnit.config.Action;
import com.yiTian.view.modules.activity.Enum_KF;
import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import flashx.textLayout.formats.TextAlign;

class RoleItem extends Sprite
{
   
   public var _id:Number;
   
   private var tf:MyTextField;
   
   private var _modelRole:Child_tianTiUnit;
   
   private var emptyBg:Sprite;
   
   private var tf_time:MyTextField;
   
   private var changeBtnLink:MyTextField;
   
   private var titleBm:Bitmap;
   
   public var index:int;
   
   private var bm:Bitmap;
   
   private var um:Array = ["","Text_DHDYiM","Text_DHDErM","Text_DHDSanM"];
   
   private var roleVec:Vector.<Child_tianTiUnit>;
   
   private var roleNameVec:Vector.<MyTextField>;
   
   private var pp:Vector.<Point>;
   
   public function RoleItem(_index:int)
   {
      var i:int = 0;
      var ttf:MyTextField = null;
      super();
      this.index = _index;
      this.pp = new Vector.<Point>();
      this.roleNameVec = new Vector.<MyTextField>();
      this.pp.push(new Point(80,150),new Point(43,150),new Point(110,150));
      ComponentUtil.getBitmap("Back_RWTZ",this,{
         "x":26,
         "y":125
      },Global.JCHDdm);
      this.emptyBg = new Sprite();
      this.addChild(this.emptyBg);
      ComponentUtil.getBitmap("Back_XWRW",this.emptyBg,{
         "x":35,
         "y":30
      },Global.JCHDdm);
      this.bm = ComponentUtil.getBitmap("Back_XWYD",this.emptyBg,{
         "x":37,
         "y":69
      },Global.JCHDdm);
      ComponentUtil.getBitmap("Text_DHDYiM",this,{
         "x":5,
         "y":0
      },Global.JCHDdm);
      this.roleVec = new Vector.<Child_tianTiUnit>();
      i = 0;
      while(i < 2)
      {
         this._modelRole = new Child_tianTiUnit();
         this.addChild(this._modelRole);
         this._modelRole.x = 90;
         var _temp_1:* = this._modelRole;
         this._modelRole.scaleY = 0.8;
         _temp_1.scaleX = 0.8;
         this._modelRole.y = 150;
         this._modelRole.visible = false;
         this.roleVec.push(this._modelRole);
         ttf = ComponentUtil.getTextField("",this,{
            "x":41 * i,
            "y":40,
            "color":13816530,
            "size":12,
            "leading":0,
            "visible":false
         });
         this.roleNameVec.push(ttf);
         i++;
      }
      this.tf_time = ComponentUtil.getTextField("2011年11月11日",this,{
         "x":81,
         "y":167,
         "color":13816530,
         "size":12,
         "leading":0
      },TextAlign.CENTER);
   }
   
   public function update(vo:Vo_KFWL, vo1:Vo_KFWL) : void
   {
      var i:int = 0;
      var temp:Vo_KFWL = null;
      var setPP:Function = function(modelRole:Child_tianTiUnit, vo_kf:Vo_KFWL, p:Point, tt:MyTextField):void
      {
         tf_time.htmlText = Enum_KF.transDate(int(vo_kf.time),1);
         tt.visible = true;
         modelRole.visible = true;
         modelRole.x = p.x;
         modelRole.y = p.y;
         modelRole.way = 3;
         modelRole.type = Child_tianTiUnit.PLAYER;
         modelRole.modelId = vo_kf.fishion;
         modelRole.weaponDir = vo_kf.weapon + "";
         modelRole.state = Action.STAND;
         modelRole.job = vo_kf.job;
         modelRole.sex = vo_kf.sex;
         if(vo_kf.wing != 0)
         {
            modelRole.wing = vo_kf.wing;
         }
         modelRole.setFrameInterval(150);
         modelRole.updateLayer();
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,modelRole.onFrame);
         tt.align = TextAlign.CENTER;
         tt.x = p.x - 20;
         tt.text = vo_kf.roleName;
      };
      if(vo == null && vo1 == null)
      {
         this.emptyBg.visible = true;
         this.tf_time.visible = false;
         i = 0;
         while(i < 2)
         {
            this.roleVec[i].visible = false;
            this.roleNameVec[i].visible = false;
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.roleVec[i].onFrame);
            i++;
         }
      }
      else
      {
         this.tf_time.visible = true;
         this.emptyBg.visible = false;
         if(vo == null || vo1 == null)
         {
            temp = Boolean(vo) ? vo : vo1;
            setPP(this.roleVec[0],temp,this.pp[0],this.roleNameVec[0]);
         }
         else
         {
            setPP(this.roleVec[0],vo,this.pp[1],this.roleNameVec[0]);
            setPP(this.roleVec[1],vo1,this.pp[2],this.roleNameVec[1]);
         }
      }
   }
}
