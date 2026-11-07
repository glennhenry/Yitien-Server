package com.yiTian.view.modules.newYear
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.NewYearCGMessage;
   import com.yiTian.net.message.gc.NewYearGCMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class Config_NewYear
   {
      
      private static var tipBtn:BitmapBtn;
      
      public static var jsParam:int;
      
      public static const NIANGAOID:int = 44476;
      
      public static const NEEDLV:int = 30;
      
      public static const NIANSHOUMODELID:int = 56503;
      
      public static const NIANSHOUSCALE:Number = 1;
      
      public static const NIANSHOUDIRECTION:int = 4;
      
      private static var isUseing:Boolean = false;
      
      private static var _isInit:Boolean = false;
      
      public static const NIANSHOUTOKENID:Array = [0,10,20,40,80];
      
      private static var mul:Array = [1,1.25,1.5,1.75,2];
      
      private static var nianShouWalkBound:Rectangle = new Rectangle(365 - 100,270 - 100,200,100);
      
      public function Config_NewYear()
      {
         super();
      }
      
      public static function get isInit() : Boolean
      {
         isUseing = true;
         return true;
      }
      
      public static function init() : void
      {
         isUseing = true;
         update();
      }
      
      public static function ActSwitch(param:Object) : void
      {
         jsParam = int(param);
         update();
      }
      
      private static function update() : void
      {
         if(!isUseing)
         {
            return;
         }
         if(jsParam > 0)
         {
            if(GameUnitManager.hero.level >= 30)
            {
               new NewYearGCMessage(SocketManager.index);
               if(!tipBtn)
               {
                  tipBtn = new BitmapBtn();
                  tipBtn.init();
                  tipBtn.setBgDir("resource/image/newYear/yuanxiaoIcon.png");
                  tipBtn.buttonMode = true;
                  tipBtn.clickCallBack = tipClick;
                  tipBtn.extraObject = EffectManager.addEffect("35343",tipBtn,1000,32,29,true);
                  _isInit = true;
               }
               UIManager.mainUiBtnContainer.addBTN(tipBtn);
            }
            else
            {
               Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,heroLvUpHd);
            }
         }
         else if(_isInit)
         {
            if(Boolean(tipBtn))
            {
               UIManager.mainUiBtnContainer.removeBTN(tipBtn);
               if(Boolean(tipBtn.extraObject))
               {
                  EffectManager.removeEffect(tipBtn.extraObject as Effect);
                  tipBtn.extraObject = null;
               }
            }
            if(Singleton.hasInstance(View_newYearActPnl))
            {
               (Singleton.getInstance(View_newYearActPnl) as View_newYearActPnl).hide();
            }
         }
      }
      
      private static function heroLvUpHd(heroLv:int) : void
      {
         if(heroLv >= 30)
         {
            if(jsParam > 0)
            {
               update();
            }
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,heroLvUpHd);
         }
      }
      
      private static function tipClick(e:MouseEvent) : void
      {
         var targetPnl:View_newYearActPnl = null;
         targetPnl = Singleton.getInstance(View_newYearActPnl);
         if(Boolean(tipBtn.extraObject))
         {
            EffectManager.removeEffect(tipBtn.extraObject as Effect);
            tipBtn.extraObject = null;
         }
         Global.delegate.dosomething(targetPnl,function():void
         {
            if(!targetPnl.visible)
            {
               targetPnl.show();
               NewYearCGMessage.CG_SMS_GET_INDEX();
            }
            else
            {
               targetPnl.hide();
            }
         });
      }
      
      public static function getDefaultMailVos() : Array
      {
         var info:Array = null;
         var id:int = 0;
         var vo:Vo_valuable = null;
         var r:Array = [];
         var i:int = 1;
         while(i <= 9)
         {
            info = Data_lib.cjsc[i];
            id = int(info[0]);
            if(id >= 50000)
            {
               vo = new Vo_equip();
               vo.id = info[0];
               (vo as Vo_equip).Init_lib();
            }
            else
            {
               vo = new Vo_item();
               vo.id = info[0];
               (vo as Vo_item).Init_lib();
            }
            r.push(vo);
            i += 1;
         }
         return r;
      }
      
      public static function getDefualtPrices() : Array
      {
         var info:Array = null;
         var r:Array = [];
         var i:int = 1;
         while(i <= 9)
         {
            info = Data_lib.cjsc[i];
            r.push(info[1]);
            i += 1;
         }
         return r;
      }
      
      public static function getGainExp(tokenIndex:int) : int
      {
         var heroLv:int = GameUnitManager.hero.level;
         if(heroLv < 30)
         {
            return 0;
         }
         var baseExp:int = int(Data_lib.jljy[heroLv][0]);
         return baseExp * mul[tokenIndex];
      }
   }
}

