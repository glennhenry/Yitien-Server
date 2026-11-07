package com.yiTian.view.modules.gongcehuodong
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WanJiaZhaoHuiCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class View_WanJiaZhaoHui extends Panel123
   {
      
      private static var _instance:View_WanJiaZhaoHui;
      
      public static var BTN_INDEX:int;
      
      private var _inviteGridArr:Array = [];
      
      private var _inviteBtn:Button;
      
      private var _awardBtn:Button;
      
      private var _getAwardTF:MyTextField;
      
      private var _curTime:int;
      
      private var _upTime:int;
      
      private var _itemArr:Array = [];
      
      private var _init:Boolean = false;
      
      private var _statusArr:Array;
      
      private var _num:int;
      
      public function View_WanJiaZhaoHui()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/wanjiazhaohui.swf","GCHGdm");
      }
      
      public static function get instance() : View_WanJiaZhaoHui
      {
         if(!_instance)
         {
            _instance = new View_WanJiaZhaoHui();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int;
         var staticGrid:View_Grid;
         var vo:Vo_item;
         var bm:Bitmap;
         var awardStr:String;
         var awardArr:Array;
         var handleArr:Array;
         var len:int;
         var grid:View_Grid = null;
         var temp:Array = null;
         var item:Child_Item = null;
         var str:String = null;
         move = new Rectangle(0,0,672,40);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":672,
            "height":441
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":622,
            "height":391
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":637,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_ZXHG",this,{
            "x":256,
            "y":6
         },Global.GCHGdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":598,
            "height":350
         },Global.GCHGdm);
         ComponentUtil.getBitmap("Back_ZXHG",this,{
            "x":44,
            "y":59
         },Global.GCHGdm);
         ComponentUtil.getTextField("成功邀请七天未登录游戏的三名玩家即可领取奖励！",this,{
            "x":150,
            "y":114,
            "color":16774354,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("回归条件：连续7天未登录≥30级的玩家！",this,{
            "x":43,
            "y":405,
            "color":8643072,
            "size":12,
            "leading":0
         });
         i = 0;
         while(i < 5)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count(true,false,true);
            addChild(grid);
            grid.x = 149 + i * 41;
            grid.y = 138;
            this._inviteGridArr.push(grid);
            i++;
         }
         staticGrid = new View_Grid(true);
         staticGrid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         staticGrid.set_bmp_over(false,null);
         addChild(staticGrid);
         vo = new Vo_item();
         vo.bgIndex = 4;
         staticGrid.vo = vo;
         ComponentUtil.setPropertie(staticGrid,{
            "x":70,
            "y":109
         });
         bm = new Bitmap();
         addChild(bm);
         ComponentUtil.setPropertie(bm,{
            "x":70,
            "y":109
         });
         Utils.getLoadBitmap("resource/image/icon60/46506.png",bm);
         awardStr = Data_lib.wanjiazhaohui[1][1];
         awardArr = awardStr.split(",");
         handleArr = [];
         i = 0;
         while(i < awardArr.length)
         {
            temp = awardArr[i].split("_");
            handleArr.push(temp);
            i++;
         }
         this.updateGrids(handleArr);
         len = int(Data_lib.wanjiazhaohui.getLength());
         i = 1;
         while(i < len)
         {
            item = new Child_Item();
            item.upLimit = Data_lib.wanjiazhaohui[i + 1][2];
            item.index = i;
            addChild(item);
            this._itemArr.push(item);
            str = Data_lib.wanjiazhaohui[i + 1][3];
            item.updateGrids(str);
            item.x = 44 + (i - 1) * 151;
            item.y = 222;
            i++;
         }
         ComponentUtil.getBitmap("Text_YiTianLing",this,{
            "x":44,
            "y":69
         },Global.GCHGdm);
         ComponentUtil.getBitmap("Text_ZJL",this,{
            "x":37,
            "y":185
         },Global.GCHGdm);
         ComponentUtil.getBitmap("Text_ZJLEr",this,{
            "x":230,
            "y":226
         },Global.GCHGdm);
         ComponentUtil.getBitmap("Text_ZJLSan",this,{
            "x":381,
            "y":226
         },Global.GCHGdm);
         ComponentUtil.getBitmap("Text_ZJLSi",this,{
            "x":532,
            "y":226
         },Global.GCHGdm);
         ComponentUtil.getBitmap("Text_ZJLYi",this,{
            "x":79,
            "y":226
         },Global.GCHGdm);
         this._awardBtn = ComponentUtil.getButton("领取奖励","Button_TwoBule91",this,{
            "x":354,
            "y":144,
            "textColor":16771436,
            "callBack":this.awardFunc
         },Global.Img_Cdm);
         this._inviteBtn = ComponentUtil.getButton("","Button_YQWJ",this,{
            "x":490,
            "y":120,
            "textColor":16771436,
            "callBack":this.inviteFunc
         },Global.GCHGdm);
         this._init = true;
         if(Boolean(this._statusArr))
         {
            this.update(this._statusArr,this._num);
         }
      }
      
      public function updateGrids(arr:Array) : void
      {
         var i:int = 0;
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         i = 0;
         while(i < arr.length)
         {
            type = int(arr[i][0]);
            id = int(arr[i][1]);
            count = int(arr[i][2]);
            if(type == 1)
            {
               voI = new Vo_item();
               voI.id = id;
               voI.count = count;
               voI.Init_lib();
               voI.bBind = true;
               this._inviteGridArr[i].vo = voI;
            }
            else if(type == 2)
            {
               voE = new Vo_equip();
               voE.id = id;
               voE.count = count;
               voE.Init_lib();
               voI.bBind = true;
               this._inviteGridArr[i].vo = voE;
            }
            i++;
         }
      }
      
      private function awardFunc(e:MouseEvent) : void
      {
         View_WanJiaZhaoHui.BTN_INDEX = 0;
         WanJiaZhaoHuiCGMessage.CG_WJZH_AWARD(0);
      }
      
      public function update(statusArr:Array, num:int) : void
      {
         this._statusArr = statusArr;
         this._num = num;
         if(!this._init)
         {
            return;
         }
         this.updateBtn(statusArr[0]);
         var i:int = 0;
         while(i < this._itemArr.length)
         {
            this._itemArr[i].update(statusArr[i + 1],num);
            i++;
         }
      }
      
      public function getAward(index:int) : void
      {
         var i:int = 0;
         var tx:int = 0;
         var ty:int = 0;
         if(index == 0)
         {
            this.updateBtn(2);
            i = 0;
            while(i < this._inviteGridArr.length)
            {
               ComboTweenStep.toBag(this._inviteGridArr[i]);
               i++;
            }
         }
         else
         {
            this._itemArr[index - 1].updateBtn(2);
            tx = this._itemArr[index - 1].x + this._itemArr[index - 1].grid.x;
            ty = this._itemArr[index - 1].y + this._itemArr[index - 1].grid.y;
            this.flyIcon(tx,ty);
         }
      }
      
      private function updateBtn(status:int) : void
      {
         switch(status)
         {
            case 0:
               this._awardBtn.enabled = false;
               this._awardBtn.label = "领取奖励";
               break;
            case 1:
               this._awardBtn.enabled = true;
               this._awardBtn.label = "领取奖励";
               break;
            case 2:
               this._awardBtn.enabled = false;
               this._awardBtn.label = "已领取";
         }
      }
      
      private function inviteFunc(e:MouseEvent) : void
      {
         ExternalInterface.call("inviteFriend");
      }
      
      public function flyIcon(x:int, y:int) : void
      {
         var disPoint:Point = null;
         var p:Point = null;
         var bm:Bitmap2 = null;
         var dir:String = "resource/image/icon60/46506.png";
         disPoint = UIManager.mainMenu.getbagPoint();
         p = this.localToGlobal(new Point(x,y));
         bm = new Bitmap2();
         bm.load(dir);
         bm.x = p.x + 15;
         bm.y = p.y - 25;
         GameScene.upUILayer.addChild(bm);
         Tween.to(bm,2500,{
            "x":[bm.x,disPoint.x],
            "y":[bm.y,disPoint.y]
         },function(bm:Bitmap2):void
         {
            if(Boolean(bm.parent))
            {
               bm.parent.removeChild(bm);
            }
         },null,Tween.SIN);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            WanJiaZhaoHuiCGMessage.CG_WJZH_SHOWPANEL();
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.model.Model_worldLevel;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.TipManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.WanJiaZhaoHuiCGMessage;
import com.yiTian.utils.Utils;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.gongcehuodong.View_WanJiaZhaoHui;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFormatAlign;

class Child_Item extends Sprite
{
   
   private var _txt:MyTextField;
   
   private var _btn:Button;
   
   private var _grid:View_Grid;
   
   public var upLimit:int;
   
   public var index:int;
   
   public function Child_Item()
   {
      super();
      this.initUI();
   }
   
   public function get grid() : View_Grid
   {
      return this._grid;
   }
   
   private function initUI() : void
   {
      ComponentUtil.getBitmap("Back_ZJLD",this,{
         "x":0,
         "y":0
      },Global.GCHGdm);
      this._grid = new View_Grid(true);
      this._grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
      this._grid.set_bmp_over(true,null);
      addChild(this._grid);
      var vo:Vo_item = new Vo_item();
      vo.bgIndex = 4;
      this._grid.vo = vo;
      this._grid.x = 32;
      this._grid.y = 34;
      var bm:Bitmap = new Bitmap();
      addChild(bm);
      ComponentUtil.setPropertie(bm,{
         "x":32,
         "y":34
      });
      Utils.getLoadBitmap("resource/image/icon60/46506.png",bm);
      ComponentUtil.getTextField("全服回归人数达到",this,{
         "x":19,
         "y":105,
         "color":16774354
      });
      this._txt = ComponentUtil.getTextField("",this,{
         "x":19,
         "y":123,
         "color":16764206,
         "size":12,
         "leading":2,
         "realWidth":100
      });
      this._txt.align = TextFormatAlign.CENTER;
      this._txt.text = "0/200";
      this._btn = ComponentUtil.getButton("领取奖励","Button_TwoBule91",this,{
         "x":20,
         "y":139,
         "textColor":16771436,
         "callBack":this.gain
      },Global.Img_Cdm);
   }
   
   private function gain(e:MouseEvent) : void
   {
      View_WanJiaZhaoHui.BTN_INDEX = this.index;
      if(GameUnitManager.hero.level >= 30 && GameUnitManager.hero.level < Model_worldLevel.worldLev - 50)
      {
         UIManager.centerBroadcast.addMsg("领取奖励等级不能低于世界等级50级",1);
         return;
      }
      WanJiaZhaoHuiCGMessage.CG_WJZH_AWARD(this.index);
   }
   
   public function update(status:int, num:int) : void
   {
      this.updateBtn(status);
      this._txt.text = num + "/" + this.upLimit;
   }
   
   public function updateBtn(status:int) : void
   {
      switch(status)
      {
         case 0:
            this._btn.enabled = false;
            this._btn.label = "领取奖励";
            break;
         case 1:
            this._btn.enabled = true;
            break;
         case 2:
            this._btn.enabled = false;
            this._btn.label = "已领取";
      }
   }
   
   public function updateGrids(str:String) : void
   {
      if(Boolean(this._grid))
      {
         TipManager.bind(this._grid,str);
      }
   }
}
