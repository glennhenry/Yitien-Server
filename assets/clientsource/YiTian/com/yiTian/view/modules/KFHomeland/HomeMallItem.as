package com.yiTian.view.modules.KFHomeland
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HomeMallItem extends Sprite
   {
      
      private var _nameTxt:MyTextField;
      
      private var _id:int;
      
      private var _status:int;
      
      private var _costTxt:MyTextField;
      
      private var _cost:int;
      
      private var _buyBtn:Button;
      
      private var _currBit:Bitmap;
      
      private var _colorBit:Bitmap;
      
      private var _newBit:Bitmap;
      
      private var _name:String;
      
      private var _index:int;
      
      private var _mallBit:Bitmap;
      
      private var _mallVo:Vo_HomeMall;
      
      public function HomeMallItem(t:int)
      {
         super();
         this._index = t + 1;
         this.init();
      }
      
      private function init() : void
      {
         var back:Bitmap = ComponentUtil.getBitmap("Back_WPD",this,{
            "x":3,
            "y":3
         },Global.KFJYdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":22,
            "y":30
         },Global.Img_Cdm);
         this._colorBit = new Bitmap();
         addChild(this._colorBit);
         this._mallBit = new Bitmap();
         addChild(this._mallBit);
         ComponentUtil.setPropertie(this._mallBit,{
            "x":22,
            "y":30
         });
         this._currBit = new Bitmap();
         addChild(this._currBit);
         ComponentUtil.setPropertie(this._currBit,{
            "x":88,
            "y":104
         });
         this._buyBtn = ComponentUtil.getButton(LangConfig.getWord("30202",3),"Button_JYAN",this,{
            "x":19,
            "y":134,
            "textColor":16771436
         },Global.KFJYdm);
         this._nameTxt = ComponentUtil.getTextField("",this,{
            "x":3 + back.width / 2,
            "y":7,
            "color":16764206,
            "size":12,
            "leading":0
         },"center");
         this._costTxt = ComponentUtil.getTextField("100000",this,{
            "x":23 + 63 / 2,
            "y":101,
            "color":52224,
            "size":12,
            "leading":0
         },"center");
         this._buyBtn.callBack = this.buyHandle;
         this._newBit = ComponentUtil.getBitmap("Icon_Xin",this,{
            "x":0,
            "y":0
         },Global.KFJYdm);
      }
      
      private function buyHandle(evt:MouseEvent) : void
      {
         View_Alert.show(LangConfig.getWord("30203",3,String(this._cost) + this._mallVo.nameCurrency,this._name),View_Alert.OK_CANCAL,function(vet:MouseEvent):void
         {
            HomeSpecialMall._curSucBoughtIndex = _index - 1;
            HomeSpecialMall._curSucBoughtPicStr = _mallVo.str_icon;
            HomeLandCGMessage.CG_BUY_MALL(_id,_index);
         });
      }
      
      public function update(id:int, isNew:int) : void
      {
         var vo:Vo_HomeMall = null;
         if(!this._newBit)
         {
            return;
         }
         if(Boolean(this._currBit))
         {
            this._currBit.bitmapData = null;
         }
         if(Boolean(this._mallBit))
         {
            this._mallBit.bitmapData = null;
         }
         this._id = id;
         vo = new Vo_HomeMall();
         vo.id = this._id;
         vo.Init_lib();
         vo.str_icon = "resource/image/kuafuHome/mall/" + this._id + ".png";
         this._mallVo = vo;
         this._cost = vo.cost;
         this._name = vo.str_name;
         this._costTxt.text = String(this._cost);
         this._nameTxt.htmlText = HtmlUtil.fontNoSize(this._name,vo.colorStr);
         Utils.getLoadBitmap("resource/image/iconBg60/" + vo.color + ".png",this._colorBit,{
            "x":23,
            "y":31
         });
         Utils.getLoadBitmap(vo.str_icon,this._mallBit,{
            "x":22,
            "y":30
         },this.refresh);
         this._currBit.bitmapData = ComponentUtil.getBitmapData(vo.picCurrency,Global.KFJYdm);
         TipManager.bind(this,vo.str_describe);
         if(isNew == 1)
         {
            this._newBit.visible = true;
         }
         else
         {
            this._newBit.visible = false;
         }
      }
      
      private function refresh() : void
      {
         Utils.getLoadBitmap(this._mallVo.str_icon,this._mallBit,{
            "x":22,
            "y":30
         });
      }
   }
}

