package com.yiTian.view.modules.HaiDiXunBao
{
   import com.ui.controls.Button;
   import com.ui.controls.MaskProgressBar2;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_HaiDiXunBao_panel extends Panel123
   {
      
      private static var _instance:View_HaiDiXunBao_panel;
      
      private var helpBtn:Button;
      
      private var getBtn:Button;
      
      private var progressBar:MaskProgressBar2;
      
      private var gridArr:Array;
      
      private var gridEffArray:Array = [];
      
      private const wayArray:Array = [1,1,3,3,3,3,5,5,5,5,7,7,7,7,1,1];
      
      private const startPoint:Point = new Point(200,181);
      
      private var nameTxtArr:Array;
      
      private var prizeTxtArr:Array;
      
      private var pointArr:Array;
      
      private var curMoney:int;
      
      private var totalMoney:int;
      
      private var _curTimes:int;
      
      private var timesBitmap:Bitmap;
      
      private var timesTxt:MyTextField;
      
      private var animationIsPlaying:Boolean;
      
      private var curPosition:int;
      
      private var steps:int;
      
      private var TouZiBitmapArraay:Array;
      
      private const c_v1:int = -10;
      
      private const c_v2:int = -13;
      
      private const c_v3:int = -15;
      
      private const g:int = 1;
      
      private var v1:int;
      
      private var v2:int;
      
      private var v3:int;
      
      private var completeFlag:int = 0;
      
      private var modelChild:Child_tianTiUnit;
      
      private var model:Sprite;
      
      private var modelName:MyTextField;
      
      private var extraStep:int;
      
      private var recordId:int;
      
      private var recordTimeOutId:uint;
      
      private var remain:int;
      
      private var to:int;
      
      public function View_HaiDiXunBao_panel()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/HDXB.swf","HDXBdm");
      }
      
      public static function get instance() : View_HaiDiXunBao_panel
      {
         if(!_instance)
         {
            _instance = new View_HaiDiXunBao_panel();
         }
         return _instance;
      }
      
      private function get curTimes() : int
      {
         return this._curTimes;
      }
      
      private function set curTimes(value:int) : void
      {
         this._curTimes = value;
         if(value > 0)
         {
            this.timesBitmap.visible = true;
            this.timesTxt.text = String(value);
         }
         else
         {
            this.timesBitmap.visible = false;
            this.timesTxt.text = "";
         }
         if(!this.animationIsPlaying)
         {
            if(value > 0)
            {
               this.getBtn.enabled = true;
            }
            else
            {
               this.getBtn.enabled = false;
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:* = undefined;
         super.visible = value;
         if(value)
         {
            if(Boolean(this.recordTimeOutId))
            {
               clearTimeout(this.recordTimeOutId);
               this.recordTimeOutId = 0;
            }
            for(i in this.nameTxtArr)
            {
               Tween.stop(this.nameTxtArr[i]);
               Tween.stop(this.prizeTxtArr[i]);
               this.nameTxtArr[i].y = 150;
               this.nameTxtArr[i].alpha = 0;
               this.prizeTxtArr[i].y = 150;
               this.prizeTxtArr[i].alpha = 0;
            }
            this.recordId = 0;
            this.recordTween();
         }
      }
      
      private function recordTween() : void
      {
         if(this.recordId < 5)
         {
            Tween.curTo(this.nameTxtArr[this.recordId],500,{
               "y":68 + 15 * this.recordId,
               "alpha":1
            });
            Tween.curTo(this.prizeTxtArr[this.recordId],500,{
               "y":68 + 15 * this.recordId,
               "alpha":1
            });
            ++this.recordId;
            this.recordTimeOutId = setTimeout(this.recordTween,500);
         }
      }
      
      override protected function initStaticView() : void
      {
         var j:int;
         var id:int;
         var i:int;
         var grid:View_Grid = null;
         var bm:Bitmap = null;
         useRotation3D = true;
         move = new Rectangle(0,0,874,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":874,
            "height":554
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":824,
            "height":504
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_HDXB",this,{
            "x":357,
            "y":5
         },Global.HDXBdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":839,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.helpBtn = ComponentUtil.getButton("","Button_Quest",this,{
            "x":815,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         TipManager.bind(this.helpBtn,HtmlUtil.font("海底寻宝规则<br/>",ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.font("1.活动期间，消费满足条件，即可获得寻宝次数1次，最多可抽取12次<br/>" + "2.点击寻宝按钮，即可投骰子寻宝。<br/>" + "3.投完骰子后，玩家移动到骰子上显示的点数的对应格子内，同时获得格子内的奖励。<br/>",ColorConstant.getColorStr(ColorConstant.YELLOW_SAND)));
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":800,
            "height":480
         },Global.HDXBdm);
         ComponentUtil.getBitmap("Back_HDXB",this,{
            "x":44,
            "y":59
         },Global.HDXBdm);
         this.progressBar = new MaskProgressBar2(ComponentUtil.getBitmap("Back_JDT",this,{
            "x":67,
            "y":41
         },Global.HDXBdm),ComponentUtil.getBitmap("Back_JDTD",this,{
            "x":0,
            "y":0
         },Global.HDXBdm));
         addChild(this.progressBar);
         this.progressBar.x = 737;
         this.progressBar.y = 521;
         this.progressBar.rotation = -90;
         this.progressBar.addEventListener(MouseEvent.ROLL_OVER,this.showMoney);
         this.progressBar.addEventListener(MouseEvent.ROLL_OUT,this.showMoney);
         this.getBtn = ComponentUtil.getButton("","Button_XunBao",this,{
            "x":752,
            "y":452,
            "textColor":16771436
         },Global.HDXBdm);
         this.getBtn.callBack = function():void
         {
            DailyActCGMessage.CG_HaiDiXunBao_GET();
         };
         this.getBtn.addEventListener(MouseEvent.ROLL_OVER,this.showMoney);
         this.getBtn.addEventListener(MouseEvent.ROLL_OUT,this.showMoney);
         this.timesBitmap = ComponentUtil.getBitmap("cishu_tis",this,{
            "x":803,
            "y":447
         },Global.New_Imgsdm);
         this.timesBitmap.visible = false;
         this.timesTxt = ComponentUtil.getTextField("",this,{
            "size":11,
            "color":16771584,
            "x":this.timesBitmap.x + this.timesBitmap.width / 2 - 1,
            "y":this.timesBitmap.y + 3
         },"center");
         this.gridArr = [];
         j = 0;
         while(j < 16)
         {
            grid = new View_Grid();
            grid.set_bmp_over(true,null);
            grid.set_tf_count();
            addChild(grid);
            this.gridArr.push(grid);
            j++;
         }
         this.gridArr[0].x = 306;
         this.gridArr[0].y = 177;
         this.gridArr[1].x = 374;
         this.gridArr[1].y = 145;
         this.gridArr[2].x = 491;
         this.gridArr[2].y = 141;
         this.gridArr[3].x = 563;
         this.gridArr[3].y = 177;
         this.gridArr[4].x = 635;
         this.gridArr[4].y = 215;
         this.gridArr[5].x = 703;
         this.gridArr[5].y = 251;
         this.gridArr[6].x = 691;
         this.gridArr[6].y = 312;
         this.gridArr[7].x = 623;
         this.gridArr[7].y = 347;
         this.gridArr[8].x = 555;
         this.gridArr[8].y = 380;
         this.gridArr[9].x = 488;
         this.gridArr[9].y = 414;
         this.gridArr[10].x = 372;
         this.gridArr[10].y = 412;
         this.gridArr[11].x = 302;
         this.gridArr[11].y = 378;
         this.gridArr[12].x = 236;
         this.gridArr[12].y = 343;
         this.gridArr[13].x = 162;
         this.gridArr[13].y = 307;
         this.gridArr[14].x = 169;
         this.gridArr[14].y = 248;
         this.gridArr[15].x = 242;
         this.gridArr[15].y = 211;
         this.TouZiBitmapArraay = [];
         id = 0;
         while(id < 3)
         {
            bm = ComponentUtil.getBitmap("S01",this,{
               "x":297 + id * 120,
               "y":262
            },Global.HDXBdm);
            bm.name = "TouZi" + (id + 1);
            this.TouZiBitmapArraay.push(bm);
            id++;
         }
         this.model = new Sprite();
         addChild(this.model);
         this.modelChild = new Child_tianTiUnit();
         this.modelChild.way = 3;
         this.modelChild.type = Child_tianTiUnit.PLAYER;
         this.modelChild.modelId = GameUnitManager.hero.body;
         this.modelChild.weaponDir = GameUnitManager.hero.weapon.toString();
         this.modelChild.state = Action.STAND;
         this.modelChild.job = GameUnitManager.hero.job;
         this.modelChild.sex = GameUnitManager.hero.sex;
         this.modelChild.setFrameInterval(150);
         this.modelChild.updateLayer();
         this.modelChild.scaleX = 0.5;
         this.modelChild.scaleY = 0.5;
         this.model.addChild(this.modelChild);
         this.modelName = ComponentUtil.getTextField(GameUnitManager.hero.name,this.model,{
            "x":0,
            "y":-this.model.height - 20,
            "size":14
         },"center");
         this.nameTxtArr = [];
         this.prizeTxtArr = [];
         i = 0;
         while(i < 5)
         {
            this.nameTxtArr.push(ComponentUtil.getTextField("",this,{
               "x":548,
               "y":150,
               "alpha":0,
               "color":16777215,
               "size":12,
               "leading":3
            }));
            this.prizeTxtArr.push(ComponentUtil.getTextField("",this,{
               "x":628,
               "y":150,
               "alpha":0,
               "color":16777215,
               "size":12,
               "leading":3
            }));
            i++;
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.modelChild.onFrame);
         Global.control.registerCallBack(Enum_HaiDiXunBao.OPEN,this.setPanel);
         Global.control.registerCallBack(Enum_HaiDiXunBao.SET_PRIZE_RECORD,this.setPrizeRecord);
         Global.control.registerCallBack(Enum_HaiDiXunBao.PLAY_ANIMATION,this.startRoll);
      }
      
      private function showMoney(e:MouseEvent) : void
      {
         if(e.type == MouseEvent.ROLL_OVER)
         {
            TipManager.update("累积消费元宝:" + this.curMoney + "/" + this.totalMoney);
         }
         else
         {
            TipManager.hide();
         }
      }
      
      private function setPanel(arr:Array) : void
      {
         var tableID:int = 0;
         var itemStr:Array = null;
         var vo:Vo_valuable = null;
         this.curMoney = arr[0];
         var i:int = 1;
         var len:int = int(Data_lib.HaiDiXunBaoEDu.getLength());
         while(i < len && this.curMoney >= Data_lib.HaiDiXunBaoEDu[i])
         {
            i++;
         }
         this.totalMoney = Data_lib.HaiDiXunBaoEDu[i];
         this.progressBar.persent = this.curMoney / this.totalMoney;
         this.curTimes = arr[1];
         if(!this.animationIsPlaying)
         {
            this.setPosition(arr[2]);
         }
         var j:int = 0;
         for(; j < 16; j++)
         {
            tableID = int(arr[3][j]);
            itemStr = Data_lib.HaiDiXunBao[tableID][0].split("_");
            if(itemStr[0] == 1)
            {
               vo = new Vo_item();
            }
            else
            {
               vo = new Vo_equip();
            }
            vo.id = itemStr[1];
            vo.count = itemStr[2];
            vo.Init_lib();
            vo.bgIndex = 0;
            this.gridArr[j].vo = vo;
            if(Data_lib.HaiDiXunBao[tableID][4] == 1)
            {
               if(!this.gridEffArray[j])
               {
                  this.gridEffArray[j] = EffectManager.addEffect("35180",this.gridArr[j],1000,42,42,true);
               }
               this.gridEffArray[j].scaleX = 0.5;
               this.gridEffArray[j].scaleY = 0.5;
            }
            else if(Boolean(this.gridEffArray[j]))
            {
               EffectManager.removeEffect(this.gridEffArray[j]);
            }
            if(int(arr[4][j]) != 1)
            {
               (this.gridArr[j] as DisplayObject).filters = Util.disabled;
               continue;
            }
            switch(vo.color)
            {
               case 2:
                  this.gridArr[j].filters = [new GlowFilter(65280,1,6,6,2)];
                  break;
               case 3:
                  this.gridArr[j].filters = [new GlowFilter(26367,1,6,6,2)];
                  break;
               case 4:
                  this.gridArr[j].filters = [new GlowFilter(6684876,1,6,6,2)];
                  break;
               case 5:
                  this.gridArr[j].filters = [new GlowFilter(16750848,1,6,6,2)];
            }
         }
      }
      
      private function setPrizeRecord(arr:Array) : void
      {
         var itemStrArr:Array = null;
         var i:int = 0;
         while(i < 5)
         {
            if(Boolean(arr[i * 3 + 1]))
            {
               itemStrArr = arr[i * 3 + 1].split("_");
               (this.nameTxtArr[i] as MyTextField).htmlText = Enum_job.getJobColorStr(arr[i * 3],arr[i * 3 + 2]);
               (this.prizeTxtArr[i] as MyTextField).htmlText = "寻宝获得了: " + Enum_BroadCastTool.instance.getItemText(itemStrArr[1],12) + "*" + itemStrArr[2];
            }
            else
            {
               this.nameTxtArr[i].text = "";
               this.prizeTxtArr[i].text = "";
            }
            i++;
         }
      }
      
      private function setPosition(pos:int) : void
      {
         this.curPosition = pos;
         if(pos == 0)
         {
            this.model.x = this.startPoint.x;
            this.model.y = this.startPoint.y;
            this.modelChild.way = 3;
         }
         else
         {
            this.model.x = this.gridArr[pos - 1].x + 20;
            this.model.y = this.gridArr[pos - 1].y + 20;
            this.modelChild.way = this.wayArray[pos - 1];
         }
      }
      
      private function startRoll(targetPosArr:Array) : void
      {
         if(!this.animationIsPlaying)
         {
            this.animationIsPlaying = true;
            this.getBtn.enabled = false;
            this.steps = targetPosArr[0] > this.curPosition ? int(targetPosArr[0] - this.curPosition) : int(targetPosArr[0] + 16 - this.curPosition);
            if(this.steps < 3)
            {
               this.steps += 16;
            }
            --this.curTimes;
            this.computePoint(this.steps);
            this.extraStep = targetPosArr[1];
            this.roll1();
         }
      }
      
      private function roll1() : void
      {
         var i:* = undefined;
         this.v1 = this.c_v1;
         this.v2 = this.c_v2;
         this.v3 = this.c_v3;
         this.completeFlag = 0;
         for(i in this.TouZiBitmapArraay)
         {
            this.TouZiBitmapArraay[i].addEventListener(Event.ENTER_FRAME,this.TouZiMove);
         }
      }
      
      private function TouZiMove(e:Event) : void
      {
         e.currentTarget.y += this["v" + (e.currentTarget.name as String).slice(-1)];
         if(e.currentTarget.y < 282)
         {
            e.currentTarget.bitmapData = ComponentUtil.getBitmapData("X" + String(Math.floor(Math.random() * 6) + 1),Global.HDXBdm);
            this["v" + (e.currentTarget.name as String).slice(-1)] = this["v" + (e.currentTarget.name as String).slice(-1)] + this.g;
         }
         else
         {
            ++this.completeFlag;
            e.currentTarget.y = 282;
            (e.currentTarget as Bitmap).bitmapData = ComponentUtil.getBitmapData("S0" + String(this.pointArr[int(e.currentTarget.name.slice(-1)) - 1]),Global.HDXBdm);
            e.currentTarget.removeEventListener(Event.ENTER_FRAME,this.TouZiMove);
            if(this.completeFlag == 3)
            {
               this.moveSteps();
            }
         }
      }
      
      private function moveSteps() : void
      {
         var nextPos:int = 0;
         var radian:Number = NaN;
         var angle:int = 0;
         if(this.steps > 0)
         {
            nextPos = this.curPosition + 1;
            if(nextPos > 16)
            {
               nextPos = 1;
            }
            if(this.curPosition > 0)
            {
               radian = Math.atan2(this.gridArr[nextPos - 1].y - this.gridArr[this.curPosition - 1].y,this.gridArr[nextPos - 1].x - this.gridArr[this.curPosition - 1].x);
            }
            else
            {
               radian = Math.atan2(this.gridArr[nextPos - 1].y - this.startPoint.y,this.gridArr[nextPos - 1].x - this.startPoint.x);
            }
            angle = radian * 180 / Math.PI;
            angle = angle < 0 ? int(angle + 360) : angle;
            this.modelChild.way = (angle + 90) / 45;
            --this.steps;
            ++this.curPosition;
            if(this.curPosition > 16)
            {
               this.curPosition = 1;
            }
            if(this.modelChild.state != Action.RUN)
            {
               this.modelChild.state = Action.RUN;
            }
            Tween.curTo(this.model,500,{
               "x":this.gridArr[nextPos - 1].x + 20,
               "y":this.gridArr[nextPos - 1].y + 20
            },this.moveSteps);
         }
         else
         {
            (this.gridArr[this.curPosition - 1] as DisplayObject).filters = Util.disabled;
            this.modelChild.state = Action.STAND;
            this.setPosition(this.curPosition);
            if(CommandManager.get_bag_canUse() - CommandManager.get_bag_used() > 0)
            {
               this.remain = this.gridArr[this.curPosition - 1].vo.count;
               this.remain = this.remain > 20 ? 20 : this.remain;
               this.t();
            }
            else
            {
               this.checkExtraSteps();
            }
            UIManager.centerBroadcast.addMsg("恭喜你获得了" + this.gridArr[this.curPosition - 1].vo.str_name + "*" + this.gridArr[this.curPosition - 1].vo.count,1);
         }
      }
      
      private function checkExtraSteps() : void
      {
         if(this.extraStep > 0)
         {
            this.steps = this.extraStep > this.curPosition ? int(this.extraStep - this.curPosition) : int(this.extraStep + 16 - this.curPosition);
            this.extraStep = 0;
            UIManager.centerBroadcast.addMsg("恭喜你获得额外大奖",1);
            this.moveSteps();
         }
         else
         {
            this.animationIsPlaying = false;
            if(this.curTimes > 0)
            {
               this.getBtn.enabled = true;
            }
         }
      }
      
      private function computePoint(point:int) : void
      {
         var n2:int = 0;
         var n3:int = 0;
         var t_arr:Array = [];
         var n1:int = 1;
         while(n1 < 7)
         {
            n2 = 1;
            while(n2 < 7)
            {
               n3 = 1;
               while(n3 < 7)
               {
                  if(n1 + n2 + n3 == point)
                  {
                     t_arr.push([n1,n2,n3]);
                  }
                  n3++;
               }
               n2++;
            }
            n1++;
         }
         this.pointArr = t_arr[Math.floor(Math.random() * t_arr.length)];
         Utils.print("点数:",point,"骰子:" + this.pointArr);
      }
      
      private function t() : void
      {
         if(this.to != 0)
         {
            clearTimeout(this.to);
         }
         if(this.remain > 0)
         {
            ComboTweenStep.toBag(this.gridArr[this.curPosition - 1]);
            --this.remain;
            this.to = setTimeout(this.t,200);
         }
         else
         {
            this.checkExtraSteps();
         }
      }
   }
}

