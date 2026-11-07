package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.net.message.cg.HapStoneCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.hapStone.Model_hapStone;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class View_bangBuyPrompt extends Panel
   {
      
      private static var isLoad:Boolean = false;
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      private var Button_Max:Button;
      
      private var mm_text:MyTextField;
      
      private var _vo:Object;
      
      public var type:String = "banghui";
      
      public function View_bangBuyPrompt()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":160
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":110
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":153,
            "y":62,
            "width":80,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60020",6),this,{
            "x":55,
            "y":64,
            "color":11904647,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,248,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":274,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":60,
            "y":110,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this,{
            "x":180,
            "y":110,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Max = ComponentUtil.getButton("","Button_NumMax",this,{
            "x":235,
            "y":62,
            "textColor":16184781
         },Global.Img_Cdm);
         this.mm_text = ComponentUtil.getTextField("",this,{
            "x":186,
            "y":64,
            "color":14662240,
            "realWidth":40
         });
         this.mm_text.type = TextFieldType.INPUT;
         this.mm_text.maxChars = 2;
         this.mm_text.restrict = ".0-9";
         this.mm_text.addEventListener(Event.CHANGE,this.inputHandle);
      }
      
      private function inputHandle(evt:Event) : void
      {
         if(int(this.mm_text.text) == 0)
         {
            this.mm_text.text = "1";
         }
         if(int(this.mm_text.text) > this._vo.itemSellCount)
         {
            this.mm_text.text = this._vo.itemSellCount.toString();
         }
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.Button_OK.callBack = this.okClickHandle;
         this.Button_Cancel.callBack = this.cancelHandle;
         this.Button_Max.callBack = this.maxClickHandle;
      }
      
      private function okClickHandle(evt:MouseEvent) : void
      {
         var gong:int = 0;
         if(this.type == "banghui")
         {
            if(!Model_bang.partyInfo)
            {
               return;
            }
            gong = Model_bang.partyInfo.party_self_gong;
            if(gong < this._vo.itemPrice * int(this.mm_text.text))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29166",2));
               return;
            }
            BangCGMessage.CG_BUY_BANGSHOPITEM(this._vo.gridId,this._vo.itemId,int(this.mm_text.text));
            this.visible = false;
         }
         else
         {
            if(int(this.mm_text.text) * this._vo.jifen > Model_hapStone.nowScore)
            {
               UIManager.centerBroadcast.addMsg("积分不够");
               return;
            }
            View_Alert.show("是否花费" + int(this.mm_text.text) * this._vo.jifen + "钻石购买" + this._vo.name,View_Alert.OK_CANCAL,function():void
            {
               Model_hapStone.nowDHCount = int(mm_text.text);
               HapStoneCGMessage.CG_DUIHUAN_HAP(_vo.index,Model_hapStone.nowDHCount);
               cancelHandle();
            });
         }
      }
      
      private function cancelHandle(evt:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      private function maxClickHandle(evt:MouseEvent) : void
      {
         var canBuyCount:int = int(this._vo.itemSellCount);
         this.mm_text.text = canBuyCount.toString();
      }
      
      public function show(obj:Object) : void
      {
         if(Boolean(obj))
         {
            this.mm_text.text = "1";
            this._vo = obj;
            this.visible = true;
         }
         else
         {
            this.visible = false;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value == false)
         {
            this._vo = null;
         }
         else
         {
            Global.focus = this.mm_text;
            if(!Global.Bang_Imgsdm)
            {
               SingleLoader.add("lang/ch/Bang_Imgs.swf",function(info:Object):void
               {
                  Global.Bang_Imgsdm = info.applicationDomain;
                  showB();
               });
            }
            else if(!isLoad)
            {
               this.showB();
            }
         }
      }
      
      private function showB() : void
      {
         isLoad = true;
         ComponentUtil.getBitmap("Title_BuyPrompt",this,{
            "x":74,
            "y":5
         },Global.Bang_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

