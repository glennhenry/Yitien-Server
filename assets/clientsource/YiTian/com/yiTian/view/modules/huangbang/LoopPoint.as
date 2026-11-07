package com.yiTian.view.modules.huangbang
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.message.cg.QuestCGMessage;
   import com.yiTian.scene.GameScene;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   
   public class LoopPoint extends Role
   {
      
      public static var pool:Array = [];
      
      public static var list:Dictionary = new Dictionary();
      
      public var nextPointId:Number;
      
      private var nextPoint:LoopPoint;
      
      private var pointType:int;
      
      private var typeArr:Array = [0,1,2,3,4,5];
      
      private var typeStartEffArr:Array = [0,35255,35257,35263,35259,35261];
      
      private var typeEffArr:Array = [0,35227,35229,35231,35228,35230];
      
      private var typeEndEffArr:Array = [0,35256,35258,35264,35260,35262];
      
      public var eff:Effect;
      
      private var effBmp:Bitmap;
      
      public function LoopPoint()
      {
         super();
      }
      
      public function init(id:Number, x:int, y:int, type:int) : void
      {
         this.id = id;
         global_x = x;
         global_y = y;
         this.pointType = type;
         this.addEff();
      }
      
      public function addEff() : void
      {
         if(!this.eff && this.pointType > 0)
         {
            this.eff = EffectManager.addEffect(this.typeStartEffArr[this.pointType],GameScene.gridLayer,1000,global_x,global_y,false,3,this.showEff);
         }
      }
      
      private function showEff() : void
      {
         this.eff = EffectManager.addEffect(this.typeEffArr[this.pointType],GameScene.gridLayer,750,global_x,global_y,true);
      }
      
      override public function interaction(mode:int = 0) : void
      {
         var pos:int = 0;
         GameUnitManager.hero.lockTarget = null;
         GameUnitManager.hero.global_x = this.x;
         GameUnitManager.hero.global_y = this.y;
         GameUnitManager.hero.align();
         if(!Model_Huangbang.routeArr || !Model_Huangbang.routeArr.length)
         {
            if(Model_Huangbang.isLink == true)
            {
               GameUnitManager.hero.way = 4;
               View_HuangbangInfoPanel.instance.jumpPoint(Model_Huangbang.linkPoint.x,Model_Huangbang.linkPoint.y);
               Global.control.sendNotification(Enum_Huangbang.SHOW_ALLPOINT,null);
               Model_Huangbang.canClickShake = true;
            }
            else
            {
               QuestCGMessage.CG_QUEST_ACCEPT(Model_Huangbang.currentQuestId);
               GameUnitManager.hero.way = 4;
               Model_Huangbang.canAccept = true;
               Global.control.sendNotification(Enum_Huangbang.GOBACK_START,null);
               Model_Huangbang.canClickShake = true;
               Model_Huangbang.heroStandPoint = this;
               GameUnitManager.removeUnit(this);
            }
         }
         else
         {
            pos = Model_Huangbang.routeArr.shift();
            this.nextPoint = GameUnitManager.findUnit(Enum_Huangbang.HUANGBANG_NUM + pos,UnitType.HUANGBANG_POINT) as LoopPoint;
            if(!this.nextPoint)
            {
               return;
            }
            GameUnitManager.hero.lockTarget = this.nextPoint;
            Model_Huangbang.Shaker = true;
            GameUnitManager.hero.go(this.nextPoint.x,this.nextPoint.y);
            Model_Huangbang.Shaker = false;
         }
      }
      
      override public function show() : void
      {
         super.show();
         list[id] = this;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(Boolean(this.eff) && Boolean(this.eff.parent))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = EffectManager.addEffect(this.typeEndEffArr[this.pointType],GameScene.gridLayer,500,global_x,global_y,false,3,function():void
            {
               eff = null;
            });
         }
         delete list[id];
         pool.push(this);
      }
   }
}

