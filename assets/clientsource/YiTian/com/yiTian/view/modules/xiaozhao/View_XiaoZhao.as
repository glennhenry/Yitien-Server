package com.yiTian.view.modules.xiaozhao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_XiaoZhao;
   import com.yiTian.data.model.Model_XiaoZhao;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.XiaoZhaoCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.View_Cost_TipWin;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_XiaoZhao extends Panel123
   {
      
      public static var isTweening:Boolean;
      
      private static var instance:View_XiaoZhao;
      
      private static const NUM_CARD:int = 10;
      
      private var refBtn:Button;
      
      private var cardArr:Vector.<Child_XiaoZhao_Card> = new Vector.<Child_XiaoZhao_Card>();
      
      private var cardContiner:Sprite;
      
      private var ward:XZWardPanel;
      
      private var propTxt:MyTextField;
      
      private var xipaiBtn:Button;
      
      private var czBtn:Button;
      
      private var flag:int = 0;
      
      private var pool:Array = [];
      
      private var tempPool:Array = [];
      
      public function View_XiaoZhao()
      {
         super();
         regResource("lang/ch/XZJZ.swf","XZJZdm");
      }
      
      public static function getInstance() : View_XiaoZhao
      {
         if(!instance)
         {
            instance = new View_XiaoZhao();
         }
         return instance;
      }
      
      override protected function initUI2() : void
      {
         var des:Button;
         var cd:Child_XiaoZhao_Card = null;
         var i:int = 0;
         var openHelp:Function = null;
         openHelp = function():void
         {
            View_XiaoZhaoDesWin.getInstance().visible = !View_XiaoZhaoDesWin.getInstance().visible;
         };
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":888,
            "height":530
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":839,
            "height":480
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_XZJZ",this,{
            "x":37,
            "y":52
         },Global.XZJZdm);
         this.czBtn = ComponentUtil.getButton("洗 牌","Button_XiPai",this,{
            "x":483,
            "y":421,
            "textColor":16771436,
            "callBack":this.onXiPaiHandle
         },Global.XZJZdm);
         this.czBtn.labelTF.align = "center";
         this.czBtn.labelTF.bold = true;
         this.czBtn.labelTF.size = 22;
         this.czBtn.labelSize = 22;
         ComponentUtil.getBitmap("Title_XZJZ",this,{
            "x":363,
            "y":5
         },Global.XZJZdm);
         ComponentUtil.getBitmap("Text_BLJL",this,{
            "x":103,
            "y":327
         },Global.XZJZdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":55,
            "y":353
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":97,
            "y":353
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":139,
            "y":353
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":181,
            "y":353
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":55,
            "y":393
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":97,
            "y":393
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":139,
            "y":393
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":181,
            "y":393
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":55,
            "y":433
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":97,
            "y":433
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":853,
            "y":6,
            "textColor":16771436,
            "callBack":this.onClose
         },Global.Img_Cdm);
         ComponentUtil.getTextField("(洗牌后所有的卡牌变为反面而且位置随机变化)",this,{
            "x":416,
            "y":469,
            "color":16764206,
            "size":12,
            "leading":0
         });
         des = ComponentUtil.getButton("","Button_WFSM",this,{
            "x":95,
            "y":478,
            "textColor":16771436,
            "callBack":openHelp
         },Global.XZJZdm);
         TipManager.bind(des,"点击查看玩法");
         move = new Rectangle(0,0,780,36);
         this.ward = new XZWardPanel();
         ComponentUtil.setPropertie(this.ward,{
            "x":58,
            "y":358
         });
         this.addChild(this.ward);
         this.cardContiner = new Sprite();
         this.cardContiner.x = 254;
         this.cardContiner.y = 80;
         this.addChild(this.cardContiner);
         i = 0;
         while(i < NUM_CARD)
         {
            cd = new Child_XiaoZhao_Card();
            cd.x = i % 5 * 116;
            cd.y = int(i / 5) * 166;
            cd.index = i;
            this.cardContiner.addChild(cd);
            this.cardArr.push(cd);
            i++;
         }
      }
      
      private function onClose(evt:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function onXiPaiHandle(evt:MouseEvent) : void
      {
         if(isTweening)
         {
            UIManager.centerBroadcast.addMsg("动画尚未播放完！");
            return;
         }
         if(Model_XiaoZhao.STATE_XIPAI == Enum_XiaoZhao.STATE_XIPAI)
         {
            XiaoZhaoCGMessage.CG_XIAOZHAO_REFRESH(Model_XiaoZhao.STATE_XIPAI);
            return;
         }
         View_Cost_TipWin.show("xiaozhaoxipai","是否花费" + Enum_XiaoZhao.XPCOST + "元宝" + Enum_XiaoZhao.BTNLABEL1[Model_XiaoZhao.STATE_XIPAI] + "?",function():void
         {
            if(GameUnitManager.hero.money >= Enum_XiaoZhao.XPCOST)
            {
               XiaoZhaoCGMessage.CG_XIAOZHAO_REFRESH(Model_XiaoZhao.STATE_XIPAI);
            }
            else
            {
               UIManager.centerBroadcast.addMsg("您的元宝不足,请先充值");
            }
         });
      }
      
      public function setData() : void
      {
         var cd:Child_XiaoZhao_Card = null;
         var vo:XiaoZhao_CardVO = null;
         var state:int = 0;
         this.czBtn.label = Enum_XiaoZhao.BTNLABEL[Model_XiaoZhao.STATE_XIPAI];
         this.ward.setData();
         var i:int = 0;
         while(i < NUM_CARD)
         {
            cd = this.cardArr[i];
            vo = Model_XiaoZhao.questArr[cd.index];
            state = vo.state;
            if(Model_XiaoZhao.STATE_XIPAI == Enum_XiaoZhao.STATE_XIPAI)
            {
               cd.setData(Enum_XiaoZhao.STATE_GET,Model_XiaoZhao.show_Awards[Enum_XiaoZhao.randomIndex() - 1]);
            }
            else if(Model_XiaoZhao.STATE_XIPAI == Enum_XiaoZhao.STATE_NXP)
            {
               cd.setData(Enum_XiaoZhao.STATE_GET,Model_XiaoZhao.getWardById(vo.propIndex));
            }
            else if(state == Enum_XiaoZhao.STATE_GET && Model_XiaoZhao.STATE_XIPAI == Enum_XiaoZhao.STATE_CZ)
            {
               cd.setData(state,Model_XiaoZhao.getWardById(vo.propIndex));
            }
            else
            {
               cd.setData(state);
            }
            i++;
         }
         if(Model_XiaoZhao.isEnd())
         {
            this.enterNext();
         }
      }
      
      private function enterNext() : void
      {
         if(this.flag != 0)
         {
            clearTimeout(this.flag);
            this.flag = 0;
         }
         this.flag = setTimeout(function():void
         {
            isTweening = true;
            XiaoZhaoCGMessage.CG_XIAOZHAO_REFRESH(Model_XiaoZhao.STATE_XIPAI);
            czBtn.enabled = true;
         },1500);
         this.czBtn.enabled = false;
      }
      
      public function reset() : void
      {
         var cd:Child_XiaoZhao_Card = null;
         var i:int = 0;
         while(i < NUM_CARD)
         {
            cd = this.cardArr[i];
            cd.reset();
            i++;
         }
      }
      
      public function mvController() : void
      {
         var effBm:Bitmap = null;
         var i:int = 0;
         var count:int = 0;
         var effBmComplete:Function = null;
         var flag:int = 0;
         var p:Point = null;
         var p1:Point = null;
         effBmComplete = function(bmp:Bitmap):void
         {
            ++count;
            if(count == NUM_CARD)
            {
               clear();
            }
         };
         var clear:Function = function():void
         {
            var b:Bitmap = null;
            while(tempPool.length > 0)
            {
               b = tempPool.shift();
               b.bitmapData = null;
               pool.push(b);
               b.parent.removeChild(b);
            }
            if(Model_XiaoZhao.STATE_XIPAI == Enum_XiaoZhao.STATE_CZ)
            {
               reset();
            }
            Tween.to(cardContiner,500,{"alpha":[0,1]},function():void
            {
               isTweening = false;
               cardContiner.mouseChildren = true;
            });
         };
         isTweening = true;
         var effBmd:BitmapData = this.cardArr[i].bgBmp;
         this.cardContiner.alpha = 0;
         this.cardContiner.mouseChildren = false;
         i = 0;
         while(i < NUM_CARD)
         {
            effBm = Boolean(this.pool.length) ? this.pool.shift() : new Bitmap();
            effBm.bitmapData = effBmd;
            p = new Point(this.cardArr[i].x + 254,this.cardArr[i].y + 80);
            p1 = new Point(473,120);
            effBm.x = p.x;
            effBm.y = p.y;
            Tween.to(effBm,1000,{
               "x":[p.x,p1.x],
               "y":[p.y,p1.y]
            },effBmComplete);
            this.addChild(effBm);
            this.tempPool.push(effBm);
            i++;
         }
         count = 0;
         flag = int(setTimeout(function():void
         {
            clearTimeout(flag);
            cardContiner.mouseChildren = true;
         },1000));
      }
      
      public function updataPropNum() : void
      {
         var num:int = CommandManager.get_bag_count(Enum_XiaoZhao.PROPID);
      }
      
      public function set cardState(index:int) : void
      {
         var cd:Child_XiaoZhao_Card = null;
         var state:int = 0;
         var can_use_grid:int = 0;
         var isFly:Boolean = false;
         var i:int = 0;
         while(i < NUM_CARD)
         {
            cd = this.cardArr[i];
            if(cd.index == Model_XiaoZhao.curIndex)
            {
               state = int(Model_XiaoZhao.questArr[Model_XiaoZhao.curIndex]);
               can_use_grid = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
               isFly = can_use_grid != 0;
               cd.setData(state,Model_XiaoZhao.getWardById(index),isFly);
               break;
            }
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(isTweening == true)
         {
            UIManager.centerBroadcast.addMsg("请播放完动画后再操作!");
            return;
         }
         super.visible = value;
         if(value)
         {
            XiaoZhaoCGMessage.CG_XIAOZHAO_OPEN_WIN();
            this.updataPropNum();
         }
      }
   }
}

import com.yiTian.data.Enum_type_grid;
import com.yiTian.data.config.Enum_XiaoZhao;
import com.yiTian.data.model.Model_XiaoZhao;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.xiaozhao.XiaoZhao_PropVO;
import flash.display.Sprite;

class XZWardPanel extends Sprite
{
   
   private static const ROW:int = 4;
   
   private static const W:int = 42;
   
   private static const H:int = 40;
   
   private var girdVec:Vector.<View_Grid> = new Vector.<View_Grid>();
   
   private var vo:XiaoZhao_PropVO;
   
   public function XZWardPanel()
   {
      super();
   }
   
   public function setData() : void
   {
      var i:int = 0;
      var grid:View_Grid = null;
      var item:Vo_item = null;
      var data:Array = Model_XiaoZhao.show_Awards;
      if(Boolean(this.girdVec.length))
      {
         this.updata(data);
         return;
      }
      i = 0;
      while(i < data.length)
      {
         this.vo = data[i];
         grid = new View_Grid();
         item = new Vo_item();
         item.id = this.vo.propId;
         item.count = this.vo.count;
         item.Init_lib();
         grid.vo = item;
         grid.type = Enum_type_grid.NO_DRAG;
         grid.set_bmp_bg(null);
         grid.set_bmp_over(true,null);
         grid.set_tf_count(true,true,true);
         grid.x = i % ROW * W;
         grid.y = int(i / ROW) * H;
         this.addChild(grid);
         this.girdVec.push(grid);
         i++;
      }
   }
   
   private function updata(data:Array = null) : void
   {
      var grid:View_Grid = null;
      var item:Vo_item = null;
      var i:int = 0;
      while(i < data.length)
      {
         this.vo = data[Enum_XiaoZhao.randomIndex1() - 1];
         grid = this.girdVec[i];
         item = new Vo_item();
         item.id = this.vo.propId;
         item.count = this.vo.count;
         item.Init_lib();
         grid.vo = item;
         grid.type = Enum_type_grid.NO_DRAG;
         grid.set_bmp_bg(null);
         grid.set_bmp_over(true,null);
         grid.set_tf_count(true,true,true);
         i++;
      }
   }
}
