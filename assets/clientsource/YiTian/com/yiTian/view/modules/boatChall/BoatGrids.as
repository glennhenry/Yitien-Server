package com.yiTian.view.modules.boatChall
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BoatGrids extends Panel123
   {
      
      private static const LEN:int = 5;
      
      private static const idArr:Array = [35350,35351,35349,35356,35354];
      
      private var itemVec:Vector.<InerItem> = new Vector.<InerItem>(4);
      
      public function BoatGrids()
      {
         super();
         regResource("lang/ch/FWLZ.swf","FWLZdm");
         GameScene.uiLayer.addChild(this);
      }
      
      public static function get instance() : BoatGrids
      {
         return Singleton.getInstance(BoatGrids);
      }
      
      override protected function initUI2() : void
      {
         var item:InerItem = null;
         ComponentUtil.getScaleBitmap("Back_JND",[18,18,1,1],this,{
            "x":0,
            "y":0,
            "width":366 - 72,
            "height":73
         },Global.FWLZdm);
         move = new Rectangle(0,0,366,73);
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            item = new InerItem();
            item.index = i + 1;
            item.id = idArr[i];
            item.init();
            addChild(item);
            ComponentUtil.setPropertie(item,{
               "x":10 + 72 * i,
               "y":3
            });
            this.itemVec[i] = item;
            i++;
         }
      }
      
      public function update(str:String) : void
      {
         var item:InerItem = null;
         var temp:Array = null;
         var arr:Array = str.split(",");
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            item = this.itemVec[i];
            temp = arr[i].split("_");
            item.showTime(temp[0],temp[1]);
            i++;
         }
      }
      
      public function getPointsByType(type:int) : Object
      {
         var obj:Object = new Object();
         if(type >= 4)
         {
            Utils.print("收到扬帆道具 作返回处理");
            return null;
         }
         var point:Point = localToGlobal(new Point(this.itemVec[type].x,this.itemVec[type].y));
         obj.disObj = this.itemVec[type];
         obj.point = point;
         return obj;
      }
      
      public function show() : void
      {
         visible = visible || true;
      }
      
      public function hide() : void
      {
         var item:InerItem = null;
         visible = visible && false;
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            item = this.itemVec[i];
            if(Boolean(item))
            {
               item.dispose();
            }
            i++;
         }
      }
      
      public function updateCD(index:int) : void
      {
         this.itemVec[index - 1].CD = 5;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 250) / 2 - 50;
         y = Global.stage.stageHeight - 250;
      }
   }
}

import com.ui.controls.CheckBox;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.TipManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.BoatCGMessage;
import com.yiTian.view.comp.View_Alert;
import com.yiTian.view.modules.newerGuide.thirdNewerGuide.BtnSpr;
import com.yiTian.view.modules.ship.Ship;
import flash.display.Bitmap;
import flash.events.MouseEvent;
import flash.text.TextFormatAlign;
import flash.utils.getTimer;
import flashx.textLayout.formats.TextAlign;

class InerItem extends BtnSpr
{
   
   private static const urlArr:Array = ["Icon_LJF","Icon_YL","Icon_JH","Icon_GSP","Icon_YF"];
   
   private static const nameArr:Array = ["龙卷风","鱼雷","净化","高射炮","扬帆"];
   
   private static const strArr:Array = ["释放后，己方龙舟后方出现龙卷风，经过龙卷风的玩家会方向错乱" + "<font color=\"#04ff00\">" + "5s" + "</font>" + "\n道具数量为" + "<font color=\"#04ff00\">" + "0" + "</font>" + "时，可以花费" + "<font color=\"#04ff00\">" + "20元宝" + "</font>" + "购买道具","释放后，对目标释放鱼雷，使目标龙舟停止前进" + "<font color=\"#04ff00\">" + "5s" + "</font>" + "\n道具数量为0时，可以花费" + "<font color=\"#04ff00\">" + "20元宝" + "</font>" + "购买道具","使用后，清除自身所有负面效果\n道具数量为" + "<font color=\"#04ff00\">" + "0" + "</font>" + "时，可以花费" + "<font color=\"#04ff00\">" + "20元宝" + "</font>" + "购买道具","对前十名随机一个目标使用，释放后使龙舟晕眩，持续" + "<font color=\"#04ff00\">" + "3s" + "</font>" + "\n道具数量为" + "<font color=\"#04ff00\">" + "0" + "</font>" + "时，可以花费" + "<font color=\"#04ff00\">" + "20元宝" + "</font>" + "购买道具","对自身使用，使用后，加速前进" + "<font color=\"#04ff00\">" + "5s" + "</font>" + "\n道具数量为" + "<font color=\"#04ff00\">" + "0" + "</font>" + "时，可以花费" + "<font color=\"#04ff00\">" + "20元宝" + "</font>" + "购买道具"];
   
   public var index:int;
   
   private var count:int;
   
   private var tipBm:Bitmap;
   
   private var tipTF:MyTextField;
   
   public var id:int;
   
   private var boatId:String = "";
   
   private var isShowCheckBox:Boolean;
   
   private var isCount:Boolean = false;
   
   private var counts:int;
   
   private var tfCount:MyTextField;
   
   private var lCountTime:int;
   
   public function InerItem()
   {
      super();
      addEventListener(MouseEvent.CLICK,this.clickEvent);
   }
   
   public function init() : void
   {
      ComponentUtil.getBitmap(urlArr[this.index - 1],this,{
         "x":0,
         "y":0
      },Global.FWLZdm);
      TipManager.bind(this,strArr[this.index - 1]);
      this.showTime(0,0);
   }
   
   public function showTime(id:int, time:int) : void
   {
      this.count = time;
      if(!this.tipBm)
      {
         this.tipBm = ComponentUtil.getBitmap("cishu_tis",this,{
            "x":2,
            "y":2
         },Global.New_Imgsdm);
         this.tipTF = ComponentUtil.getTextField("",this,{
            "size":11,
            "color":16771584,
            "x":this.tipBm.x + this.tipBm.width / 2 - 2.5,
            "y":5
         },"center");
      }
      this.tipBm.visible = true;
      this.tipTF.visible = true;
      this.tipTF.text = time + "";
   }
   
   private function clickEvent(e:MouseEvent = null) : void
   {
      var buy:Function;
      if(this.count < 1)
      {
         buy = function():void
         {
            if(GameUnitManager.hero.money < 20)
            {
               UIManager.centerBroadcast.addMsg("元宝不足",1);
               return;
            }
            BoatCGMessage.CG_SHIP_BUYPRO(id);
         };
         if(this.isShowCheckBox)
         {
            buy();
         }
         else
         {
            View_Alert.show("您确定要花费20元宝使用" + nameArr[this.index - 1] + "道具",View_Alert.OK_CANCAL,buy,null,null,null,310,"","",TextFormatAlign.LEFT,true);
            View_Alert.instance.showCheckBox = function(e:CheckBox):void
            {
               isShowCheckBox = e.selected;
            };
         }
         return;
      }
      if(this.id == 35351)
      {
         if(Boolean(Ship.nowSelectedShip) && Ship.nowSelectedShip != Ship.myShip)
         {
            BoatCGMessage.CG_BOAT_CLICKTOPROM(this.id,Ship.nowSelectedShip.idStr,Ship.nowSelectedShip.bangId,Ship.nowSelectedShip.quHao);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("您还没选择释放目标",1);
         }
      }
      else
      {
         BoatCGMessage.CG_BOAT_CLICKTOPROM(this.id,"",0,0);
      }
   }
   
   public function countTime(cnt:int) : void
   {
      mouseEnabled = false;
      if(!this.tfCount)
      {
         this.tfCount = ComponentUtil.getTextField("",this,{
            "x":0,
            "y":(this.height - 18) / 2 - 16,
            "realWidth":this.width,
            "realHeight":28,
            "align":TextAlign.CENTER,
            "size":20,
            "bold":true,
            "color":16383744
         });
      }
      this.tfCount.text = cnt.toString();
      this.tfCount.visible = true;
      this.counts = cnt;
      this.lCountTime = getTimer();
      if(!this.isCount)
      {
         this.isCount = true;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.run);
      }
   }
   
   private function run(intereval:int) : void
   {
      var now:int = getTimer();
      if(now - this.lCountTime >= 1000)
      {
         --this.counts;
         this.lCountTime = now;
         this.beginCount(this.counts);
         if(this.counts <= 0)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.run);
         }
      }
   }
   
   private function beginCount(index:int) : void
   {
      this.tfCount.text = index.toString();
      if(index <= 0)
      {
         this.tfCount.text = "";
         this.tfCount.visible = false;
         mouseEnabled = true;
         this.isCount = false;
         this.tfCount.visible = false;
      }
   }
   
   public function set CD(value:int) : void
   {
      if(value > 0)
      {
         this.countTime(value);
      }
   }
   
   public function dispose() : void
   {
      this.count = 0;
      this.tipTF.text = "0";
   }
}
