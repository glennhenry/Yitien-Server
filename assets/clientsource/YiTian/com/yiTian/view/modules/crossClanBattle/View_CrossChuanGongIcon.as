package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_CrossChuanGongIcon extends Panel
   {
      
      private static const MAX_NUM:int = 3;
      
      private static const GONGJI:String = "gongji";
      
      private static const GONGSHU:String = "gongshu";
      
      private static const SHANGHAIJIACHENG:String = "shanghaijiacheng";
      
      public var _tfChuanGong:MyTextField;
      
      private var nameArr:Array = [GONGJI,GONGSHU,SHANGHAIJIACHENG];
      
      private var urlArr:Array = ["Button_GJZY","Button_GSZY","Button_SHJC"];
      
      private var sprArr:Array = [];
      
      private var yuanbaoIcon:Sprite;
      
      private var yuanbaoBg:Sprite;
      
      private var bg:Sprite;
      
      private var moneyTxt:MyTextField;
      
      private var _isInit:Boolean = false;
      
      public function View_CrossChuanGongIcon()
      {
         var spr:Sprite = null;
         var i:int = 0;
         super();
         this.bg = new Sprite();
         addChild(this.bg);
         this.yuanbaoBg = new Sprite();
         addChild(this.yuanbaoBg);
         this.yuanbaoIcon = new Sprite();
         addChild(this.yuanbaoIcon);
         this.moneyTxt = ComponentUtil.getTextField("",this,{
            "x":335,
            "y":16,
            "color":9760866,
            "realWidth":96,
            "size":14,
            "bold":true,
            "align":TextAlign.CENTER
         });
         i = 0;
         while(i < MAX_NUM)
         {
            spr = new Sprite();
            spr.name = this.nameArr[i];
            spr.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            spr.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            spr.addEventListener(MouseEvent.CLICK,this.ClickHd);
            addChild(spr);
            spr.buttonMode = true;
            this.sprArr.push(spr);
            TipManager.bind(spr,Model_CrossClanBattle.roleBuffArr[i][Enum_CrossClanBattle.BUFF_TIP]);
            i++;
         }
      }
      
      public static function get instance() : View_CrossChuanGongIcon
      {
         return Singleton.getInstance(View_CrossChuanGongIcon);
      }
      
      public static function showAlert() : void
      {
         View_HelpTipPanel.instance.showIn();
      }
      
      public static function hide() : void
      {
      }
      
      public function updateMoneyTxt(value:String) : void
      {
         if(!this.moneyTxt)
         {
            return;
         }
         this.moneyTxt.htmlText = value;
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorWhite2;
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorNomal;
      }
      
      private function ClickHd(e:MouseEvent) : void
      {
         switch((e.currentTarget as Sprite).name)
         {
            case GONGJI:
               View_CrossChuanGongAlert.instance.show(0);
               break;
            case GONGSHU:
               View_CrossChuanGongAlert.instance.show(1);
               break;
            case SHANGHAIJIACHENG:
               View_CrossChuanGongAlert.instance.show(2);
         }
      }
      
      public function initDymic() : void
      {
         if(this._isInit)
         {
            return;
         }
         this._isInit = true;
         var patch:String = Enum_CrossClanBattle.SRCURL;
         var i:int = 0;
         while(i < MAX_NUM)
         {
            Utils.loadTitle(patch,this.urlArr[i],new Bitmap(),{
               "x":297 + 72 * i,
               "y":47
            },this.sprArr[i]);
            i++;
         }
         Utils.loadTitle(patch,"Back_TuKuang",new Bitmap(),{
            "x":290,
            "y":10
         },this.bg);
         Utils.loadTitle(patch,"Back_SZK",new Bitmap(),{
            "x":335,
            "y":18
         },this.yuanbaoBg);
         Utils.loadTitle(patch,"Text_YuanBao",new Bitmap(),{
            "x":295,
            "y":20
         },this.yuanbaoIcon);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.initDymic();
         }
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 600) / 2;
      }
   }
}

