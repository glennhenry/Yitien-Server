package com.yiTian.view.modules.zhutizhou
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.ZhuTiZhouHandler;
   import com.yiTian.net.message.cg.ZhuTiZhouCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class ActivityTopicPanel extends Panel123
   {
      
      public static var index:int = 0;
      
      private static var isLoaded:Boolean = false;
      
      private var _gridVec:Array = [];
      
      private var lastTime:uint;
      
      public var id:int = 1;
      
      public var dataArr:Array = [];
      
      public var _isCompleted:Boolean = false;
      
      private var _isFirstOpen:Boolean = true;
      
      public var isAvaibled:Boolean = false;
      
      private var _titleDes:MyTextField;
      
      private var recordPos:Point = new Point(0,0);
      
      private var clearIdArr:Array;
      
      private var typeIdArr:Array;
      
      private var tipBitmap:Bitmap;
      
      private var clearMoveId:int;
      
      private var _timeLimitTF:MyTextField;
      
      private var libaoId:int;
      
      private var libaoXuhaoId:int;
      
      private var libaoTime:int;
      
      private var addEff:Effect;
      
      private var STR1:String = "resource/image/zhutizhou/";
      
      private const STR2:String = "resource/image/zhutizhou/linqujiangli.png";
      
      private var shouChongBtn:Sprite;
      
      private var scBM:Bitmap;
      
      private var curStr:String;
      
      private var leftTime:MyTextField;
      
      private var times:Number;
      
      private var lastTime1:int = 0;
      
      public function ActivityTopicPanel()
      {
         super();
      }
      
      public function get scBtn() : Sprite
      {
         if(Boolean(this.shouChongBtn))
         {
            return this.shouChongBtn;
         }
         return new Sprite();
      }
      
      override protected function initUI2() : void
      {
         var i:int;
         var grid:View_Grid = null;
         move = new Rectangle(0,0,695,38);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":695,
            "height":424
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_ZTZHD",this,{
            "x":25,
            "y":40
         },Global.ZhuTiZhou_Imgsdm);
         ComponentUtil.getBitmap("Back_ZBZT",this,{
            "x":56,
            "y":71
         },Global.ZhuTiZhou_Imgsdm);
         ComponentUtil.getBitmap("Back_MeiNv",this,{
            "x":570,
            "y":37
         },Global.ZhuTiZhou_Imgsdm);
         this.tipBitmap = ComponentUtil.getBitmap("Back_HuaYu",this,{
            "x":520,
            "y":35
         },Global.ZhuTiZhou_Imgsdm);
         ComponentUtil.getButton("","Button_WYJL",this,{
            "x":243,
            "y":293,
            "textColor":16771436,
            "callBack":function():void
            {
               UIManager.yuanBaoXiang.visible = true;
            }
         },Global.ZhuTiZhou_Imgsdm);
         ComponentUtil.getBitmap("Title_ZTZHD",this,{
            "x":267,
            "y":5
         },Global.ZhuTiZhou_Imgsdm);
         ComponentUtil.getTextField("活动结束倒计时：",this,{
            "x":50,
            "y":360,
            "color":16777215
         });
         this._timeLimitTF = ComponentUtil.getTextField("",this,{
            "x":146,
            "y":360,
            "color":10092288
         });
         this._gridVec = [];
         i = 0;
         while(i < 6)
         {
            grid = new View_Grid(true);
            grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
            grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
            grid.set_tf_count(true,true,true);
            addChild(grid);
            this._gridVec.push(grid);
            ComponentUtil.setPropertie(grid,{
               "x":112 + i * 80,
               "y":146
            });
            i++;
         }
         this._isCompleted = true;
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":660,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         super.initDynamicView();
         isLoaded = true;
         this.initData(Data_lib.zhutizhou[this.id]);
         this.resetPosition();
      }
      
      public function showIcon(type:int) : void
      {
         if(!this.shouChongBtn)
         {
            this.shouChongBtn = new Sprite();
            this.shouChongBtn.graphics.beginFill(16777215,0);
            this.shouChongBtn.graphics.drawRect(0,0,65,70);
            this.shouChongBtn.graphics.endFill();
            this.scBM = new Bitmap();
            this.shouChongBtn.addChild(this.scBM);
            this.shouChongBtn.buttonMode = true;
            this.shouChongBtn.addEventListener(MouseEvent.CLICK,this.shouChongOnClick);
         }
         UIManager.mainUiBtnContainer.addBTN(this.shouChongBtn);
         this.leftTime = ComponentUtil.getTextField("0天0时0分",this.shouChongBtn);
         if(type == 1)
         {
            this.curStr = this.STR2;
            Utils.getLoadBitmap(this.STR2,this.scBM);
            if(Boolean(this.leftTime))
            {
               this.leftTime.visible = false;
            }
            if(!this.addEff)
            {
               this.addEff = EffectManager.addEffect("35343",this.shouChongBtn,1000,32,29,true);
            }
         }
         else if(type == 0)
         {
            this.STR1 += Data_lib.zhutizhou[this.id][5] + ".png";
            this.curStr = this.STR1;
            Utils.getLoadBitmap(this.STR1,this.scBM);
            ComponentUtil.setPropertie(this.leftTime,{
               "x":(this.shouChongBtn.width - this.leftTime.width) * 0.5,
               "y":this.shouChongBtn.height - this.leftTime.height * 0.6 - 7,
               "color":16776960,
               "size":12
            });
         }
      }
      
      public function playEff() : void
      {
         var itemArr1:Array = null;
         var type:int = 0;
         var id:int = 0;
         var vo:Vo_item = null;
         var voE:Vo_equip = null;
         var sid:int = 0;
         var p:Point = UIManager.mainUiBtnContainer.localToGlobal(new Point(this.shouChongBtn.x,this.shouChongBtn.y));
         this.clearIdArr = [];
         var voArr:Array = [];
         var objArr:Array = Data_lib.zhutizhou[this.id][4].split(",");
         var len:int = int(objArr.length);
         this.libaoId = Data_lib.zhutizhou[this.id][6];
         var i:int = 0;
         while(i < len)
         {
            itemArr1 = objArr[i].split("_");
            type = int(itemArr1[0]);
            id = int(itemArr1[1]);
            if(id != this.libaoId)
            {
               if(type == 1)
               {
                  vo = new Vo_item();
                  vo.id = id;
                  vo.Init_lib();
                  voArr.push(vo);
               }
               else if(type == 2)
               {
                  voE = new Vo_equip();
                  voE.id = id;
                  voE.Init_lib();
                  voArr.push(voE);
               }
            }
            i++;
         }
         var volen:int = int(voArr.length);
         i = 0;
         while(i < volen)
         {
            sid = int(setTimeout(this.timeOutFunc,100 * i,{
               "index":i,
               "point":p,
               "grid":voArr[i],
               "voLength":volen
            }));
            this.clearIdArr[i] = sid;
            i++;
         }
      }
      
      private function timeOutFunc(o:Object) : void
      {
         var i:int = 0;
         var _getAwardPanel:View_XianShiLiBaoPanel = null;
         var clearId2:int = 0;
         Tween.gridToBagBezierFuncDef(o.grid,-1,o.point.x,o.point.y);
         clearTimeout(this.clearIdArr[o.index]);
         if(o.index == o.voLength - 1)
         {
            this.removeShouChongBtn();
            this.visible = false;
            if(this._isFirstOpen)
            {
               this.initData(Data_lib.zhutizhou[this.id]);
            }
            i = 0;
            while(i < this._gridVec.length)
            {
               if((this._gridVec[i] as View_Grid).vo.id == this.libaoId)
               {
                  _getAwardPanel = new View_XianShiLiBaoPanel();
                  ZhuTiZhouHandler.libaoPanelArr.push(_getAwardPanel);
                  _getAwardPanel.updateIconData(this.libaoXuhaoId,this.libaoTime);
                  clearId2 = int(setTimeout(function():void
                  {
                     clearTimeout(clearId2);
                     var btnPoint:* = new Point(_getAwardPanel.libaoBtn.x + 15,_getAwardPanel.libaoBtn.y + 15);
                     var aimPoint:* = UIManager.mainUiBtnContainer.localToGlobal(btnPoint);
                     var vo:* = new Vo_item();
                     vo.id = (_gridVec[i] as View_Grid).vo.id;
                     vo.Init_lib();
                     gridToIcon(vo,aimPoint,1000,Global.stage.stageWidth * 0.5,Global.stage.stageHeight * 0.5);
                  },500));
                  break;
               }
               i++;
            }
         }
      }
      
      public function removeShouChongBtn() : void
      {
         if(Boolean(this.addEff))
         {
            EffectManager.removeEffect(this.addEff);
         }
         if(Boolean(this.shouChongBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.shouChongBtn);
         }
      }
      
      private function shouChongOnClick(e:MouseEvent) : void
      {
         if(this.curStr == this.STR1)
         {
            if(!isLoaded)
            {
               this.visible = true;
            }
            else
            {
               this.visible = !visible;
            }
         }
         else if(this.curStr == this.STR2)
         {
            ActivityTopicPanel.index = this.id;
            ZhuTiZhouCGMessage.ZTZ_GETAWARD(this.id);
         }
      }
      
      public function getAward(lbId:int, time:int) : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCalculateTime);
         if(Boolean(this.addEff))
         {
            EffectManager.removeEffect(this.addEff);
         }
         this.isAvaibled = false;
         this.libaoXuhaoId = lbId;
         this.libaoTime = time;
         this.playEff();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = value;
            parent.addChildAt(this,parent.numChildren - 1);
            if(this._isFirstOpen)
            {
               this._isFirstOpen = false;
               if(!isLoaded)
               {
                  regResource("lang/ch/ZhuTiZhou_Img.swf","ZhuTiZhou_Imgsdm");
                  preFun();
               }
               else
               {
                  this.initUI2();
               }
            }
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onMoveTip);
         }
         else
         {
            super.visible = value;
            if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onMoveTip))
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onMoveTip);
            }
         }
      }
      
      public function initData(actArr:Array) : void
      {
         var i:int = 0;
         var grid:View_Grid = null;
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         var eff:int = 0;
         var viewGrid:View_Grid = null;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         this._titleDes = ComponentUtil.getTextField(actArr[0],this,{
            "size":20,
            "color":16770846
         });
         ComponentUtil.setPropertie(this._titleDes,{
            "x":(693 - this._titleDes.width) * 0.5,
            "y":70
         });
         this._titleDes.filters = [new GlowFilter(16777215,0.5,2,2,5)];
         var actDes:String = "活动期间内充值" + actArr[3] + "元宝即可领取奖励.";
         var yuanbao:MyTextField = ComponentUtil.getTextField(actDes,this,{
            "x":50,
            "y":365,
            "color":16776960
         });
         yuanbao.visible = false;
         var itemsArr:Array = actArr[4].split(",");
         var itemLen:int = int(itemsArr.length);
         var itemArr:Array = [];
         if(!this._gridVec.length)
         {
            i = 0;
            while(i < 6)
            {
               grid = new View_Grid(true);
               grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
               grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
               grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
               grid.set_tf_count(true,true,true);
               addChild(grid);
               this._gridVec.push(grid);
               ComponentUtil.setPropertie(grid,{
                  "x":112 + i * 80,
                  "y":146
               });
               i++;
            }
         }
         i = 0;
         while(i < itemLen)
         {
            itemArr = itemsArr[i].split("_");
            type = int(itemArr[0]);
            id = int(itemArr[1]);
            count = int(itemArr[2]);
            eff = int(itemArr[3]);
            viewGrid = this._gridVec[i];
            if(type == 1)
            {
               voI = new Vo_item();
               voI.id = id;
               voI.count = count;
               voI.Init_lib();
               viewGrid.vo = voI;
            }
            else if(type == 2)
            {
               voE = new Vo_equip();
               voE.id = id;
               voE.count = count;
               viewGrid.vo = voE;
            }
            if(Boolean(eff))
            {
               EffectManager.addEffect("35180",viewGrid,1000,32,32,true);
            }
            i++;
         }
      }
      
      public function updateData(arr:Array) : void
      {
         var type:int = 0;
         this.id = arr[0];
         ActivityTopicPanel.index = this.id;
         var flagIcon:int = int(arr[1]);
         if(Boolean(flagIcon))
         {
            type = int(arr[3]);
            if(type == 0)
            {
               this.showIcon(0);
               this.updateIconData(type,arr[2]);
            }
            else if(type == 1)
            {
               this.showIcon(1);
               this.updateIconData(type,arr[2]);
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function updateIconData(type:int, time:int) : void
      {
         this.times = Number(time);
         this.leftTime.text = this.getMSBySecond4(this.times);
         this.leftTime.x = (this.shouChongBtn.width - this.leftTime.width) * 0.5;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCalculateTime);
      }
      
      public function getMSBySecond4(second:Number, division:String = "天时分秒") : String
      {
         var h:int = 0;
         var hour:int = 0;
         var h1:int = 0;
         var m:int = 0;
         var min:int = 0;
         var m1:int = 0;
         var s:int = 0;
         var sec:int = 0;
         var result:String = "";
         var day:String = uint(second / (3600 * 24)) + "";
         if(int(day) >= 1)
         {
            result = day + "天";
            h = second % (3600 * 24);
            if(h == 0)
            {
               return result + "0时";
            }
            hour = int(h / 3600);
            result = result + hour + "时";
         }
         else
         {
            h1 = int(uint(second / 3600));
            if(h1 >= 1)
            {
               result = h1 + "时";
               m = int(second % 3600);
               if(m == 0)
               {
                  return result + "0分";
               }
               min = int(m / 60);
               result = result + min + "分";
            }
            else
            {
               m1 = int(second / 60);
               if(m1 >= 0)
               {
                  result = m1 + "分";
                  s = int(second % 60);
                  if(s == 0)
                  {
                     return result + "0秒";
                  }
                  sec = s;
                  result = result + s + "秒";
               }
            }
         }
         return result;
      }
      
      public function updateTime() : void
      {
         this.times -= 1;
         var timeStr:String = this.getMSBySecond4(this.times < 0 ? 0 : this.times);
         this.leftTime.text = timeStr;
         if(Boolean(this._timeLimitTF))
         {
            this._timeLimitTF.text = timeStr;
         }
         this.leftTime.x = (this.shouChongBtn.width - this.leftTime.width) * 0.5;
         if(this.times <= 0)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCalculateTime);
            this.setTextVis(0);
            this.visible = false;
            if(this.isAvaibled)
            {
               ZhuTiZhouCGMessage.ZTZ_GETAWARD(this.id);
            }
         }
      }
      
      public function changeIcon() : void
      {
         this.setTextVis(0);
         this.removeShouChongBtn();
         this.visible = false;
         this.showIcon(1);
         this.isAvaibled = true;
      }
      
      public function libaoIcon() : void
      {
         this.setTextVis(0);
         this.removeShouChongBtn();
         this.visible = false;
         this.showIcon(2);
      }
      
      public function setTextVis(type:int) : void
      {
         if(Boolean(this.leftTime))
         {
            if(type == 0)
            {
               this.leftTime.text = "";
               this.leftTime.visible = false;
            }
            else if(type == 1)
            {
               this.leftTime.visible = true;
            }
         }
      }
      
      private function onCalculateTime(interval:int) : void
      {
         var now:uint = uint(getTimer());
         if(now - this.lastTime > 1000)
         {
            this.updateTime();
            this.lastTime = now;
         }
      }
      
      private function onMoveTip(interval:int) : void
      {
         var now1:uint = uint(getTimer());
         if(now1 - this.lastTime1 > 500)
         {
            if(Boolean(this.tipBitmap))
            {
               if(this.tipBitmap.y == 35)
               {
                  Tween.to(this.tipBitmap,450,{"y":[this.tipBitmap.y,20]},function():void
                  {
                     Tween.stop(tipBitmap);
                  },null);
               }
               else if(this.tipBitmap.y == 20)
               {
                  Tween.to(this.tipBitmap,450,{"y":[this.tipBitmap.y,35]},function():void
                  {
                     Tween.stop(tipBitmap);
                  },null);
               }
            }
            this.lastTime1 = now1;
         }
      }
      
      public function gridToIcon(obj:Object, aimP:Point, totalTime:int = -1, sx:Number = 0, sy:Number = 0) : void
      {
         var aimPoint:Point;
         var param:Number;
         var py:Number;
         var point1:Point;
         var vo:Object = null;
         var p:Point = null;
         var dir:String = null;
         var bm:Bitmap = null;
         if(obj is View_Grid)
         {
            if(!obj.vo)
            {
               return;
            }
            vo = obj.vo;
            p = obj.localToGlobal(new Point(0,0));
            dir = "resource/image/icon/" + vo.str_icon + ".png";
         }
         if(obj is Vo_item)
         {
            vo = obj as Vo_item;
            p = new Point(sx,sy);
            dir = "resource/image/icon/" + vo.str_icon + ".png";
         }
         else if(obj is Vo_equip)
         {
            p = new Point(sx,sy);
            dir = "resource/image/icon/" + (obj as Vo_equip).str_icon + ".png";
         }
         else if(obj is String)
         {
            p = new Point(sx,sy);
            dir = "resource/image/icon/" + obj.toString() + ".png";
         }
         bm = new Bitmap();
         bm = Utils.getLoadBitmap(dir,bm);
         bm.x = p.x;
         bm.y = p.y;
         GameScene.popupLayer.addChild(bm);
         aimPoint = aimP;
         if(totalTime <= 0)
         {
            totalTime = Math.pow(Math.pow(aimPoint.y - p.y,2) + Math.pow(aimPoint.x - p.x,2),0.5) * 3.5;
         }
         param = 0.1;
         py = p.y + Math.abs(p.y - aimPoint.y) / 5;
         point1 = new Point(aimPoint.x,py);
         Tween.to(bm,totalTime,{
            "x":[bm.x,aimPoint.x],
            "y":[bm.y,aimPoint.y]
         },function():void
         {
            Tween.stop(bm);
            if(Boolean(bm.parent))
            {
               bm.parent.removeChild(bm);
            }
            if(Boolean(bm))
            {
               bm.bitmapData = null;
            }
         },null,Tween.EASYINOUT);
      }
   }
}

