package com.yiTian.view.modules.boatChall
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class P_enterGamePanel extends Panel123
   {
      
      public static var lastTime:int;
      
      private static var lTime:int;
      
      private static var _ask_to_enter:int;
      
      private static var isCounting:Boolean;
      
      private static var isRuning:Boolean = false;
      
      private var enterBtn:Button;
      
      private var inerVec:Vector.<Inter> = new Vector.<Inter>(4);
      
      private var iner2Vec:Vector.<Iner2> = new Vector.<Iner2>();
      
      private var containIner:Sprite = new Sprite();
      
      private var maskShp:Shape;
      
      private var nowIndex:int = 0;
      
      private var nn:int = 1;
      
      public function P_enterGamePanel()
      {
         super();
         regResource("lang/ch/FWLZ.swf","FWLZdm");
      }
      
      public static function get instance() : P_enterGamePanel
      {
         return Singleton.getInstance(P_enterGamePanel);
      }
      
      public static function set ask_to_enter(value:int) : void
      {
         _ask_to_enter = value;
         if(value > 0)
         {
            if(!isCounting)
            {
               Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,counting);
               isCounting = true;
            }
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,counting);
            isCounting = false;
         }
      }
      
      public static function get ask_to_enter() : int
      {
         return _ask_to_enter;
      }
      
      private static function counting(intereval:int) : void
      {
         var now:int = getTimer();
         if(now - lTime >= 1000)
         {
            lTime = now;
            --ask_to_enter;
         }
      }
      
      override protected function initUI2() : void
      {
         var inerItem:Inter = null;
         var iItem:Inter = null;
         var iner2Item:Iner2 = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":727,
            "height":490
         },Global.Img_Cdm);
         move = new Rectangle(0,0,727,36);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":677,
            "height":440
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":653,
            "height":416
         },Global.FWLZdm);
         ComponentUtil.getBitmap("Title_FWLZ",this,{
            "x":283,
            "y":5
         },Global.FWLZdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":692,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         addChild(this.containIner);
         ComponentUtil.setPropertie(this.containIner,{
            "x":44,
            "y":59
         });
         this.maskShp = ComponentUtil.getShape(640,406);
         ComponentUtil.setPropertie(this.maskShp,{
            "x":44,
            "y":59
         });
         this.containIner.mask = this.maskShp;
         addChild(this.maskShp);
         var i:int = 0;
         while(i < this.inerVec.length)
         {
            inerItem = new Inter();
            inerItem.show(i);
            this.containIner.addChild(inerItem);
            ComponentUtil.setPropertie(inerItem,{
               "x":i * 640,
               "y":0
            });
            this.inerVec[i] = inerItem;
            i++;
         }
         ComponentUtil.getBitmap("Back_FWLZD",this,{
            "x":47,
            "y":327
         },Global.FWLZdm);
         ComponentUtil.getButton("","Button_JCYB",this,{
            "x":300,
            "y":401,
            "textColor":16771436,
            "callBack":this.enterGame
         },Global.FWLZdm);
         ComponentUtil.getBitmap("Text_KSBS",this,{
            "x":327,
            "y":413
         },Global.FWLZdm);
         var j:int = 0;
         while(j < 4)
         {
            iItem = this.inerVec[j];
            iner2Item = new Iner2();
            iner2Item.bind(iItem);
            iner2Item.index = j;
            addChild(iner2Item);
            this.iner2Vec.push(iner2Item);
            ComponentUtil.setPropertie(iner2Item,{
               "x":313 + j * 20,
               "y":372
            });
            j++;
         }
         super.initDynamicView();
      }
      
      public function continueRun(index:int) : void
      {
         if(!isRuning)
         {
            isRuning = true;
            this.nowIndex = index;
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.run);
         }
      }
      
      private function run(intereval:int) : void
      {
         var now:int = getTimer();
         if(now - lastTime >= 2000)
         {
            if(this.nowIndex >= 3)
            {
               this.nn = -1;
            }
            else if(this.nowIndex <= 0)
            {
               this.nn = 1;
            }
            this.nowIndex += this.nn;
            this.iner2Vec[this.nowIndex].setChoose();
            lastTime = now;
         }
      }
      
      public function stopRun() : void
      {
         if(isRuning)
         {
            isRuning = false;
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.run);
         }
      }
      
      public function runto(bindObj:Inter) : void
      {
         Tween.to(this.containIner,600,{"x":[this.containIner.x,-(bindObj.x - 44)]});
      }
      
      public function show() : void
      {
         this.visible = visible || true;
         lastTime = getTimer();
         this.iner2Vec[0].setChoose();
         this.continueRun(0);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            isRuning = false;
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.run);
         }
      }
      
      private function enterGame(e:MouseEvent) : void
      {
         if(ask_to_enter > 0)
         {
            UIManager.centerBroadcast.addMsg("请稍等" + ask_to_enter + "秒后再进入",1);
            return;
         }
         if(GameUnitManager.hero.paoBiao != 0)
         {
            UIManager.centerBroadcast.addMsg("跑镖状态下不能进入龙舟地图",1);
            return;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("副本状态下不能进入龙舟地图",1);
            return;
         }
         if(Boolean(Model_team.isTeam[GameUnitManager.hero.id]))
         {
            UIManager.centerBroadcast.addMsg("组队状态下不能进入龙舟地图",1);
            return;
         }
         if(GameUnitManager.hero.level < 55)
         {
            UIManager.centerBroadcast.addMsg("您好，该系统要55级以上才开放哦",1);
            return;
         }
         CrossClanBattleCGMessage.CG_ENTER_BATTLE_SCENE("DragonBoatZID","boat");
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 640) / 2;
         y = (Global.stage.stageHeight - 400) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.view.modules.boatChall.P_enterGamePanel;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.utils.getTimer;

class Inter extends Sprite
{
   
   private static const arr:Array = ["Back_LZZD","Back_LZCY","Back_LZDJ","Back_LZJN"];
   
   private static var arrStr:Array = ["进入比赛场景，同一帮会的玩家可以组织龙舟比赛，每天龙舟最少6人才能参与比赛，最多乘坐12个人","玩家加入龙舟后自行分配在龙舟左排或者右排，左排乘员按“左拐弯”，则龙舟左拐弯30°，右排乘员按“右拐弯”则龙舟右拐弯30°","比赛航道上分布一些宝箱和灯笼，获得宝箱可以获得里面的宝藏；获得灯笼，可以随机获得“扬帆”、鱼雷、龙卷风、净化、高射炮道具的任意一个","玩家可以对别的龙舟释放获得的道具：龙卷风、鱼雷、净化、高射炮，来对他们造成伤害"];
   
   private var b1:Bitmap;
   
   private var b2:Bitmap;
   
   public function Inter()
   {
      super();
   }
   
   public function show(index:int) : void
   {
      ComponentUtil.getBitmap(arr[index],this,null,Global.FWLZdm);
      var tf:MyTextField = ComponentUtil.getTextField(arrStr[index],this,{
         "x":79,
         "y":273,
         "realWidth":515,
         "color":16776960,
         "size":14,
         "leading":4,
         "wordWrap":true,
         "multiline":true
      });
   }
}

class Iner2 extends Sprite
{
   
   private static var nowChooseI:Iner2;
   
   private var bindObj:Inter;
   
   public var index:int;
   
   private var b:Bitmap;
   
   private var _choose:Boolean;
   
   public function Iner2()
   {
      super();
      this.init();
   }
   
   private function init() : void
   {
      this.b = ComponentUtil.getBitmap("Icon_HuiDian",this,{
         "x":0,
         "y":0
      },Global.FWLZdm);
      addChild(this.b);
      addEventListener(MouseEvent.ROLL_OVER,this.overEvent);
      addEventListener(MouseEvent.ROLL_OUT,this.outEvent);
   }
   
   private function overEvent(e:MouseEvent) : void
   {
      this.setChoose();
      if(Boolean(parent))
      {
         (parent as P_enterGamePanel).stopRun();
      }
   }
   
   private function outEvent(e:MouseEvent) : void
   {
      P_enterGamePanel.lastTime = getTimer();
      if(Boolean(parent))
      {
         (parent as P_enterGamePanel).continueRun(nowChooseI.index);
      }
   }
   
   public function bind(obj:Inter) : void
   {
      this.bindObj = obj;
   }
   
   public function setChoose(e:* = null) : void
   {
      if(Boolean(nowChooseI))
      {
         nowChooseI.choose = false;
      }
      this.choose = true;
      nowChooseI = this;
      if(Boolean(parent))
      {
         (parent as P_enterGamePanel).runto(this.bindObj);
      }
   }
   
   public function set choose(value:Boolean) : void
   {
      this._choose = value;
      if(value)
      {
         this.b.bitmapData = ComponentUtil.getBitmapData("Icon_LvDian",Global.FWLZdm);
      }
      else
      {
         this.b.bitmapData = ComponentUtil.getBitmapData("Icon_HuiDian",Global.FWLZdm);
      }
   }
   
   public function get choose() : Boolean
   {
      return this._choose;
   }
}
