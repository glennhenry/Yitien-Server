package com.yiTian.effects
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.Tween;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   
   public class Effect_quest
   {
      
      public static const ACCEPT_QUEST:String = "accept";
      
      public static const FINISH_QUEST:String = "finish";
      
      private var bm:DisplayObject;
      
      private var light:DisplayObject;
      
      private var mask:DisplayObject;
      
      private var initWid:int = 164;
      
      private var initHei:int = 50;
      
      private var initY:int = -250;
      
      public function Effect_quest()
      {
         super();
      }
      
      public static function getItem() : Effect_quest
      {
         return new Effect_quest();
      }
      
      public function play(type:String) : void
      {
         var eff:Effect;
         this.bm = ComponentUtil.getDisplayObject(type,null,null,Global.effectWord);
         this.bm.x = -this.initWid / 2;
         this.bm.y = this.initY;
         this.light = ComponentUtil.getDisplayObject("back",null,null,Global.effectWord);
         this.light.alpha = 0.5;
         this.light.y = this.initY;
         this.light.blendMode = BlendMode.ADD;
         this.mask = ComponentUtil.getDisplayObject(type,null,null,Global.effectWord);
         this.mask.x = -this.initWid / 2;
         this.mask.y = this.initY;
         GameUnitManager.hero.addChild(this.bm);
         this.bm.alpha = 1;
         GameUnitManager.hero.addChild(this.light);
         GameUnitManager.hero.addChild(this.mask);
         this.light.mask = this.mask;
         eff = GameUnitManager.hero.addEffect("35070",false,0,-230,1000,-1,null);
         eff.blendMode = BlendMode.ADD;
         Tween.to(this.light,600,{"x":[-this.initWid / 2 - 60,this.initWid / 2]},function():void
         {
            if(GameUnitManager.hero.contains(light))
            {
               GameUnitManager.hero.removeChild(light);
               light = null;
            }
            if(GameUnitManager.hero.contains(mask))
            {
               GameUnitManager.hero.removeChild(mask);
               mask = null;
            }
            Tween.to(bm,400,{"alpha":[1,0.5]},function():void
            {
               if(GameUnitManager.hero.contains(bm))
               {
                  GameUnitManager.hero.removeChild(bm);
                  bm = null;
               }
            });
         });
      }
   }
}

