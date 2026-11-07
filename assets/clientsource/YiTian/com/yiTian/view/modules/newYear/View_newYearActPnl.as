package com.yiTian.view.modules.newYear
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.NewYearCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.chat.EffecObj;
   import com.yiTian.view.modules.treasureBowl.View_treasureBowl;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class View_newYearActPnl extends Panel123
   {
      
      private var _last:int;
      
      private var items:Array = [];
      
      private var btn_Store:Button;
      
      public var isInit:Boolean = false;
      
      private var _toIndex:int;
      
      public function View_newYearActPnl()
      {
         regResource("lang/ch/ChunJie_Imgs.swf","ChunJie_Imgsdm");
         super();
      }
      
      public function show() : void
      {
         visible = true;
         pop(0.7,0.1);
         this.showBtnLight(5000);
      }
      
      public function hide() : void
      {
         visible = false;
         this.hideBtnLight();
      }
      
      private function onStoreClick(e:MouseEvent) : void
      {
         var targetPnl:View_nianGaoSMailPnl = Singleton.getInstance(View_nianGaoSMailPnl);
         Global.delegate.dosomething(targetPnl,targetPnl.show);
      }
      
      private function closeClickHd(e:MouseEvent) : void
      {
         this.hide();
      }
      
      private function itemClickHd(e:MouseEvent) : void
      {
         var now:int = getTimer();
         if(now - this._last < 700)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29374",2));
            return;
         }
         this._last = now;
         if(e.target is ChooseItem)
         {
            return;
         }
         var target:ChooseItem = e.currentTarget as ChooseItem;
         switch(target.id)
         {
            case 1:
               NewYearCGMessage.CG_NIANSHOUDATA();
               break;
            case 2:
               Model_actDaily.getInstance().toFish();
               break;
            case 3:
               UIManager.sm_shop.visible = true;
               break;
            case 4:
               if(!UIManager.treasureBowlPanel)
               {
                  UIManager.treasureBowlPanel = new View_treasureBowl();
                  UIManager.treasureBowlPanel.init();
               }
               UIManager.treasureBowlPanel.visible = !UIManager.treasureBowlPanel.visible;
               break;
            case 5:
               UIManager.jjc_panel.visible = true;
         }
      }
      
      override protected function initUI2() : void
      {
         var arr:Array = null;
         var item:ChooseItem = null;
         this.isInit = true;
         ComponentUtil.getBitmap("Back_Img",this,{
            "x":0,
            "y":0
         },Global.ChunJie_Imgsdm);
         move = new Rectangle(0,20,width,height);
         ComponentUtil.getTextField(LangConfig.getWord("70026",7),this,{
            "x":406,
            "y":126
         });
         ComponentUtil.getButton("","Button_Close",this,{
            "x":676,
            "y":70,
            "callBack":this.closeClickHd
         },Global.ChunJie_Imgsdm);
         this.btn_Store = ComponentUtil.getButton("","Button_Store",this,{
            "x":170,
            "y":175,
            "callBack":this.onStoreClick
         },Global.ChunJie_Imgsdm);
         var btnPropertys:Array = [["HD01","Join_Img","Name01","NianShou_Img",{
            "x":347,
            "y":147,
            "id":1,
            "tip":LangConfig.getWord("70021",7)
         }],["HD02","Join_Img","Name02","Fish_Img",{
            "x":325,
            "y":222,
            "id":2,
            "tip":LangConfig.getWord("70022",7)
         }],["HD03","Join_Img","Name03","Gao_Img",{
            "x":304,
            "y":297,
            "id":3
         }],["HD04","Join_Img","Name04","JuBaoPen_Img",{
            "x":325,
            "y":372,
            "id":4,
            "tip":LangConfig.getWord("70023",7)
         }],["HD05","Join_Img","Name05","YongShi_Img",{
            "x":347,
            "y":447,
            "id":5,
            "tip":LangConfig.getWord("70024",7)
         }]];
         for each(arr in btnPropertys)
         {
            item = new ChooseItem(arr[0],arr[1],arr[2],arr[3]);
            ComponentUtil.setPropertie(item,arr[4]);
            addChild(item);
            item.addEventListener(MouseEvent.CLICK,this.itemClickHd);
            this.items.push(item);
         }
      }
      
      public function updateMiJingTimes() : void
      {
         var i:int = NewYearVO.SMSIndex;
         (this.items[2] as ChooseItem).tip = LangConfig.getWord("70025",7,i);
      }
      
      public function showBtnLight(duration:int) : void
      {
         if(this._toIndex != 0)
         {
            return;
         }
         EffecObj.getEffec(this.btn_Store);
         setTimeout(this.hideBtnLight,duration);
      }
      
      public function hideBtnLight() : void
      {
         EffecObj.removeEffect(this.btn_Store);
         if(this._toIndex != 0)
         {
            clearTimeout(this._toIndex);
            this._toIndex = 0;
         }
      }
   }
}

import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.manager.TipManager;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class ChooseItem extends Sprite
{
   
   private var bm_index:Bitmap;
   
   private var bm_title:Bitmap;
   
   private var bm_iconBg:Bitmap;
   
   private var bm_icon:Bitmap;
   
   private var _tipStr:Object;
   
   private var _bgLayer:Sprite;
   
   private var iconSp:Sprite;
   
   public var id:int;
   
   public function ChooseItem(dirIndex:String, dirBg:String, dirTitle:String, dirIcon:String)
   {
      super();
      this._bgLayer = new Sprite();
      addChild(this._bgLayer);
      this.bm_index = ComponentUtil.getBitmap(dirIndex,this,{
         "x":2,
         "y":15
      },Global.ChunJie_Imgsdm);
      this.bm_iconBg = ComponentUtil.getBitmap(dirBg,this._bgLayer,{
         "x":135,
         "y":28
      },Global.ChunJie_Imgsdm);
      this.bm_title = ComponentUtil.getBitmap(dirTitle,this._bgLayer,{
         "x":170,
         "y":4
      },Global.ChunJie_Imgsdm);
      this.iconSp = new Sprite();
      addChild(this.iconSp);
      ComponentUtil.getBitmap("Round",this.iconSp,{
         "x":99,
         "y":1
      },Global.ChunJie_Imgsdm);
      this.bm_icon = ComponentUtil.getBitmap(dirIcon,this.iconSp,{
         "x":111,
         "y":12
      },Global.ChunJie_Imgsdm);
      var _temp_1:* = this._bgLayer;
      this.iconSp.buttonMode = true;
      _temp_1.buttonMode = true;
      addEventListener(MouseEvent.MOUSE_OVER,this.onRollOverHd);
      addEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
      this.iconSp.addEventListener(MouseEvent.MOUSE_OVER,this.onRollOverHd);
      this.iconSp.addEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
   }
   
   public function set tip(v:Object) : void
   {
      this._tipStr = v;
      this.iconSp.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHd);
      this._bgLayer.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHd);
   }
   
   private function mouseMoveHd(e:MouseEvent) : void
   {
      TipManager.update(this._tipStr);
   }
   
   private function onRollOverHd(e:MouseEvent) : void
   {
      var sp:Sprite = e.target as Sprite;
      switch(sp)
      {
         case this:
            return;
         case this._bgLayer:
            this.bm_iconBg.transform.colorTransform = Util.colorWhite2;
            break;
         default:
            sp.transform.colorTransform = Util.colorWhite2;
      }
   }
   
   private function onRollOut(e:MouseEvent) : void
   {
      var sp:Sprite = e.target as Sprite;
      switch(sp)
      {
         case this:
            return;
         case this._bgLayer:
            this.bm_iconBg.transform.colorTransform = Util.colorNomal;
            TipManager.hide();
            break;
         default:
            sp.transform.colorTransform = Util.colorNomal;
            TipManager.hide();
      }
   }
}
