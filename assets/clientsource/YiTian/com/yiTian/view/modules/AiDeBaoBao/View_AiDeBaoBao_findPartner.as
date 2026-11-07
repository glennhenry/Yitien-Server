package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_AiDeBaoBao;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class View_AiDeBaoBao_findPartner extends Panel
   {
      
      private static var _instance:View_AiDeBaoBao_findPartner;
      
      private var findBtn:Button;
      
      private var _partner:Number;
      
      private var txt:MyTextField;
      
      private var status:int;
      
      private var countDownTxt:MyTextField;
      
      private var beginTime:int;
      
      private var _totalTime:int;
      
      private var curTime:int;
      
      private var arrowEffectArray:Array;
      
      private var isFirstOpen:Boolean = true;
      
      public function View_AiDeBaoBao_findPartner()
      {
         super();
         super.init();
      }
      
      public static function get instance() : View_AiDeBaoBao_findPartner
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_findPartner();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getBitmap("Back_Time",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         this.countDownTxt = ComponentUtil.getTextField("",this,{
            "x":220,
            "y":32,
            "color":16777138,
            "size":18,
            "leading":0
         });
         this.txt = ComponentUtil.getTextField("开始倒计时：",this,{
            "x":111,
            "y":33,
            "color":16776960,
            "size":16,
            "leading":0
         });
         this.findBtn = ComponentUtil.getButton("寻找搭档","Button_XZDD",this,{
            "x":121,
            "y":66,
            "textColor":16580569
         },Global.ADBB_Imgsdm);
         this.findBtn.labelSize = 14;
         this.partner = 0;
         this.status = 0;
         this.findBtn.callBack = function():void
         {
            if(partner == 0)
            {
               View_AiDeBaoBao_partnerMenu.instance.visible = !View_AiDeBaoBao_partnerMenu.instance.visible;
               Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_GET_PARTNER,null);
            }
            else
            {
               View_Alert.show("是否解除当前匹配状态？",2,function():void
               {
                  AiDeBaoBaoCGMessage.CG_AiDeBaoBao_RELIEVE();
               });
            }
         };
         bAutoRemove = false;
      }
      
      private function normalBtn() : void
      {
         this.findBtn.transform.colorTransform = Util.colorNomal;
      }
      
      public function lightBtn() : void
      {
         this.findBtn.transform.colorTransform = new ColorTransform(1,1,1,1,100,100,100,0);
         setTimeout(this.normalBtn,Enum_AiDeBaoBao.GUIDE_SHOW_TIMES);
      }
      
      public function UpdateTime(time:int) : void
      {
         this.beginTime = getTimer();
         this._totalTime = time;
         GameScene.instance.addFrameCallBack(this.onCountDown);
      }
      
      public function onCountDown() : void
      {
         var arrow1:Effect = null;
         var now:int = getTimer();
         var useTime:int = now - this.beginTime;
         this.curTime = this._totalTime - int(useTime / 1000);
         if(this.curTime > 1200)
         {
            this.curTime -= 1200;
            this.countDownTxt.text = String(int(this.curTime / 60)) + ":" + String(this.curTime % 60 + 100).substr(1);
            if(this.status != 1)
            {
               this.status = 1;
               this.txt.text = "开始倒计时：";
            }
            if(this.partner != 0)
            {
               Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_CHECK_SKILL,null);
            }
            if(this.curTime < 10)
            {
               View_AiDeBaoBao_startCountDown.instance.setNumber(this.curTime);
               if(!View_AiDeBaoBao_startCountDown.instance.visible)
               {
                  View_AiDeBaoBao_startCountDown.instance.visible = true;
               }
            }
         }
         else if(this.curTime > 0)
         {
            this.countDownTxt.text = String(int(this.curTime / 60)) + ":" + String(this.curTime % 60 + 100).substr(1);
            if(this.curTime <= 1200 && this.curTime > 1198)
            {
               View_AiDeBaoBao_startCountDown.instance.setNumber(0);
            }
            else if(View_AiDeBaoBao_startCountDown.instance.visible)
            {
               View_AiDeBaoBao_startCountDown.instance.visible = false;
            }
            if(GameUnitManager.hero.status == Status.AiDeBaoBao_Bao)
            {
               Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_SKILL,1);
            }
            if(GameUnitManager.hero.status == Status.AiDeBaoBao_BeiBao)
            {
               Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_SKILL,3);
            }
            if(this.status != 2)
            {
               this.status = 2;
               this.txt.text = "爱情长跑计时：";
               this.arrowEffectArray = [];
               this.arrowEffectArray.push(EffectManager.addEffect("35213",GameScene.gridLayer,1000,6650,3947,true));
               this.arrowEffectArray.push(EffectManager.addEffect("35213",GameScene.gridLayer,1000,6580,3909,true));
               this.arrowEffectArray.push(EffectManager.addEffect("35213",GameScene.gridLayer,1000,6507,3870,true));
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,5172,3944 + 42,true);
               arrow1.scaleY = -1;
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,3883 + 84 + 31,3579 + 42,true);
               arrow1.scaleX = -1;
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,6152 + 84 + 63,2665 + 42 + 50,true);
               arrow1.scaleX = -1;
               arrow1.scaleY = -1;
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,6580 + 64,2038 + 42,true);
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,7029 + 59,908 + 42,true);
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,5244 + 84,337 + 46,true);
               arrow1.scaleY = -1;
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,4689 + 91,1560 + 47,true);
               arrow1.scaleY = -1;
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,3635 + 73,1746 + 42,true);
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,2633 + 84,277 + 42,true);
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,506 + 106,395 + 42,true);
               arrow1.scaleY = -1;
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,744 + 84,1289 + 55,true);
               arrow1.scaleY = -1;
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,730 + 84,2695 + 42,true);
               arrow1.scaleX = -1;
               arrow1.scaleY = -1;
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,2903 + 84,2494 + 42,true);
               arrow1.scaleX = -1;
               arrow1.scaleY = -1;
               this.arrowEffectArray.push(arrow1);
               arrow1 = EffectManager.addEffect("35213",GameScene.gridLayer,1000,2869 + 84,3155 + 52,true);
               arrow1.scaleY = -1;
               this.arrowEffectArray.push(arrow1);
               if(this.partner != 0)
               {
                  Global.control.sendNotification(Enum_AiDeBaoBao.RESET_MAP,Enum_AiDeBaoBao.RESET_MAP);
               }
            }
         }
         else
         {
            this.End();
         }
      }
      
      public function End() : void
      {
         var i:* = undefined;
         GameScene.instance.removeFrameCallBack(this.onCountDown);
         for(i in this.arrowEffectArray)
         {
            EffectManager.removeEffect(this.arrowEffectArray[i]);
         }
         this.countDownTxt.text = "0:00";
         this.visible = false;
         this.status = 0;
         this.partner = 0;
      }
      
      override public function resetPosition() : void
      {
         if(this.isFirstOpen)
         {
            x = (Global.stage.stageWidth - width) / 2;
            y = (Global.stage.stageHeight - height) / 8;
         }
         else
         {
            x = Global.stage.stageWidth - width;
            y = 400;
         }
      }
      
      public function get partner() : Number
      {
         return this._partner;
      }
      
      public function set partner(value:Number) : void
      {
         var i:int = 0;
         this._partner = value;
         if(this._partner == 0)
         {
            this.findBtn.label = "寻找搭档";
            View_AiDeBaoBao_skillBar.instance.visible = false;
            i = 1;
            while(i < 5)
            {
               View_AiDeBaoBao_skillBar.instance.setSkillTimes(i,0);
               i++;
            }
            if(this.status != 2)
            {
               Global.control.sendNotification(Enum_AiDeBaoBao.RESET_MAP,null);
            }
         }
         else
         {
            this.findBtn.label = "解除匹配";
            Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_HIDE,null);
            View_AiDeBaoBao_skillBar.instance.visible = true;
            if(this.status == 2)
            {
               Global.control.sendNotification(Enum_AiDeBaoBao.RESET_MAP,Enum_AiDeBaoBao.RESET_MAP);
            }
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               Tween.curTo(this,2000,{
                  "x":Global.stage.stageWidth - width,
                  "y":400
               });
            }
         }
      }
      
      public function get totalTime() : int
      {
         return this._totalTime;
      }
   }
}

