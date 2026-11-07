package com.yiTian.view.modules.KFHomeland
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SkinItem extends Sprite
   {
      
      private var _skinBit:Bitmap;
      
      private var _tips:String;
      
      private var _nameTxt:MyTextField;
      
      private var _name:String;
      
      private var _useTime:int;
      
      private var _timeTipsTxt:MyTextField;
      
      private var useBtn:Button;
      
      public var _sId:int;
      
      private var _sNum:int;
      
      private var _thisSkinFo:InfoItemBuildings;
      
      public var _sysLevel:int;
      
      private var color:int;
      
      public function SkinItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         ComponentUtil.getBitmap("Back_DBPF",this,{
            "x":0,
            "y":0
         },Global.KFJYdm);
         this._skinBit = new Bitmap();
         addChild(this._skinBit);
         ComponentUtil.setPropertie(this._skinBit,{
            "x":0,
            "y":0
         });
         ComponentUtil.getBitmap("Back_PFMC",this,{
            "x":0,
            "y":107
         },Global.KFJYdm);
         this.useBtn = ComponentUtil.getButton(LangConfig.getWord("30216",3),"Button_TwoBule91",this,{
            "x":102,
            "y":136,
            "textColor":16771436
         },Global.Img_Cdm);
         this.useBtn.callBack = this.useHandle;
         this._nameTxt = ComponentUtil.getTextField("梦幻皮肤·外",this,{
            "x":1,
            "y":106,
            "color":16777011,
            "size":12,
            "leading":0
         });
         this._timeTipsTxt = ComponentUtil.getTextField("（时效7天）",this,{
            "x":1,
            "y":122,
            "color":16777011,
            "size":12,
            "leading":0
         });
      }
      
      private function useHandle(evt:MouseEvent) : void
      {
         switch(Button(evt.target).label)
         {
            case LangConfig.getWord("30216",3):
               this.buySkin();
               break;
            case LangConfig.getWord("30217",3):
               this.useSkin();
         }
      }
      
      private function buySkin() : void
      {
         if(this._useTime > 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30177",3));
            return;
         }
         View_Alert.show(LangConfig.getWord("30234",3,this._name),View_Alert.OK_CANCAL,function(evt:MouseEvent):void
         {
            if(VoHome.homeMoney < 10000)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30176",3));
            }
            else
            {
               HomeLandCGMessage.CG_BUY_SKIN(_sId);
            }
         });
      }
      
      private function useSkin() : void
      {
         if(this._useTime <= 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30180",3));
            return;
         }
         HomeLandCGMessage.CG_USE_SKIN(this._sId);
      }
      
      public function update(infObj:InfoItemBuildings) : void
      {
         if(!infObj)
         {
            this.visible = false;
            return;
         }
         if(Boolean(this._skinBit))
         {
            this._skinBit.bitmapData = null;
         }
         this._thisSkinFo = infObj;
         this.visible = true;
         this._sId = infObj.id;
         this._useTime = infObj.leftTime;
         this._tips = infObj.localDataArr[Enum_SortBuildins.DESC_ATT];
         TipManager.bind(this,this._tips);
         this._name = "" + infObj.localDataArr[Enum_SortBuildins.NAME_ATT];
         this._nameTxt.text = this._name;
         Utils.getLoadBitmap("resource/image/kuafuHome/sortBuild/" + this._sId + ".png",this._skinBit,{
            "x":0,
            "y":0
         },this.refresh);
         if(this._sId == 14131 || this._sId == 14132)
         {
            this.useBtn.label = LangConfig.getWord("30217",3);
            this._useTime = 1;
            this._timeTipsTxt.text = "(永久有效)";
            return;
         }
         if(this._useTime > 0)
         {
            this.useBtn.label = LangConfig.getWord("30217",3);
            this._timeTipsTxt.text = "（时效" + this.getLeftTimeDesc(this._useTime) + "）";
         }
         else
         {
            this.useBtn.label = LangConfig.getWord("30216",3);
            this._timeTipsTxt.text = "（时效7天）";
         }
      }
      
      private function refresh() : void
      {
         Utils.getLoadBitmap("resource/image/kuafuHome/sortBuild/" + this._sId + ".png",this._skinBit,{
            "x":0,
            "y":0
         });
      }
      
      public function updateBtnLabel() : void
      {
         this.useBtn.label = LangConfig.getWord("30217",3);
         this._useTime = this._thisSkinFo.localDataArr[Enum_SortBuildins.TIME_USE];
         this._timeTipsTxt.text = "（时效" + this.getLeftTimeDesc(this._useTime) + "）";
      }
      
      private function getLeftTimeDesc(_time:int) : String
      {
         var hour:int = 0;
         var result:String = "";
         var day:String = uint(_time / (3600 * 24)) + "";
         if(int(day) >= 1)
         {
            result = day + "天";
         }
         var h:int = _time % (3600 * 24);
         if(h == 0)
         {
            result += "0 时";
         }
         else
         {
            hour = int(h / 3600);
            result += hour + "时";
         }
         return result;
      }
   }
}

