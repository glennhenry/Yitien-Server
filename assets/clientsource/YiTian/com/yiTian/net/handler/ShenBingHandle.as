package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.shenBing.MSG_ShenBing;
   import com.yiTian.view.modules.shenBing.Model_ShenBing;
   import com.yiTian.view.modules.shenBing.ShenBingUtil;
   import flash.geom.Point;
   
   public class ShenBingHandle
   {
      
      private static var _bm:Bitmap2;
      
      public function ShenBingHandle()
      {
         super();
      }
      
      public static function GC_SHENBING(currentLevel:int, currentExp:int, useingSkills:Array, idleSkills:Array) : void
      {
         if(currentLevel > Model_ShenBing._curLevel)
         {
            Global.control.sendNotification(MSG_ShenBing.CUIRLIAN_LEVEL_UP,null);
         }
         Model_ShenBing.shenBingLv = useingSkills.length;
         Model_ShenBing.updateShenBing(currentLevel,currentExp);
         Model_ShenBing.updateCardSlotSkills(useingSkills);
         Model_ShenBing.updateIdleSkills(idleSkills);
      }
      
      public static function GC_SB_SWAP_SKILL(result:int) : void
      {
         var msg:String = null;
         if(result != 1)
         {
            if(result == 2)
            {
               msg = "您身上已携带该种类的神兵技能";
            }
         }
         if(msg != null)
         {
            UIManager.centerBroadcast.addMsg(msg);
         }
      }
      
      public static function GC_CUILIAN(result:int, currentLevel:int, currentExp:int) : void
      {
         var msg:String = null;
         if(result == 1)
         {
            msg = "淬炼成功";
         }
         else if(result != 2)
         {
            if(result == 3)
            {
            }
         }
         if(msg != null)
         {
            UIManager.centerBroadcast.addMsg(msg);
         }
      }
      
      public static function GC_SHENBING_UPDATE_SKILL(result:int) : void
      {
         var msg:String = null;
         if(result == 1)
         {
            Global.control.sendNotification(MSG_ShenBing.SB_SKILL_UPDATE_SUCCESS,null);
         }
         else if(result == 2)
         {
            msg = "升级失败,等级已达最高";
         }
         else if(result == 3)
         {
            msg = LangConfig.reTxt("升级失败，您的{0}不足",Data_lib.item[ShenBingUtil.SHENBING_CHIP_ID][Enum_lib_item.STR_NAME]);
         }
         else if(result == 4)
         {
            msg = "银子不足";
         }
         if(msg != null)
         {
            UIManager.centerBroadcast.addMsg(msg);
         }
      }
      
      public static function GC_SHENBING_BUY_SKILL(result:int, id:int) : void
      {
         var msg:String = null;
         var step1:ComboTweenStep = null;
         var centerX:Number = NaN;
         var centerY:Number = NaN;
         var step2:ComboTweenStep = null;
         var targetPoint:Point = null;
         if(result == 1)
         {
            step1 = new ComboTweenStep();
            centerX = Global.stage.stageWidth / 2;
            centerY = Global.stage.stageHeight / 2;
            step1.property = {
               "x":[centerX,centerX],
               "y":[centerY,centerY - 100]
            };
            step1.time = 400;
            step1.tweenType = Tween.SIN;
            _bm = _bm || new Bitmap2();
            _bm.load(ShenBingUtil.getIconUrl(id));
            GameScene.upUILayer.addChild(_bm);
            step2 = new ComboTweenStep();
            step2.time = 800;
            step2.tweenType = Tween.SIN;
            targetPoint = ShenBingUtil._tipBtn.localToGlobal(new Point(0,0));
            step2.property = {
               "x":[centerX,targetPoint.x],
               "y":[centerY - 100,targetPoint.y]
            };
            step2.endFun = twnComplete;
            step1.next = step2;
            Tween.playComboStep(_bm,step1);
            msg = "购买成功";
         }
         else if(result == 2)
         {
            msg = "购买失败，神兵技能背包已满";
         }
         else if(result == 3)
         {
            msg = LangConfig.reTxt("购买失败，您的{0}不足",Data_lib.item[ShenBingUtil.SHENBING_CHIP_ID][Enum_lib_item.STR_NAME]);
         }
         else if(result == 4)
         {
            msg = LangConfig.reTxt("购买失败，您不能同时拥有相同类型的神兵技能");
         }
         if(msg != null)
         {
            UIManager.centerBroadcast.addMsg(msg);
         }
      }
      
      private static function twnComplete() : void
      {
         if(Boolean(_bm.parent))
         {
            _bm.parent.removeChild(_bm);
         }
      }
      
      public static function GC_SHENBING_GRID_ENABELD(gridIndex:int) : void
      {
         if(Model_ShenBing._enabledGridIndexs.indexOf(gridIndex) == -1)
         {
            Model_ShenBing._enabledGridIndexs.push(gridIndex);
         }
         Global.control.sendNotification(MSG_ShenBing.GRID_ENABLED,null);
      }
   }
}

