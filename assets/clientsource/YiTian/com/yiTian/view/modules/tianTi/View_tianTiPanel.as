package com.yiTian.view.modules.tianTi
{
   import Layout.GridGroup;
   import Layout.ILayout;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.DailyBtnManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TianTiCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.IMainUiBtn;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class View_tianTiPanel extends Panel123
   {
      
      public var tianTi:Child_tianTi;
      
      private var tfX:Number = 641;
      
      private var tfW:Number = 121;
      
      private var bg:ScaleBitmap;
      
      private var tf_curLv:MyTextField;
      
      private var tf_curPty:MyTextField;
      
      private var tf_mName:MyTextField;
      
      private var tf_needLv:MyTextField;
      
      private var rewardTfArr:Array;
      
      private var btn_refresh:Button;
      
      private var btn_cleanUp:Button;
      
      private var gridsGroup:ILayout;
      
      private var gridArr:Array = [];
      
      public var l1:Listt;
      
      public var l2:Listt;
      
      private var _imgBtn:BitmapBtn;
      
      private var lb:Bitmap = new Bitmap();
      
      private var tb:Bitmap = new Bitmap();
      
      public function View_tianTiPanel()
      {
         super();
         regResource("lang/ch/Challenge_Imgs.swf","Challenge_Imgsdm");
      }
      
      public function updateInfo(lv:int) : void
      {
         var str:String = null;
         var info:String = null;
         if(lv >= TianTiManager.maxLv || lv < 0)
         {
            info = LangConfig.getWord("21011",2);
            this.tf_curLv.text = info;
            this.tf_curPty.text = info;
            this.tf_mName.text = info;
            this.tf_needLv.text = info;
            this.updateReward(null);
            this.clearGrids();
            return;
         }
         var arr:Array = Data_lib.tianTi[lv + 1];
         var mId:int = int(arr[0]);
         var xf:int = int(arr[1]);
         var needLv:int = int(arr[2]);
         var curPty:String = arr[4];
         var rewardStrArr:Array = [];
         var mName:String = Data_lib.npc[mId][0];
         var yl:int = int(arr[6]);
         this.tf_curLv.text = LangConfig.getWord("21012",2,(lv + 1).toString());
         this.tf_curPty.text = curPty;
         this.tf_mName.text = mName;
         this.tf_needLv.text = needLv.toString();
         if(lv <= TianTiManager.maxLv && yl > 0)
         {
            if(rewardStrArr == null)
            {
               rewardStrArr = [];
            }
            str = lv + 1 > TianTiManager.maxLv ? "" : LangConfig.getWord("29203",2).replace("&va",yl.toString());
            rewardStrArr.unshift(Enum_BroadCastTool.instance.getColorStr(str,4));
         }
         if(lv <= TianTiManager.maxLv)
         {
            if(rewardStrArr == null)
            {
               rewardStrArr = [];
            }
            str = lv + 1 > TianTiManager.maxLv ? "" : HtmlUtil.fontNoSize(LangConfig.getWord("21052",2,Data_lib.tianTi[lv + 1][1]),ColorConstant.getColorStr(ColorConstant.GREEN));
            rewardStrArr.unshift(str);
         }
         if(lv >= TianTiManager.recordLv)
         {
            if(rewardStrArr == null)
            {
               rewardStrArr = [];
            }
            str = lv + 1 > TianTiManager.maxLv ? "" : HtmlUtil.fontNoSize(LangConfig.getWord("21054",2) + LangConfig.getWord("21052",2,Data_lib.tianTi[lv + 1][3]),ColorConstant.getColorStr(ColorConstant.GREEN));
            rewardStrArr.unshift(str);
         }
         this.updateReward(rewardStrArr);
         this.updateRndReward(lv);
      }
      
      private function rewardToStr(value:String) : Array
      {
         var tempArr:Array = null;
         var type:int = 0;
         var id:int = 0;
         if(value == "0")
         {
            return null;
         }
         var arr1:Array = new Array();
         arr1 = value.split(",");
         var result:Array = [];
         var i:int = 0;
         while(i < arr1.length)
         {
            tempArr = (arr1[i] as String).split("_");
            type = int(tempArr[0]);
            id = int(tempArr[1]);
            result.push(Enum_BroadCastTool.instance.getItemText(id));
            i += 1;
         }
         return result;
      }
      
      private function updateReward(arr:Array) : void
      {
         var tf:MyTextField = null;
         var len:int = 0;
         var i:int = 0;
         var ntf:MyTextField = null;
         if(arr == null)
         {
            for each(tf in this.rewardTfArr)
            {
               tf.text = "";
            }
         }
         else
         {
            len = Math.max(arr.length,this.rewardTfArr.length);
            i = 0;
            while(i < len)
            {
               if(!this.rewardTfArr[i])
               {
                  ntf = ComponentUtil.getTextField("",this,{
                     "x":this.tfX + 60,
                     "y":278 + i * 17,
                     "realWidth":this.tfW
                  });
                  this.rewardTfArr.push(ntf);
               }
               if(Boolean(arr[i]))
               {
                  this.rewardTfArr[i].htmlText = arr[i];
               }
               else
               {
                  this.rewardTfArr[i].text = "";
               }
               i += 1;
            }
         }
      }
      
      private function updateRndReward(lv:int) : void
      {
         var info:Array = null;
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         this.clearGrids();
         if(lv + 1 > TianTiManager.maxLv || Data_lib.tianTi[lv + 1][5] == "0")
         {
            return;
         }
         var infos:Array = Util.splicObj(Data_lib.tianTi[lv + 1][5] as String,",_") as Array;
         for each(info in infos)
         {
            grid = Pool.getObject(View_Grid);
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count(false);
            vo = Pool.getObject(Vo_item);
            vo.type = int(info[0]);
            vo.id = int(info[1]);
            vo.Init_lib();
            grid.vo = vo;
            this.gridsGroup.appendItem(grid);
            addChild(grid);
            this.gridArr.push(grid);
         }
         this.gridsGroup.align();
      }
      
      private function clearGrids() : void
      {
         var grid:View_Grid = null;
         for each(grid in this.gridArr)
         {
            removeChild(grid);
            grid.vo = null;
            Pool.saveObject(grid);
         }
         this.gridArr.splice(0);
         this.gridsGroup.clearItem();
      }
      
      override protected function initUI2() : void
      {
         var tf:MyTextField = null;
         var str:String = null;
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":830,
            "height":468
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":782,
            "height":420
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":31,
            "y":48,
            "width":604,
            "height":404
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":696,
            "y":275,
            "width":100,
            "height":80
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":696,
            "y":238,
            "width":100,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":696,
            "y":201,
            "width":100,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":696,
            "y":164,
            "width":100,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":696,
            "y":127,
            "width":100,
            "height":26
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":796,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tianTi = new Child_tianTi();
         this.tianTi.x = 33;
         this.tianTi.y = 50;
         addChild(this.tianTi);
         var titleArr:Array = [130,167,204,241,278,365];
         var idx:Array = [21001,21002,21003,21004,21005,29399];
         var i:int = 0;
         while(i < titleArr.length)
         {
            str = LangConfig.getWord(idx[i].toString(),2);
            tf = ComponentUtil.getTextField(str,this,{
               "x":this.tfX,
               "y":titleArr[i],
               "realWidth":this.tfW,
               "color":11904647
            });
            i += 1;
         }
         this.tf_curLv = ComponentUtil.getTextField("",this,{
            "x":this.tfX + 60,
            "y":titleArr[0],
            "color":14662240
         });
         this.tf_curPty = ComponentUtil.getTextField("",this,{
            "x":this.tfX + 60,
            "y":titleArr[1],
            "color":14662240
         });
         this.tf_mName = ComponentUtil.getTextField("",this,{
            "x":this.tfX + 60,
            "y":titleArr[2],
            "color":14662240
         });
         this.tf_needLv = ComponentUtil.getTextField("",this,{
            "x":this.tfX + 60,
            "y":titleArr[3],
            "color":14662240
         });
         this.btn_cleanUp = ComponentUtil.getButton(LangConfig.getWord("21017",2),"Button_Four",this,{
            "x":645,
            "y":420,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_refresh = ComponentUtil.getButton(LangConfig.getWord("21016",2),"Button_Four",this,{
            "x":725,
            "y":420,
            "textColor":16184781
         },Global.Img_Cdm);
         super.initDynamicView();
         this.rewardTfArr = [];
         this.btn_cleanUp.callBack = this.cleanUpClickHd;
         this.btn_refresh.callBack = this.refresh;
         this.btn_refresh.addEventListener(MouseEvent.MOUSE_MOVE,this.reMoveHd);
         this.btn_refresh.addEventListener(MouseEvent.ROLL_OUT,this.reOutHd);
         ComponentUtil.getBitmap("Text_TZZMR",this,{
            "x":672,
            "y":50
         },Global.Challenge_Imgsdm);
         ComponentUtil.getBitmap("Title_Challenge",this,{
            "x":335,
            "y":5
         },Global.Challenge_Imgsdm);
         this.gridsGroup = new GridGroup(697,362,0,0,0,48,0,48,2);
         this.l1 = new Listt();
         addChild(this.l1);
         ComponentUtil.setPropertie(this.l1,{
            "label":LangConfig.getWord("29400",2),
            "x":464,
            "y":288
         });
         this.l2 = new Listt();
         ComponentUtil.setPropertie(this.l2,{
            "label":LangConfig.getWord("29401",2),
            "x":464,
            "y":369
         });
         addChild(this.l2);
         this.tianTi.initNodesBM();
      }
      
      override protected function initStaticView() : void
      {
         TianTiManager.maxLv = Data_lib.tianTi["len"][0];
      }
      
      override protected function initDynamicView() : void
      {
         if(GameUnitManager.hero.level >= Enum_ZhangMenRen.needLv)
         {
            this.addTipBtn();
         }
      }
      
      private function cleanUpClickHd(evt:MouseEvent) : void
      {
         if(isTween || TianTiManager.player.isTween)
         {
            return;
         }
         if(TianTiManager.recordLv <= TianTiManager.curLv)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29187",2));
            return;
         }
         ModalUIManager.POPUP(ModalUIManager.ZMRCleanUp);
         ModalUIManager.ZMRCleanUp.updateDefault();
      }
      
      private function reMoveHd(evt:MouseEvent) : void
      {
         var str:String = null;
         var cost:int = 0;
         var times:int = TianTiManager.refreshTimes;
         if(times < 2)
         {
            cost = 100 * (1 + times);
            str = LangConfig.getWord("21006",2,times.toString(),cost.toString());
         }
         else
         {
            str = LangConfig.getWord("21007",2);
         }
         TipManager.update(str);
      }
      
      private function reOutHd(evt:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      private function heroLvUpHd(lv:int) : void
      {
         if(lv >= Enum_ZhangMenRen.needLv)
         {
            this.addTipBtn();
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.heroLvUpHd);
         }
      }
      
      public function addTipBtn() : IMainUiBtn
      {
         if(!this.imgBtn)
         {
            this._imgBtn = new BitmapBtn(true);
            this.imgBtn.setBgDir("resource/image/tianTi/zmrTip.png");
            UIManager.mainUiBtnContainer.addBTN(this.imgBtn);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.ZhangMenRen,1]);
            this.imgBtn.buttonMode = true;
            this.imgBtn.init(0,0,50,50);
            this.imgBtn.clickCallBack = this.imgBtnClickHd;
         }
         this.updateBtnCount(DailyBtnManager.getCount(DailyBtnManager.ZHANG_MEN_REN));
         return this.imgBtn;
      }
      
      public function updateBtnCount(count:int) : void
      {
         if(Boolean(this.imgBtn))
         {
            this.imgBtn.showTime(count);
         }
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.ZhangMenRen,count]);
      }
      
      private function imgBtnClickHd(evt:MouseEvent) : void
      {
         var pnl:View_tianTiPanel = null;
         pnl = UIManager.tianTiPanel;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            pnl.visible = !pnl.visible;
         });
      }
      
      private function refresh(evt:MouseEvent) : void
      {
         var times:int = 0;
         var cost:int = 0;
         var str:String = null;
         if(UIManager.tianTiPanel.isTween == true)
         {
            return;
         }
         if(TianTiManager.player == null || TianTiManager.player.isTween == true)
         {
            return;
         }
         times = TianTiManager.refreshTimes;
         if(times <= 1)
         {
            cost = (times + 1) * 100;
            str = LangConfig.getWord("21008",2,cost.toString());
            View_Alert.show(str,View_Alert.OK_CANCAL,function(e:MouseEvent):void
            {
               if(TianTiManager.curLv == 0)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("21009",2));
                  return;
               }
               if(GameUnitManager.hero.money < (times + 1) * 100)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("20241",2));
                  return;
               }
               TianTiManager.refreshCGFlag = true;
               TianTiCGMessage.CG_REFRESHTIANTI();
            });
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("21010",2));
         }
      }
      
      public function setNxtLv(index:int) : void
      {
         var dic:Dictionary = Data_lib.tianTi;
         var tname:String = dic[index][3];
         this.tf_mName.text = tname;
      }
      
      public function refreshIm(lv:int = 0, times:int = 0) : void
      {
         Tween.stop(TianTiManager.player);
         this.tianTi.stopIm();
         TianTiManager.curLv = lv;
         TianTiManager.refreshTimes = times;
         UIManager.tianTiPanel.tianTi.resetLayer();
         UIManager.tianTiPanel.updateInfo(lv);
         isTween = false;
         this.tianTi.isTween = false;
         TianTiManager.refreshCGFlag = false;
         TianTiManager.player.isTween = false;
         TianTiManager.player.state = 0;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            TianTiCGMessage.CG_TIANTI();
            TianTiManager.reqReward();
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
            this.showQuestGuide();
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
            this.l2.stop();
         }
         super.visible = value;
      }
      
      private function onFrame(interval:int) : void
      {
         Global.control.sendNotification(Enum_MsgType.TIANTI_FRAME,interval);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 830) / 2;
         y = (Global.stage.stageHeight - 465) / 2;
      }
      
      public function showQuestGuide() : void
      {
         if(Model_quest.checkCurMainQStepType(Enum_quest_step_type.ZHANGMENGREN))
         {
            QuestGuiManager.addKuang(null,350,310,78,32);
            QuestGuiManager.addJian(this,370,230,180);
         }
      }
      
      public function showCloseGuide() : void
      {
         QuestGuiManager.addKuang(this,CloseButton.x - 5,CloseButton.y - 5,CloseButton.width + 10,CloseButton.height + 10);
         QuestGuiManager.addJian(this,CloseButton.width + CloseButton.x + 3,CloseButton.height / 2 + CloseButton.y,180);
      }
      
      public function get imgBtn() : BitmapBtn
      {
         return this._imgBtn;
      }
   }
}

import Layout.HGroup;
import Layout.ILayout;
import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.utils.Tween;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;

class Listt extends Sprite
{
   
   private var btn:Button;
   
   private var tf_layout:ILayout;
   
   private var tfArr:Array;
   
   private var _data:Array = [];
   
   private var tf_con:Sprite;
   
   private var bm_btnIcon:Bitmap;
   
   private var c:Sprite = new Sprite();
   
   private var _choose:Boolean;
   
   private var rato:int = 3;
   
   private var _isPlay:Boolean = false;
   
   private var curDataArr:Array = [];
   
   public function Listt()
   {
      super();
      this.tf_con = new Sprite();
      addChild(this.tf_con);
      ComponentUtil.getBitmap("JLDin",this.c,{
         "x":0,
         "y":0
      },Global.Challenge_Imgsdm);
      this.tf_layout = new HGroup(8,4,0,0,0,36);
      this.tfArr = [];
      this.btn = ComponentUtil.getButton("","Button_vertical",this,{
         "x":147,
         "y":0,
         "textColor":16184781,
         "callBack":this.clickHd
      },Global.Img_Cdm);
      this.btn.labelTF.multiline = true;
      this.bm_btnIcon = new Bitmap();
      ComponentUtil.setPropertie(this.bm_btnIcon,{
         "x":7,
         "y":61
      });
      this.btn.addChild(this.bm_btnIcon);
      addChild(this.c);
      this.c.addChild(this.tf_con);
      var m:Shape = ComponentUtil.getShape(148,80,16711680,0.3);
      addChild(m);
      this.c.mask = m;
      this.choose = true;
   }
   
   public function set label(str:String) : void
   {
      this.btn.label = str;
      this.btn.LabelResize(4,3);
   }
   
   public function update(v:Array) : void
   {
      this._data = this._data.concat(v);
      if(this._data.length > 10)
      {
         this._data.splice(10);
      }
   }
   
   public function get data() : Array
   {
      return this._data;
   }
   
   private function clickHd(e:Event) : void
   {
      this.choose = !this.choose;
   }
   
   public function set choose(v:Boolean) : void
   {
      if(v)
      {
         Tween.to(this.c,600,{"x":[140,0]},null,null,this.tFun);
         this.bm_btnIcon.bitmapData = ComponentUtil.getBitmapData("Point_Right",Global.Img_Cdm);
      }
      else
      {
         this.bm_btnIcon.bitmapData = ComponentUtil.getBitmapData("Point_Left",Global.Img_Cdm);
         Tween.to(this.c,400,{"x":[0,140]},null,null,Tween.SIN);
      }
      this._choose = v;
   }
   
   private function tFun(p:Number) : Number
   {
      var rate:Number = p * 3.1416 * this.rato;
      return 1 - Math.sin(rate) / rate;
   }
   
   public function get choose() : Boolean
   {
      return this._choose;
   }
   
   public function goToAndPlay(f:int) : void
   {
      if(!this._isPlay)
      {
         this.tick();
      }
   }
   
   private function tick(o:Object = null) : void
   {
      var tips:String = null;
      if(!this._data.length)
      {
         this.stop();
      }
      else
      {
         tips = this._data.shift();
         while(this.curDataArr.length > 2)
         {
            this.curDataArr.shift();
         }
         this.curDataArr.push(tips);
         while(this.curDataArr.length < 3)
         {
            this.curDataArr.unshift("");
         }
         this.reRender(this.curDataArr);
         this.tf_con.y = 0;
         Tween.to(this.tf_con,1000,{"y":[this.tf_con.y,this.tf_con.y - 36]},this.tick,null,Tween.SIN);
      }
   }
   
   public function stop() : void
   {
   }
   
   public function reRender(infos:Array) : void
   {
      var str:String = null;
      var tf:MyTextField = null;
      this.clear();
      for each(str in infos)
      {
         tf = ComponentUtil.getTextField("",this,{
            "realWidth":140,
            "wordWrap":true,
            "color":14662240
         });
         tf.htmlText = str;
         this.tfArr.push(tf);
         this.tf_con.addChild(tf);
         this.tf_layout.appendItem(tf);
      }
      this.tf_layout.align();
   }
   
   private function clear() : void
   {
      var tf:MyTextField = null;
      for each(tf in this.tfArr)
      {
         this.tf_con.removeChild(tf);
         tf.dispose();
      }
      this.tf_layout.clearItem();
      this.tfArr.splice(0);
   }
}
