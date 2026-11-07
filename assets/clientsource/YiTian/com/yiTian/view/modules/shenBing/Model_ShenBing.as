package com.yiTian.view.modules.shenBing
{
   import com.yiTian.Global;
   
   public class Model_ShenBing
   {
      
      public static var heroShenBingVO:Vo_ShenBingAtb;
      
      public static var _curExp:int;
      
      public static var _cardSlotSkills:Array = [];
      
      public static var _idleSkills:Array = [];
      
      public static var _curLevel:int = 1;
      
      public static var _enabledGridIndexs:Array = [];
      
      public static var _cuiLianNotPrompt:Boolean = false;
      
      public static var shenBingLv:int = -1;
      
      public function Model_ShenBing()
      {
         super();
      }
      
      public static function updateShenBing(currentLevel:int, currentExp:int) : void
      {
         _curLevel = currentLevel;
         _curExp = currentExp;
         Global.control.sendNotification(MSG_ShenBing.SHENBING_LV_CHANGE,[_curLevel,_curExp]);
      }
      
      public static function updateCardSlotSkills(useingSkills:Array) : void
      {
         var id:int = 0;
         var vo:Vo_ShenBingSkill = null;
         _cardSlotSkills.splice(0);
         var len:int = int(useingSkills.length);
         var i:int = 0;
         while(i < len)
         {
            id = int(useingSkills[i][1]);
            vo = new Vo_ShenBingSkill();
            vo.posType = Vo_ShenBingSkill.PT_ENABLEDANDVALUE;
            vo.sbIndex = useingSkills[i][0];
            vo.id = useingSkills[i][1];
            vo.gridType = 1;
            vo.init_lib();
            _cardSlotSkills[vo.sbIndex - 1] = vo;
            i += 1;
         }
         Global.control.sendNotification(MSG_ShenBing.CARDSLOT_CHANGE,_cardSlotSkills);
      }
      
      public static function updateIdleSkills(idleSkills:Array) : void
      {
         var vo:Vo_ShenBingSkill = null;
         _idleSkills.splice(0);
         var len:int = int(idleSkills.length);
         var i:int = 0;
         while(i < len)
         {
            vo = new Vo_ShenBingSkill();
            vo.posType = Vo_ShenBingSkill.PT_IDLE;
            vo.sbIndex = idleSkills[i][0];
            vo.id = idleSkills[i][1];
            vo.gridType = 2;
            vo.init_lib();
            _idleSkills[vo.sbIndex - 1] = vo;
            i += 1;
         }
         Global.control.sendNotification(MSG_ShenBing.IDLE_SKILL_CHANGE,_idleSkills);
      }
   }
}

