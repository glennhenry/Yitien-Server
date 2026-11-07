package com.yiTian.view.modules.activity.kaifuItem
{
   import com.ui.containers.Canvas;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.comp.View_Grid;
   
   public class Child_KaiFuGemReward extends Child_KaifuViewBase
   {
      
      private var _itemCanvas:Canvas;
      
      private var _items:Array = [];
      
      public function Child_KaiFuGemReward()
      {
         super();
         regResource("lang/ch/JCHD.swf","JCHDdm");
         regResource("resource/moduleConfig/kaifuModule/kaifuGemReward.xml","",2);
      }
      
      public static function get instance() : Child_KaiFuGemReward
      {
         return Singleton.getInstance(Child_KaiFuGemReward);
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var sellItem:GenItem = null;
         var ss:String = null;
         x = 155;
         y = 230;
         var itemSellInfoObj:XML = XML(getCfg(0));
         var xmlList:XMLList = itemSellInfoObj.item;
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":0,
            "y":0,
            "width":420,
            "height":255
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":1,
            "y":1,
            "width":418,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getTextField("宝石返利",this,{
            "x":175,
            "y":6,
            "color":16764206
         });
         i = 0;
         while(i < xmlList.length())
         {
            sellItem = new GenItem();
            ss = xmlList[i].awards;
            sellItem.setGridVos(Util.splicObj(ss,",_") as Array);
            sellItem.index = i + 1;
            sellItem.disRep = xmlList[i].discript;
            sellItem.tfTitle.htmlText = sellItem.disRep;
            sellItem.y = 30 + i * 44;
            addChild(sellItem);
            this._items.push(sellItem);
            i += 1;
         }
      }
      
      override public function show() : void
      {
         super.show();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(Model_KaiFuGem.MY_STATE_CHANGE,this.updateStates);
            Global.control.registerCallBack(Model_KaiFuGem.GET_KAI_FU_GEM_REWARD,this.rewardHandler);
            this.updateStates();
         }
         else
         {
            Global.control.removeCallBack(Model_KaiFuGem.PURCHAS_CHANGE,this.updateStates);
            Global.control.removeCallBack(Model_KaiFuGem.GET_KAI_FU_GEM_REWARD,this.rewardHandler);
         }
         this.setEffects(value);
         super.visible = value;
      }
      
      private function updateStates(info:* = null) : void
      {
         var states:Array = null;
         var counts:Array = null;
         var i:int = 0;
         var item:GenItem = null;
         if(Boolean(Model_KaiFuGem.myGemStates))
         {
            states = Model_KaiFuGem.myGemStates;
            counts = Model_KaiFuGem.myGemCounts;
            i = 0;
            while(i < states.length)
            {
               item = this._items[i];
               item.setState(states[i]);
               item.tfTitle.htmlText = LangConfig.reTxt(item.disRep,counts[i]);
               i += 1;
            }
         }
      }
      
      private function rewardHandler(info:Object) : void
      {
         var item:GenItem = null;
         var grid:View_Grid = null;
         if(info.moduleType == 2 && info.rest == 1)
         {
            if(Boolean(this._items[info.index - 1]))
            {
               item = this._items[info.index - 1];
               for each(grid in item.gridItems)
               {
                  ComboTweenStep.toBag(grid);
               }
            }
         }
      }
      
      public function setEffects(v:Boolean) : void
      {
         var item:GenItem = null;
         for each(item in this._items)
         {
            item.setEffect(v);
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.gameUnit.magic.Effect;
import com.yiTian.manager.CommandManager;
import com.yiTian.manager.EffectManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.KaiFuDiscountCGMessage;
import com.yiTian.utils.Bitmap2;
import com.yiTian.view.comp.View_Grid;
import flash.display.Sprite;
import flash.events.MouseEvent;

class GenItem extends Sprite
{
   
   public var tfTitle:MyTextField;
   
   public var gridItems:Array = [];
   
   public var btnGet:Button;
   
   public var index:int;
   
   public var disRep:String;
   
   public var finishBm:Bitmap2;
   
   private var _eff:Boolean = false;
   
   private var _effectArr:Array = [];
   
   public function GenItem()
   {
      super();
      this.tfTitle = ComponentUtil.getTextField("",this,{
         "x":20,
         "realWidth":160,
         "color":13424242,
         "wordWrap":true
      });
      this.tfTitle.multiline = true;
      this.tfTitle.leading = 4;
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":5,
         "y":38,
         "width":410,
         "height":2
      },Global.Img_Cdm);
      this.btnGet = ComponentUtil.getButton("不可领取","Button_Orange",this,{
         "x":335,
         "y":9,
         "textColor":16184781,
         "callBack":this.getRewardHandler
      },Global.Img_Cdm);
      this.btnGet.enabled = false;
   }
   
   public function setState(s:int) : void
   {
      if(s == 0)
      {
         this.btnGet.label = "未达条件";
         this.btnGet.enabled = false;
         this.btnGet.visible = true;
         if(Boolean(this.finishBm))
         {
            this.finishBm.load(null);
         }
      }
      if(s == 1)
      {
         this.btnGet.label = "可领取";
         this.btnGet.enabled = true;
         this.btnGet.visible = true;
         if(Boolean(this.finishBm))
         {
            this.finishBm.load(null);
         }
      }
      else if(s == 2)
      {
         this.btnGet.label = "已领取";
         this.btnGet.enabled = false;
         this.btnGet.visible = false;
         if(!this.finishBm)
         {
            this.finishBm = new Bitmap2();
            this.finishBm.x = this.btnGet.x;
            this.finishBm.y = this.btnGet.y - 12;
            addChild(this.finishBm);
         }
         this.finishBm.load("resource/image/tuanGou/yilingqu.png");
      }
   }
   
   public function setEffect(v:Boolean) : void
   {
      var grid:View_Grid = null;
      var eff:Effect = null;
      if(v)
      {
         if(!this._eff)
         {
            for each(grid in this.gridItems)
            {
               this._effectArr.push(EffectManager.addEffect("35176",grid,1200,17,18,true));
            }
         }
      }
      else
      {
         for each(eff in this._effectArr)
         {
            EffectManager.removeEffect(eff);
         }
      }
      this._eff = v;
   }
   
   public function setGridVos(vos:Array) : void
   {
      var i:int = 0;
      var grid:View_Grid = null;
      var id:int = 0;
      var num:int = 0;
      var vo:Vo_item = null;
      i = 0;
      while(i < vos.length)
      {
         grid = new View_Grid();
         id = int(vos[i][1]);
         num = int(vos[i][2]);
         grid.set_bmp_bg();
         grid.set_bmp_over(true,null);
         grid.set_tf_count(true,true,true);
         vo = new Vo_item();
         vo.id = id;
         vo.count = num;
         vo.Init_lib();
         grid.x = 195 + i * 42;
         grid.y = 2;
         grid.vo = vo;
         addChild(grid);
         this.gridItems.push(grid);
         i += 1;
      }
   }
   
   private function getRewardHandler(e:MouseEvent) : void
   {
      if(CommandManager.get_bag_canUse() > 1)
      {
         KaiFuDiscountCGMessage.CG_KAIFU_BUYGEM(this.index,1);
      }
      else
      {
         UIManager.centerBroadcast.addMsg("背包容量不足");
      }
   }
}
