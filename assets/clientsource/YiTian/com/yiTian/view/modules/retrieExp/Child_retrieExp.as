package com.yiTian.view.modules.retrieExp
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.RetrieExpCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_retrieExp extends Sprite
   {
      
      private var tf_type:MyTextField;
      
      private var tf_date:MyTextField;
      
      private var tf_level:MyTextField;
      
      private var tf_exp:MyTextField;
      
      private var btn_vipRetrie:Button;
      
      private var btn_goldRetrie:Button;
      
      private var icon:Bitmap;
      
      private var _vo:Object;
      
      public function Child_retrieExp()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.tf_type = ComponentUtil.getTextField("--",this,{
            "x":19,
            "y":8,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.tf_date = ComponentUtil.getTextField("",this,{
            "x":95,
            "y":14,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.tf_level = ComponentUtil.getTextField("",this,{
            "x":95,
            "y":40,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.tf_exp = ComponentUtil.getTextField("",this,{
            "x":95,
            "y":60,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.btn_vipRetrie = ComponentUtil.getButton(LangConfig.getWord("23431",2),"Button_Five",this,{
            "x":10,
            "y":88,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_vipRetrie.textColor = this.btn_vipRetrie.textOverColor = 13434624;
         this.btn_goldRetrie = ComponentUtil.getButton(LangConfig.getWord("23432",2),"Button_Five",this,{
            "x":130,
            "y":88,
            "textColor":6666344
         },Global.Img_Cdm);
         this.btn_goldRetrie.textColor = this.btn_goldRetrie.textOverColor = 8437092;
         this.btn_vipRetrie.callBack = this.vipRetrieClickHandle;
         this.btn_goldRetrie.callBack = this.goldRetrieClickHandle;
         this.icon = new Bitmap();
         this.icon.x = 10;
         this.icon.y = 24;
         addChild(this.icon);
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.lv30Handle);
         }
      }
      
      private function lv30Handle(level:int) : void
      {
         if(level >= 30)
         {
            if(visible == true && parent.visible == true)
            {
               RetrieExpCGMessage.CG_RETRIEEXP_INFO();
            }
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.lv30Handle);
         }
      }
      
      private function vipRetrieClickHandle(evt:MouseEvent) : void
      {
         switch(this._vo.type)
         {
            case Enum_retrieExp.LQ1:
            case Enum_retrieExp.LQ2:
            case Enum_retrieExp.LQ3:
            case Enum_retrieExp.PB1:
            case Enum_retrieExp.PB2:
            case Enum_retrieExp.PB3:
            case Enum_retrieExp.DAYILY:
               if(GameUnitManager.hero.vip > 0)
               {
                  (Singleton.getInstance(Delegate123) as Delegate123).dosomething(UIManager.retrieExpSubmit,function():void
                  {
                     UIManager.retrieExpSubmit.show(_vo,1);
                  });
                  break;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("23435",2));
               break;
            case Enum_retrieExp.TILI:
               if(GameUnitManager.hero.vip > 0)
               {
                  View_Alert.show(LangConfig.getWord("23433",2) + this._vo.moneyCost.toString(),View_Alert.OK_CANCAL,function(evt:MouseEvent):void
                  {
                     if(GameUnitManager.hero.money < _vo.moneyCost)
                     {
                        UIManager.centerBroadcast.addMsg(LangConfig.getWord("23434",2));
                     }
                     else
                     {
                        RetrieExpCGMessage.CG_RETRIEEXP1(_vo.type,0,0);
                     }
                  });
                  break;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("23435",2));
               break;
            default:
               if(GameUnitManager.hero.vip > 0)
               {
                  View_Alert.show(LangConfig.getWord("23433",2) + this._vo.moneyCost.toString(),View_Alert.OK_CANCAL,function(evt:MouseEvent):void
                  {
                     if(GameUnitManager.hero.money < _vo.moneyCost)
                     {
                        UIManager.centerBroadcast.addMsg(LangConfig.getWord("23434",2));
                     }
                     else
                     {
                        RetrieExpCGMessage.CG_RETRIEEXP1(_vo.type,_vo.date,0);
                     }
                  });
                  break;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("23435",2));
         }
      }
      
      private function goldRetrieClickHandle(evt:MouseEvent) : void
      {
         switch(this._vo.type)
         {
            case Enum_retrieExp.TILI:
               View_Alert.show(LangConfig.getWord("23436",2) + this._vo.silverCost.toString(),View_Alert.OK_CANCAL,function(evt:MouseEvent):void
               {
                  if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < _vo.silverCost)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("23437",2));
                  }
                  else
                  {
                     RetrieExpCGMessage.CG_RETRIEEXP2(_vo.type,0);
                  }
               });
               break;
            default:
               View_Alert.show(LangConfig.getWord("23436",2) + this._vo.silverCost.toString(),View_Alert.OK_CANCAL,function(evt:MouseEvent):void
               {
                  if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < _vo.silverCost)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("23437",2));
                  }
                  else
                  {
                     RetrieExpCGMessage.CG_RETRIEEXP2(_vo.type,_vo.date);
                  }
               });
         }
      }
      
      public function set vo(value:Object) : void
      {
         var date:Date = null;
         var dateStr:String = null;
         this._vo = value;
         if(this._vo == null)
         {
            visible = false;
            this.icon.bitmapData = null;
            this.tf_type.text = "";
            this.tf_date.text = "";
            this.tf_level.text = "";
            this.tf_exp.text = "";
            return;
         }
         this.icon = Utils.getLoadBitmap(Enum_retrieExp.IMAGEDIR[value.type],this.icon);
         this.tf_type.text = Enum_retrieExp.TXT[value.type];
         this.tf_exp.htmlText = HtmlUtil.font(LangConfig.getWord("23438",2),ColorConstant.getColorStr(ColorConstant.BLUE_LIGHT),12) + HtmlUtil.font(value.exp.toString(),ColorConstant.getColorStr(ColorConstant.RED),12);
         if(value.type == Enum_retrieExp.TILI)
         {
            this.tf_level.htmlText = HtmlUtil.font(LangConfig.getWord("23439",2),ColorConstant.getColorStr(ColorConstant.BLUE_LIGHT),12) + HtmlUtil.font(value.overflow.toString(),ColorConstant.getColorStr(ColorConstant.RED),12);
            this.tf_date.text = "";
         }
         else
         {
            date = new Date(value.date * 1000);
            this.tf_level.htmlText = HtmlUtil.font(LangConfig.getWord("23440",2),ColorConstant.getColorStr(ColorConstant.BLUE_LIGHT),12) + HtmlUtil.font(value.level.toString(),ColorConstant.getColorStr(ColorConstant.ORANGE),12);
            dateStr = LangConfig.getWord("29141",2,date.getUTCFullYear().toString(),(date.getUTCMonth() + 1).toString(),date.getDate().toString());
            this.tf_date.text = dateStr;
         }
         visible = true;
      }
   }
}

