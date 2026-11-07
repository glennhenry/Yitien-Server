package com.yiTian.view.modules.activity.kaifuItem
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   
   public class Child_KaiFuGemDiscount extends Child_KaifuViewBase
   {
      
      public var arrSellItems:Array = [];
      
      public function Child_KaiFuGemDiscount()
      {
         super();
         regResource("lang/ch/JCHD.swf","JCHDdm");
         regResource("resource/moduleConfig/kaifuModule/kaifuGemDiscount.xml","",2);
      }
      
      public static function get instance() : Child_KaiFuGemDiscount
      {
         return Singleton.getInstance(Child_KaiFuGemDiscount);
      }
      
      override protected function initUI2() : void
      {
         var xmlList:XMLList = null;
         var i:int = 0;
         var currValue:int = 0;
         var fullValue:int = 0;
         var itemId:int = 0;
         var count:int = 0;
         var sellItem:GemItem = null;
         var vo:Vo_item = null;
         x = 155;
         y = 230;
         var itemSellInfoObj:XML = XML(getCfg(0));
         xmlList = itemSellInfoObj.item;
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
         ComponentUtil.getTextField("宝石打折",this,{
            "x":175,
            "y":6,
            "color":16764206
         });
         i = 0;
         while(i < xmlList.length())
         {
            currValue = int(xmlList[i].value);
            fullValue = int(xmlList[i].fullValue);
            itemId = int(xmlList[i].toolId);
            count = int(xmlList[i].num);
            sellItem = new GemItem();
            sellItem.perCost = currValue;
            sellItem.x = 4 + 207 * int(i % 2);
            sellItem.y = 30 + 111 * int(i / 2);
            sellItem.tfTitle.htmlText = Enum_BroadCastTool.instance.getItemText(itemId);
            vo = new Vo_item();
            vo.id = itemId;
            vo.count = count;
            vo.Init_lib();
            sellItem.gridItem.vo = vo;
            sellItem.tfFullValue.htmlText = LangConfig.reTxt("原价：<font color=\'#ffff33\'>{0}元宝</font>",fullValue);
            sellItem.tfCurrentValue.htmlText = LangConfig.reTxt("现价：<font color=\'#ffff33\'>{0}元宝</font>",currValue);
            sellItem.index = i + 1;
            ComponentUtil.getBitmap(xmlList[i].icon,sellItem,{
               "x":42,
               "y":26
            },Global.JCHDdm);
            addChild(sellItem);
            this.arrSellItems.push(sellItem);
            i += 1;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var sellItem:GemItem = null;
         if(value)
         {
            for each(sellItem in this.arrSellItems)
            {
               sellItem.reset();
            }
            Global.control.registerCallBack(Model_KaiFuGem.GET_KAI_FU_GEM_REWARD,this.rewardHandler);
         }
         else
         {
            Global.control.removeCallBack(Model_KaiFuGem.GET_KAI_FU_GEM_REWARD,this.rewardHandler);
         }
         super.visible = value;
      }
      
      private function rewardHandler(info:Object) : void
      {
         var sellItem:GemItem = null;
         if(info.moduleType == 1 && info.rest == 1)
         {
            sellItem = this.arrSellItems[info.index - 1];
            if(sellItem != null)
            {
               ComboTweenStep.toBag(sellItem.gridItem);
            }
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.manager.CommandManager;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.KaiFuDiscountCGMessage;
import com.yiTian.view.comp.View_Alert;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextFieldType;

class GemItem extends Sprite
{
   
   public var tfTitle:MyTextField;
   
   public var gridItem:View_Grid;
   
   public var tfFullValue:MyTextField;
   
   public var tfCurrentValue:MyTextField;
   
   public var btnUp:Button;
   
   public var btnDown:Button;
   
   public var tfNumberBuy:MyTextField;
   
   public var btnBuy:Button;
   
   public var index:int;
   
   public var perCost:int;
   
   public var numBuy:int = 1;
   
   public function GemItem()
   {
      super();
      ComponentUtil.getBitmap("Back_BSQH",this,{
         "x":0,
         "y":0
      },Global.JCHDdm);
      this.tfTitle = ComponentUtil.getTextField("礼包中文名称",this,{
         "x":65,
         "y":1,
         "color":16742144,
         "size":12,
         "leading":0
      });
      this.tfFullValue = ComponentUtil.getTextField("",this,{
         "x":97,
         "y":33,
         "color":13225871,
         "size":12,
         "leading":4
      });
      this.tfCurrentValue = ComponentUtil.getTextField("",this,{
         "x":97,
         "y":53,
         "color":13225871,
         "size":12,
         "leading":4
      });
      ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
         "x":97,
         "y":76,
         "width":46,
         "height":24
      },Global.Img_Cdm);
      this.btnDown = ComponentUtil.getButton("","Button_Ndown",this,{
         "x":123,
         "y":88,
         "textColor":16771436,
         "callBack":this.downClickHandler
      },Global.JCHDdm);
      this.btnBuy = ComponentUtil.getButton("购买","Button_Buy",this,{
         "x":143,
         "y":75,
         "textColor":16771436,
         "callBack":this.buyClickHandler
      },Global.JCHDdm);
      this.btnUp = ComponentUtil.getButton("","Button_Nup",this,{
         "x":123,
         "y":77,
         "textColor":16771436,
         "callBack":this.upClickHandler
      },Global.JCHDdm);
      ComponentUtil.getBitmap("Line_YuanJia",this,{
         "x":134,
         "y":37
      },Global.JCHDdm);
      this.tfNumberBuy = ComponentUtil.getTextField("1",this,{
         "x":101,
         "y":79,
         "color":16777215,
         "size":12,
         "leading":0
      });
      this.tfNumberBuy.type = TextFieldType.INPUT;
      this.tfNumberBuy.restrict = "0-9";
      this.tfNumberBuy.maxChars = 3;
      this.tfNumberBuy.addEventListener(Event.CHANGE,this.tfNumChangeHandler);
      this.gridItem = new View_Grid(true);
      this.gridItem.x = 13;
      this.gridItem.y = 34;
      this.gridItem.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
      this.gridItem.set_bmp_over(true,null);
      addChild(this.gridItem);
      this.gridItem.addEventListener(MouseEvent.CLICK,this.gridClickHandler);
   }
   
   public function tfNumChangeHandler(e:Event) : void
   {
      var num:int = int(uint(this.tfNumberBuy.text));
      this.setBuyNum(num);
   }
   
   public function reset() : void
   {
      this.numBuy = 1;
      this.setBuyNum(this.numBuy);
   }
   
   private function setBuyNum(v:int) : void
   {
      v = Math.max(1,Math.min(99,v));
      this.tfNumberBuy.text = v.toString();
      this.numBuy = v;
   }
   
   private function upClickHandler(e:MouseEvent) : void
   {
      this.setBuyNum(this.numBuy + 1);
   }
   
   private function downClickHandler(e:MouseEvent) : void
   {
      this.setBuyNum(this.numBuy - 1);
   }
   
   private function buyClickHandler(e:MouseEvent) : void
   {
      this.buy(this.numBuy);
   }
   
   private function gridClickHandler(e:MouseEvent) : void
   {
      this.buy(1);
   }
   
   private function buy(num:int) : void
   {
      var cost:int = 0;
      var rep:String = "<font color=\'#ffffff\'>您将花费<font color=\'#ffff33\'>{0}元宝</font>来购买<font color=\'#ffff33\'>{1}个</font>{2}</font>";
      cost = this.perCost * num;
      View_Alert.show(LangConfig.reTxt(rep,cost,num,Enum_BroadCastTool.instance.getItemText(this.gridItem.vo.id)),View_Alert.OK_CANCAL,function():void
      {
         if(GameUnitManager.hero.money < cost)
         {
            UIManager.centerBroadcast.addMsg("元宝不足，请及时充值");
            return;
         }
         if(CommandManager.get_bag_canUse() < 1)
         {
            UIManager.centerBroadcast.addMsg("背包容量不足，请清理背包");
            return;
         }
         KaiFuDiscountCGMessage.CG_BUY_KAIFU_DISCOUNTITEM(index,num);
      });
   }
}
