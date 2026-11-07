package com.yiTian.view.modules.ZaHuoDian
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SMSCGMessage;
   import com.yiTian.net.message.cg.ZaHuoDianCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_buy_num extends Panel
   {
      
      private static var isLoad:Boolean = false;
      
      private static var isFirstOpen:Boolean = true;
      
      private var Button_Cancel:Button;
      
      private var Button_Buy:Button;
      
      private var Number_text:MyTextField;
      
      private var Money_text:MyTextField;
      
      private var bought_item:BoughtItem;
      
      private var _price:int;
      
      private var _gridId:int;
      
      private var _vo:Vo_grid;
      
      public var bought_type:int;
      
      public var maxNum:int;
      
      public var isLongWay:Boolean = false;
      
      public function View_buy_num()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":304,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":256,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":130,
            "y":111,
            "width":80,
            "height":20
         },Global.Img_Cdm);
         move = new Rectangle(0,0,246,38);
         ComponentUtil.getTextField(LangConfig.getWord("60395",6),this,{
            "x":65,
            "y":111,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60396",6),this,{
            "x":65,
            "y":136,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.Button_Buy = ComponentUtil.getButton(LangConfig.getWord("7",0),"Button_Four",this,{
            "x":60,
            "y":175,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("60037",6),"Button_Four",this,{
            "x":170,
            "y":175,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":270,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.bought_item = new BoughtItem();
         this.bought_item.x = 75;
         this.bought_item.y = 55;
         addChild(this.bought_item);
         this.Number_text = ComponentUtil.getTextField("1",this,{
            "x":140,
            "y":111,
            "color":14662240,
            "size":12,
            "leading":0,
            "realWidth":58
         });
         this.Money_text = ComponentUtil.getTextField("1",this,{
            "x":140,
            "y":136,
            "color":14662240,
            "size":12,
            "leading":0,
            "realWidth":55
         });
         this.Number_text.align = TextAlign.CENTER;
         this.Money_text.align = TextAlign.CENTER;
         this.Number_text.type = TextFieldType.INPUT;
         this.Number_text.restrict = ".0-9";
         this.Number_text.maxChars = 3;
         this.Number_text.addEventListener(Event.CHANGE,this.changedHanle);
         this.Button_Cancel.callBack = this.cliHandle;
         this.Button_Buy.addEventListener(MouseEvent.CLICK,this.boughthandle);
      }
      
      private function boughthandle(e:MouseEvent) : void
      {
         var temVo:Vo_valuable = null;
         if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < int(this.Money_text.text))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("8",0));
            return;
         }
         if(this.bought_type == 2)
         {
            if(GameUnitManager.hero.money < int(this.Number_text.text) * int(this.Money_text.text))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("9",0));
               return;
            }
            SMSCGMessage.CG_SMS_SHOP_BUY(this._gridId,int(this.Number_text.text));
            this.visible = false;
            return;
         }
         var can_use_grid:int = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
         if(this._vo is Vo_valuable)
         {
            temVo = this._vo as Vo_valuable;
            if(temVo is Vo_equip)
            {
               if(int(this.Number_text.text) > can_use_grid)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("10",0));
                  return;
               }
            }
            else if(can_use_grid < 1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10",0));
               return;
            }
         }
         if(this.isLongWay)
         {
            ZaHuoDianCGMessage.CG_ZAHUODIAN_BUY(52302,this._gridId,int(this.Number_text.text));
         }
         else
         {
            ZaHuoDianCGMessage.CG_ZAHUODIAN_BUY(Model_shop.get_shop_id,this._gridId,int(this.Number_text.text));
         }
         this.visible = false;
      }
      
      private function cliHandle(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.isLongWay = false;
         }
         else if(isFirstOpen)
         {
            isFirstOpen = false;
            if(!Global.NPC_Imgsdm)
            {
               SingleLoader.add("lang/ch/NPC_Imgs.swf",function(info:Object):void
               {
                  Global.NPC_Imgsdm = info.applicationDomain;
                  showBmp();
               });
            }
            else if(!isLoad)
            {
               this.showBmp();
            }
         }
      }
      
      private function showBmp() : void
      {
         ComponentUtil.getBitmap("Title_BuyNum",this,{
            "x":72,
            "y":5
         },Global.NPC_Imgsdm);
         isLoad = true;
      }
      
      private function changedHanle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(tf.text == "")
         {
            tf.text = "1";
         }
         if(int(tf.text) < 1)
         {
            tf.text = "1";
         }
         else if(int(tf.text) > 99)
         {
            tf.text = "99";
         }
         this.Money_text.text = String(int(tf.text) * this._price);
      }
      
      public function update(vo:Vo_grid, _pri:int, textColor:int, gri_id:int) : void
      {
         this.dispose();
         this.bought_item.update(vo,textColor);
         this._price = _pri;
         this._gridId = gri_id;
         this._vo = vo;
         this.Money_text.text = String(this._price);
         this.showQuestGuide();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function showQuestGuide() : void
      {
         if(this._vo.id != 46151)
         {
            return;
         }
         if(Model_quest.checkCurMainQStepType(Enum_quest_step_type.BUY_SKILL_BOOK))
         {
            QuestGuiManager.addKuang(this,this.Button_Buy.x - 5,this.Button_Buy.y - 5,this.Button_Buy.width + 10,this.Button_Buy.height + 10);
            QuestGuiManager.addJian(this,this.Button_Buy.x + this.Button_Buy.width,this.Button_Buy.y + this.Button_Buy.height / 2,180);
         }
      }
      
      public function dispose() : void
      {
         this.Number_text.text = "1";
         this.Money_text.text = "1";
         this.bought_item.grid.vo = null;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.data.model.Model_shop;
import com.yiTian.data.vo.Vo_grid;
import com.yiTian.manager.LangConfig;
import com.yiTian.view.comp.View_Grid;
import flash.display.Sprite;

class BoughtItem extends Sprite
{
   
   public var IconName_text:MyTextField;
   
   public var grid:View_Grid;
   
   public function BoughtItem()
   {
      super();
      this.IconName_text = ComponentUtil.getTextField(LangConfig.getWord("11",0),this,{
         "x":44.05,
         "y":2.2
      });
      this.grid = new View_Grid();
      this.grid.set_bmp_bg();
      this.grid.set_bmp_over();
      this.grid.set_bmp_select();
      this.grid.x = 3;
      this.grid.y = 2;
      addChild(this.grid);
   }
   
   public function update(vo:Vo_grid, textColor:int) : void
   {
      this.grid.vo = vo;
      this.IconName_text.text = vo.str_name;
      this.IconName_text.textColor = Model_shop.getColorArr[textColor - 1];
   }
}
