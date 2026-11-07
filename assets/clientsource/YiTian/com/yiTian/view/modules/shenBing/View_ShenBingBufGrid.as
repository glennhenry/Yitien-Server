package com.yiTian.view.modules.shenBing
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Pool;
   import com.yiTian.view.modules.guangMingDing.View_MiJiGrid;
   import flash.events.MouseEvent;
   
   public class View_ShenBingBufGrid extends View_MiJiGrid
   {
      
      private var __vo:Vo_ShenBingBattleBuff;
      
      private var _bmIcon:Bitmap2;
      
      public function View_ShenBingBufGrid()
      {
         super();
         this._bmIcon = new Bitmap2();
         addChild(this._bmIcon);
         addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
      }
      
      public static function getObj2() : View_ShenBingBufGrid
      {
         return Pool.getObject(View_ShenBingBufGrid);
      }
      
      protected function rollOutHandler(event:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      protected function mouseMoveHandler(event:MouseEvent) : void
      {
         TipManager.update("<font color=\'#ffff33\'>" + Data_lib.sbSkill[this.__vo.id][Enum_ShenBing.SKILL_NAME] + "(等级：" + Data_lib.sbSkill[this.__vo.id][Enum_ShenBing.SKILL_QUALITY] + ")</font>" + "\n" + Data_lib.buffer[this.__vo.id][Vo_Buffer.DISCRIPT]);
      }
      
      override public function dispose() : void
      {
         Pool.saveObject(this);
      }
      
      override public function set vo(vo:Object) : void
      {
         this.__vo = vo as Vo_ShenBingBattleBuff;
         this._bmIcon.load("resource/image/shenBing/battleIcon/" + Data_lib.sbSkill[this.__vo.id][Enum_ShenBing.SKILL_ICON] + "_20.png");
      }
      
      override public function get vo() : Object
      {
         return this.__vo;
      }
   }
}

