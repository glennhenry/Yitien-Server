package com.yiTian.view.modules.newerGuide
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class QuestNewer extends Sprite
   {
      
      private static var isLoadSource:Boolean = false;
      
      public static var arr:Array = ["4","15","25","42","52","59","75"];
      
      public static var sourceTitle:Array = ["Icon_ChongWu","Icon_ShenGong","Icon_ZuoQi","Icon_JingMai","Icon_QiangHua","Icon_NeiGong","Icon_BangHui"];
      
      private var tf:MyTextField;
      
      private var progressBm:Bitmap;
      
      private var maskSpri:Sprite;
      
      private var iconBm:Bitmap;
      
      private var tempVal:int;
      
      private var tempStr:String;
      
      private var eff:Effect;
      
      public function QuestNewer()
      {
         super();
      }
      
      private function initB() : void
      {
         var sp:Sprite = null;
         if(isLoadSource)
         {
            return;
         }
         ComponentUtil.getBitmap("Back_YuGao",this,{
            "x":0,
            "y":0
         },Global.XSYinDaodm);
         sp = new Sprite();
         addChild(sp);
         sp.mouseEnabled = true;
         sp.buttonMode = true;
         sp.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            var _ar:Array = null;
            var pan:ChildNewerGuidePan = null;
            e.stopPropagation();
            _ar = tf.text.split("/");
            pan = Singleton.getInstance(ChildNewerGuidePan);
            pan.visible = !pan.visible;
            if(pan.visible)
            {
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
               {
                  pan.showPart(arr.indexOf(_ar[1]));
               });
            }
         });
         sp.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
            sp.transform.colorTransform = Util.colorGlow;
         });
         sp.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            sp.transform.colorTransform = Util.colorNomal;
         });
         TipManager.bind(sp,"点我就告诉你玩法。");
         ComponentUtil.setPropertie(sp,{
            "x":6,
            "y":7
         });
         this.iconBm = ComponentUtil.getBitmap("Icon_ChongWu",sp,null,Global.XSYinDaodm);
         ComponentUtil.getBitmap("BackProgress_YuGao",this,{
            "x":59,
            "y":30
         },Global.XSYinDaodm);
         this.progressBm = ComponentUtil.getBitmap("Progress_YuGao",this,{
            "x":59,
            "y":30
         },Global.XSYinDaodm);
         this.maskSpri = new Sprite();
         this.maskSpri.graphics.beginFill(0,0);
         this.maskSpri.graphics.drawRect(0,0,172,20);
         this.maskSpri.graphics.endFill();
         addChild(this.maskSpri);
         this.progressBm.mask = this.maskSpri;
         ComponentUtil.setPropertie(this.maskSpri,{
            "x":59,
            "y":30
         });
         this.tf = ComponentUtil.getTextField("00/00",this,{
            "x":128,
            "y":31,
            "color":15925095,
            "size":12,
            "leading":0
         });
         isLoadSource = true;
         this.update(this.tempVal,this.tempStr);
      }
      
      public function initSource() : void
      {
         if(!Global.XSYinDaodm)
         {
            SingleLoader.add("lang/ch/XSYinDao.swf",function(info:Object):void
            {
               Global.XSYinDaodm = info.applicationDomain;
               initB();
            });
         }
         else
         {
            this.initB();
         }
      }
      
      public function update(value:int, str:String) : void
      {
         var url:String = null;
         if(!isLoadSource)
         {
            this.tempVal = value;
            this.tempStr = str;
            this.initSource();
            return;
         }
         this.tf.text = str;
         var _ar:Array = str.split("/");
         var type:int = arr.indexOf(_ar[1]);
         if(type == -1)
         {
            return;
         }
         var baseJob:int = int(Enum_job.getBaseJob(GameUnitManager.hero.job));
         if(type == 1)
         {
            url = sourceTitle[type] + "0" + baseJob;
            this.iconBm.bitmapData = ComponentUtil.getBitmapData(url,Global.XSYinDaodm);
         }
         else
         {
            url = sourceTitle[type];
            this.iconBm.bitmapData = ComponentUtil.getBitmapData(url,Global.XSYinDaodm);
         }
         this.maskSpri.width = value;
         if(_ar[0] != "0")
         {
            if(!this.eff)
            {
               this.eff = EffectManager.addEffect("35172",this,600,72 - 5,228,true);
            }
            this.eff.alpha = 0.6;
            this.eff.px = this.maskSpri.x + this.maskSpri.width - 4;
            this.eff.py = this.maskSpri.y + 7.5;
         }
      }
   }
}

